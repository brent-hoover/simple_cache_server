-module(sc_server_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    sc_store:init(),
    case sc_server_sup:start_link() of
	{ok, Pid} ->
	    {ok, Pid};
	Other ->
	    {error, Other}
    end.

stop(_State) ->
    ok.
