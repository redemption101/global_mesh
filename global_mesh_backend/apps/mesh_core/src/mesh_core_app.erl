-module(mesh_core_app).
-behaviour(application).
-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    io:format("~n[MESH CORE] Initializing Mesh Database System...~n"),
    % Initialize database
    mesh_database:init(),
    mesh_supervisor:start_link().

stop(_State) ->
    ok.
