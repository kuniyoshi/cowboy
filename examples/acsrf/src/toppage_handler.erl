-module(toppage_handler).
-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

init(_Transport, Req, []) ->
    {ok, Req, undefined}.

handle(Req, State) ->
    Html = <<"<html><head><title>ACSRF</title></head><body><form></form></body></html>">>,
    Req2 = cowboy_req:set_resp_body(Html, Req),
    {ok, Req2, State}.

terminate(_Reason, _Req, _State) ->
    ok.
