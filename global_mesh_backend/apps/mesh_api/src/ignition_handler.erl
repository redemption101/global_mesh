-module(ignition_handler).
-export([init/2]).

init(Req0, State) ->
    Method = cowboy_req:method(Req0),
    handle_method(Method, Req0, State).

% Handle POST requests with deployment payloads
handle_method(<<"POST">>, Req0, State) ->
    io:format("[API] POST Ignition Request Received...~n"),
    
    % Read request body
    {ok, Body, Req1} = cowboy_req:read_body(Req0),
    
    % Parse JSON payload
    try jiffy:decode(Body) of
        Payload ->
            ArchitectureId = maps:get(<<"architectureId">>, Payload, <<"UNKNOWN">>),
            Timestamp = maps:get(<<"timestamp">>, Payload, 0),
            
            io:format("[API] Architecture ID: ~s, Timestamp: ~w~n", [ArchitectureId, Timestamp]),
            
            % Generate 512-bit secure token using the Rust NIF
            DevId = <<"Vundla_Terminal_01">>,
            JwtBinary = mesh_crypto:generate_lockdown_jwt(DevId),
            
            % Route data to Supersonic Database
            mesh_data_router:supersonic_write(ArchitectureId, <<"Payload_Data">>, JwtBinary),
            
            ResponseJson = jiffy:encode(#{
                <<"status">> => <<"DEPLOYED_SUCCESSFULLY">>,
                <<"lockdown_key">> => JwtBinary,
                <<"message">> => <<"Architecture sealed and propagated to CockroachDB Multi-Master layer.">>,
                <<"architectureId">> => ArchitectureId,
                <<"timestamp">> => Timestamp
            }),
            
            Req = cowboy_req:reply(200, 
                #{<<"content-type">> => <<"application/json">>,
                  <<"access-control-allow-origin">> => <<"*">>}, 
                ResponseJson, Req1),
            {ok, Req, State}
    catch
        _:Error ->
            io:format("[API] Error parsing request body: ~w~n", [Error]),
            ErrorJson = jiffy:encode(#{
                <<"status">> => <<"ERROR">>,
                <<"message">> => <<"Failed to parse request payload">>
            }),
            Req = cowboy_req:reply(400,
                #{<<"content-type">> => <<"application/json">>,
                  <<"access-control-allow-origin">> => <<"*">>},
                ErrorJson, Req0),
            {ok, Req, State}
    end;

% Handle GET requests (health check or simple deployment)
handle_method(<<"GET">>, Req0, State) ->
    io:format("[API] GET Ignition Request Received (Health Check)...~n"),
    
    % Generate 512-bit secure token using the Rust NIF
    DevId = <<"Vundla_Terminal_01">>,
    JwtBinary = mesh_crypto:generate_lockdown_jwt(DevId),
    
    % Route data to Supersonic Database
    mesh_data_router:supersonic_write(<<"ARCH-NEW">>, <<"Payload_Data">>, JwtBinary),
    
    ResponseJson = jiffy:encode(#{
        <<"status">> => <<"DEPLOYED_SUCCESSFULLY">>,
        <<"lockdown_key">> => JwtBinary,
        <<"message">> => <<"Architecture sealed and propagated to CockroachDB Multi-Master layer.">>
    }),
    
    Req = cowboy_req:reply(200, 
        #{<<"content-type">> => <<"application/json">>,
          <<"access-control-allow-origin">> => <<"*">>}, 
        ResponseJson, Req0),
        
    {ok, Req, State};

% Handle OPTIONS requests (CORS preflight)
handle_method(<<"OPTIONS">>, Req0, State) ->
    Req = cowboy_req:reply(200,
        #{<<"access-control-allow-origin">> => <<"*">>,
          <<"access-control-allow-methods">> => <<"GET, POST, OPTIONS">>,
          <<"access-control-allow-headers">> => <<"Content-Type">>,
          <<"access-control-max-age">> => <<"3600">>},
        <<>>, Req0),
    {ok, Req, State};

% Handle unsupported methods
handle_method(_, Req0, State) ->
    Req = cowboy_req:reply(405,
        #{<<"content-type">> => <<"application/json">>,
          <<"access-control-allow-origin">> => <<"*">>},
        jiffy:encode(#{<<"error">> => <<"Method not allowed">>}), Req0),
    {ok, Req, State}.
