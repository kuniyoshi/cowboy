Cowboy Anti CSRF
================

To compile this example you need rebar in your PATH.

Type the following command:
```
$ rebar get-deps compile
```

You can then start the Erlang node with the following command:
```
./start.sh
```

Then point your browser to the indicated URL.

Example
-------

``` bash
$ curl -i http://localhost:8080
HTTP/1.1 200 OK
connection: keep-alive
server: Cowboy
date: Wed, 04 Sep 2013 11:53:43 GMT
content-length: 170

<html><head><title>ACSRF</title></head><body><form><input type="hidden" name="middleware_acsrf" value="UtXBaqvf1vjyjELLnHhSBloDwqlhoZiBQV/0btWjuww="></form></body></html>%
```
