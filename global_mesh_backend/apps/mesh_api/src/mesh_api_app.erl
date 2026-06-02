-module(mesh_api_app).
-behaviour(application).
-export([start/2, stop/1]).

start(_Type, _Args) ->
    io:format("~n[API GATEWAY] Initializing Aetherion Cowboy Server on Port 4000...~n"),
    
    % Initialize database
    mesh_database:init(),
    
    Dispatch = cowboy_router:compile([
        {'_', [
            %% Serve the pure HTML frontend on the root path
            {"/", cowboy_static, {priv_file, mesh_api, "index.html"}},
            
            %% Backend API endpoints
            {"/api/ignition", ignition_handler, []},
            
            %% Seed/Database endpoints
            {"/api/seed", seed_handler, []},
            {"/api/seed/stats", seed_handler, []},
            {"/api/seed/sovereign", seed_handler, []},
            {"/api/seed/founders", seed_handler, []},
            {"/api/seed/entities", seed_handler, []}
        ]}
    ]),
    
    {ok, _} = cowboy:start_clear(http, [{port, 4000}], #{env => #{dispatch => Dispatch}}),
    mesh_api_sup:start_link().

stop(_State) -> ok.
