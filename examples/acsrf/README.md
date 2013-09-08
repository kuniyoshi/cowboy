Anti CSRF example
=================

To try this example, you need GNU `make`, `git` and
[relx](https://github.com/erlware/relx) in your PATH.

To build the example, run the following command:

``` bash
$ make
```

To start the release in the foreground:

``` bash
$ ./_rel/bin/acsrf_example console
```

Then point your browser at [http://localhost:8080](http://localhost:8080).

Example output
--------------

``` bash
$ curl -i http://localhost:8080
HTTP/1.1 200 OK
connection: keep-alive
server: Cowboy
date: Wed, 04 Sep 2013 11:53:43 GMT
content-length: 170

<html><head><title>ACSRF</title></head><body><form><input type="hidden" name="middleware_acsrf" value="UtXBaqvf1vjyjELLnHhSBloDwqlhoZiBQV/0btWjuww="></form></body></html>
```
