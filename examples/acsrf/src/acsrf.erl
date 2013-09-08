-module(acsrf).
-export([encrypt/1, encrypt/2]).
-export([hide/2, hide/3]).
-export([protect/4]).
-define(ACSRF_KEY, <<"AL8sEOAL8Sftk9x_F6tmpodLvy2xxCV4">>).
-define(ACSRF_NAME, atom_to_binary(?MODULE, utf8)).

encrypt(Data) ->
    encrypt(Data, ?ACSRF_KEY).

encrypt(Data, Key) ->
    base64:encode(crypto:hmac(sha256, Key, Data)).

protection_value(AcsrfName, Encrypted) ->
    OpenTag = <<"<input type=\"hidden\" name=\"">>,
    Attribute = <<"\" value=\"">>,
    CloseTag = <<"\"></form>">>,
    <<OpenTag/binary, AcsrfName/binary, Attribute/binary, Encrypted/binary, CloseTag/binary>>.

hide(Html, Key) ->
    hide(Html, Key, []).

hide(Html, Key, Options) ->
    Options2 = lists:keymerge(1, Options, [{acsrf_key, ?ACSRF_KEY}, {acsrf_name, ?ACSRF_NAME}]),
    {acsrf_key, AcsrfKey} = lists:keyfind(acsrf_key, 1, Options2),
    {acsrf_name, AcsrfName} = lists:keyfind(acsrf_name, 1, Options2),
    Encrypted = ?MODULE:encrypt(Key, AcsrfKey),
    Replaced = protection_value(AcsrfName, Encrypted),
    Html2 = binary:replace(Html, <<"</form>">>, Replaced, [global]),
    Html2.

protect(200, Headers, Body, Req) ->
    SessionId = <<"C_m7O4HRq_2Pb4v4mhJnyC37Eyq_1ELf">>,
    Body2 = hide(Body, SessionId),
    Headers2 = lists:keyreplace(<<"content-length">>,
                                1,
                                Headers,
                                {<<"content-length">>, integer_to_list(iolist_size(Body2))}),
    {ok, Req2} = cowboy_req:reply(200, Headers2, Body2, Req),
    Req2;
protect(_, _Headers, _Body, Req) ->
    Req.
