-module(acsrf_app).
-behaviour(application).
-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
    Dispatch = cowboy_router:compile([{'_',
                                       [{"/", toppage_handler, []}]}]),
    {ok, _} = cowboy:start_http(http,
                                100,
                                [{port, 8080}],
                                [{env, [{dispatch, Dispatch}]},
                                 {onresponse, fun acsrf:protect/4}]),
    acsrf_sup:start_link().

stop(_State) ->
    ok.
