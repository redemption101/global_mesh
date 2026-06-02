-module(mesh_supervisor).
-behaviour(supervisor).

-export([start_link/0, init/1]).

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
    %% If a node fails, restart it immediately (Fault Tolerance)
    SupFlags = #{strategy => one_for_all, intensity => 10000, period => 1},
    
    DataRouter = #{id => mesh_data_router,
                   start => {mesh_data_router, start_link, []},
                   restart => permanent,
                   shutdown => 5000,
                   type => worker,
                   modules => [mesh_data_router]},
                   
    NewtonGuard = #{id => newtonian_guard,
                    start => {newtonian_guard, start_link, []},
                    restart => permanent,
                    shutdown => 5000,
                    type => worker,
                    modules => [newtonian_guard]},

    {ok, {SupFlags, [DataRouter, NewtonGuard]}}.
