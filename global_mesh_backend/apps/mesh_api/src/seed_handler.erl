-module(seed_handler).
-export([init/2]).

init(Req0, State) ->
    Method = cowboy_req:method(Req0),
    Path = cowboy_req:path(Req0),
    handle_route(Method, Path, Req0, State).

% POST /api/seed - Seed the database with all data
handle_route(<<"POST">>, <<"/api/seed">>, Req0, State) ->
    io:format("[API] POST /api/seed - Seeding database...~n"),
    
    % Initialize database
    mesh_database:init(),
    
    % Get seed data
    SeedData = mesh_seed_data:seed_all(),
    
    % Seed the database
    mesh_database:seed_from_data(SeedData),
    
    % Get statistics
    Stats = mesh_database:get_stats(),
    
    Response = jiffy:encode(#{
        <<"status">> => <<"SEEDING_COMPLETE">>,
        <<"message">> => <<"Database successfully seeded with all entities">>,
        <<"statistics">> => Stats,
        <<"timestamp">> => erlang:system_time(millisecond)
    }),
    
    Req = cowboy_req:reply(200,
        #{<<"content-type">> => <<"application/json">>,
          <<"access-control-allow-origin">> => <<"*">>},
        Response, Req0),
    {ok, Req, State};

% GET /api/seed/stats - Get database statistics
handle_route(<<"GET">>, <<"/api/seed/stats">>, Req0, State) ->
    Stats = mesh_database:get_stats(),
    
    Response = jiffy:encode(#{
        <<"status">> => <<"OK">>,
        <<"statistics">> => Stats,
        <<"timestamp">> => erlang:system_time(millisecond)
    }),
    
    Req = cowboy_req:reply(200,
        #{<<"content-type">> => <<"application/json">>,
          <<"access-control-allow-origin">> => <<"*">>},
        Response, Req0),
    {ok, Req, State};

% GET /api/seed/sovereign - Get sovereign architects
handle_route(<<"GET">>, <<"/api/seed/sovereign">>, Req0, State) ->
    Architects = mesh_database:get_sovereign_architects(),
    
    Response = jiffy:encode(#{
        <<"status">> => <<"OK">>,
        <<"sovereign_architects">> => Architects,
        <<"count">> => length(Architects),
        <<"timestamp">> => erlang:system_time(millisecond)
    }),
    
    Req = cowboy_req:reply(200,
        #{<<"content-type">> => <<"application/json">>,
          <<"access-control-allow-origin">> => <<"*">>},
        Response, Req0),
    {ok, Req, State};

% GET /api/seed/founders - Get co-founders
handle_route(<<"GET">>, <<"/api/seed/founders">>, Req0, State) ->
    Founders = mesh_database:get_co_founders(),
    
    Response = jiffy:encode(#{
        <<"status">> => <<"OK">>,
        <<"co_founders">> => Founders,
        <<"count">> => length(Founders),
        <<"timestamp">> => erlang:system_time(millisecond)
    }),
    
    Req = cowboy_req:reply(200,
        #{<<"content-type">> => <<"application/json">>,
          <<"access-control-allow-origin">> => <<"*">>},
        Response, Req0),
    {ok, Req, State};

% GET /api/seed/entities - Get all entities
handle_route(<<"GET">>, <<"/api/seed/entities">>, Req0, State) ->
    Entities = mesh_database:get_entities(),
    
    Response = jiffy:encode(#{
        <<"status">> => <<"OK">>,
        <<"entities">> => Entities,
        <<"count">> => length(Entities),
        <<"timestamp">> => erlang:system_time(millisecond)
    }),
    
    Req = cowboy_req:reply(200,
        #{<<"content-type">> => <<"application/json">>,
          <<"access-control-allow-origin">> => <<"*">>},
        Response, Req0),
    {ok, Req, State};

% OPTIONS - CORS preflight
handle_route(<<"OPTIONS">>, _, Req0, State) ->
    Req = cowboy_req:reply(200,
        #{<<"access-control-allow-origin">> => <<"*">>,
          <<"access-control-allow-methods">> => <<"GET, POST, OPTIONS">>,
          <<"access-control-allow-headers">> => <<"Content-Type">>,
          <<"access-control-max-age">> => <<"3600">>},
        <<>>, Req0),
    {ok, Req, State};

% Catch-all
handle_route(_, _, Req0, State) ->
    Response = jiffy:encode(#{
        <<"status">> => <<"NOT_FOUND">>,
        <<"message">> => <<"Endpoint not found">>
    }),
    
    Req = cowboy_req:reply(404,
        #{<<"content-type">> => <<"application/json">>,
          <<"access-control-allow-origin">> => <<"*">>},
        Response, Req0),
    {ok, Req, State}.
