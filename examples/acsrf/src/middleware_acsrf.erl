-module(middleware_acsrf).
-export([encrypt/1, encrypt/2]).
-export([hide/2, hide/3]).
-export([execute/2]).
-define(ACSRF_KEY, <<"AL8sEOAL8Sftk9x_F6tmpodLvy2xxCV4">>).
-define(ACSRF_NAME, atom_to_binary(?MODULE, utf8)).

encrypt(Data) ->
    encrypt(Data, ?ACSRF_KEY).

encrypt(Data, Key) ->
    base64:encode(crypto:hmac(sha256, Key, Data)).

hide(Html, Key) ->
    hide(Html, Key, []).

hide(Html, Key, Options) ->
    Options2 = lists:keymerge(1, Options, [{acsrf_key, ?ACSRF_KEY}, {acsrf_name, ?ACSRF_NAME}]),
    {acsrf_key, AcsrfKey} = lists:keyfind(acsrf_key, 1, Options2),
    {acsrf_name, AcsrfName} = lists:keyfind(acsrf_name, 1, Options2),
    Encrypted = ?MODULE:encrypt(Key, AcsrfKey),
    re:replace(Html,
               <<"[<]/form[>]">>,
               [<<"<input type=\"hidden\" name=\"">>,
                AcsrfName,
                <<"\" value=\"">>,
                Encrypted,
                <<"\"></form>">>],
               [global]).

execute(Req, Env) ->
    Html = cowboy_req:get(resp_body, Req),
    SessionId = <<"pRlm_E5c1ruzdItraQjQe1oUWAe1gxdF">>,
    Html2 = hide(Html, SessionId),
    cowboy_req:reply(200, [], Html2, Req),
    {ok, Req, Env}.
