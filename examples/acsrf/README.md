Cowboy Anti. CSRF
=================

To compile this example you need rebar in your PATH.

Type the following command:
```
$ rebar get-deps compile
```

You can then start the Erlang node with the following command:
```
./start.sh
```

Then point your browser to the indicated URL. You can change
the GET parameter to check that the handler is echoing properly.

Example
-------

```
% lwp-request -e http://localhost:8080/
200 OK
Connection: close
Date: Sun, 01 Sep 2013 13:18:42 GMT
Server: Cowboy
Content-Length: 170
Client-Date: Sun, 01 Sep 2013 13:18:43 GMT
Client-Peer: 127.0.0.1:8080
Client-Response-Num: 1

<html><head><title>ACSRF</title></head><body><form><input type="hidden" name="middleware_acsrf" value="UtXBaqvf1vjyjELLnHhSBloDwqlhoZiBQV/0btWjuww="></form></body></html>
```
