-module(mesh_database).
-export([init/0, insert_sovereign_architect/1, insert_co_founder/1, insert_entity/1, 
         get_sovereign_architects/0, get_co_founders/0, get_entities/0,
         seed_from_data/1]).

% In-memory storage (for MVP - replace with CockroachDB later)
-define(SOVEREIGN_TABLE, sovereign_architects).
-define(FOUNDERS_TABLE, co_founders).
-define(ENTITIES_TABLE, mesh_entities).

% Initialize ETS tables
init() ->
    case ets:whereis(?SOVEREIGN_TABLE) of
        undefined ->
            ets:new(?SOVEREIGN_TABLE, [named_table, public, set]),
            ets:new(?FOUNDERS_TABLE, [named_table, public, set]),
            ets:new(?ENTITIES_TABLE, [named_table, public, set]),
            io:format("[DATABASE] ETS tables initialized~n"),
            ok;
        _ ->
            io:format("[DATABASE] Tables already exist~n"),
            ok
    end.

% Insert sovereign architect
insert_sovereign_architect(Data) when is_map(Data) ->
    ID = maps:get(id, Data),
    ets:insert(?SOVEREIGN_TABLE, {ID, Data}),
    io:format("[DB] Inserted Sovereign Architect: ~s~n", [ID]),
    {ok, ID}.

% Insert co-founder
insert_co_founder(Data) when is_map(Data) ->
    ID = maps:get(id, Data),
    ets:insert(?FOUNDERS_TABLE, {ID, Data}),
    io:format("[DB] Inserted Co-Founder: ~s~n", [ID]),
    {ok, ID}.

% Insert entity
insert_entity(Data) when is_map(Data) ->
    ID = maps:get(id, Data),
    ets:insert(?ENTITIES_TABLE, {ID, Data}),
    {ok, ID}.

% Retrieve sovereign architects
get_sovereign_architects() ->
    [Data || {_ID, Data} <- ets:tab2list(?SOVEREIGN_TABLE)].

% Retrieve co-founders
get_co_founders() ->
    [Data || {_ID, Data} <- ets:tab2list(?FOUNDERS_TABLE)].

% Retrieve all entities
get_entities() ->
    [Data || {_ID, Data} <- ets:tab2list(?ENTITIES_TABLE)].

% Seed database from seed data
seed_from_data({SovereignArchitects, CoFounders, Entities}) ->
    io:format("[DATABASE SEEDING] Starting...~n"),
    
    % Seed sovereign architects
    lists:foreach(fun(Architect) ->
        insert_sovereign_architect(Architect)
    end, SovereignArchitects),
    
    % Seed co-founders
    lists:foreach(fun(Founder) ->
        insert_co_founder(Founder)
    end, CoFounders),
    
    % Seed entities (flatten if nested)
    lists:foreach(fun(Entity) ->
        case is_list(Entity) of
            true -> lists:foreach(fun(E) -> insert_entity(E) end, Entity);
            false -> insert_entity(Entity)
        end
    end, Entities),
    
    io:format("[DATABASE SEEDING] Complete! Sovereign Architects: ~w, Co-Founders: ~w, Entities: ~w~n",
              [length(SovereignArchitects), length(CoFounders), length(lists:flatten(Entities))]),
    ok.

% Get statistics
get_stats() ->
    #{
        sovereign_architects => length(get_sovereign_architects()),
        co_founders => length(get_co_founders()),
        entities => length(get_entities())
    }.
