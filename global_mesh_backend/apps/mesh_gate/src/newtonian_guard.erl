-module(newtonian_guard).
-behaviour(gen_server).

-export([start_link/0, evaluate_vector/2]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) ->
    io:format("[NEWTONIAN GUARD] Physics-based AI security layer online. Void Honeypot active.~n"),
    {ok, #{threats_neutralized => 0}}.

evaluate_vector(PayloadId, VectorStrength) ->
    gen_server:call(?MODULE, {inspect, PayloadId, VectorStrength}).

handle_call({inspect, PayloadId, VectorStrength}, _From, State) ->
    %% Newton's 3rd Law Defense Metric
    ReactionForce = VectorStrength * -1,
    case VectorStrength > 9000 of
        true ->
            io:format("[GUARD ALERT] Critical Exploit Vector ~p detected! Diverting to Void Honeypot. Reaction Force: ~p~n", [PayloadId, ReactionForce]),
            NewState = maps:update_with(threats_neutralized, fun(V) -> V + 1 end, 1, State),
            {reply, {diverted, honeypot_locked}, NewState};
        false ->
            io:format("[GUARD CHECK] Payload ~p stabilized. Routing to Data Matrix.~n", [PayloadId]),
            {reply, {safe, proceed_to_db}, State}
    end;

handle_call(_Request, _From, State) -> {reply, ok, State}.
handle_cast(_Msg, State) -> {noreply, State}.
handle_info(_Info, State) -> {noreply, State}.
terminate(_Reason, _State) -> ok.
code_change(_OldVsn, State, _Extra) -> {ok, State}.
