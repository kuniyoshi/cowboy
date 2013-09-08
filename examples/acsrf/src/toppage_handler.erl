-module(toppage_handler).
-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

init(_Transport, Req, []) ->
    {ok, Req, undefined}.

handle(Req, State) ->
    Html = <<"<html><head><title>ACSRF</title></head><body><form></form></body></html>">>,
    {ok, Req2} = cowboy_req:reply(200, [], Html, Req),
    {ok, Req2, State}.

terminate(_Reason, _Req, _State) ->
    ok.
