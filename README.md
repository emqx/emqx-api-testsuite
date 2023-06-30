# emqx_api_testsuite


## Prerequisites

There are other ways but this is most convenient if you ask me.

* docker
* jq

## How to run

Have a running EMQX node:

```sh
$ docker run -d --name emqx -p 18083:18083 -p 1883:1883 emqx:5.1.0
```

Run a test scenario

```sh
$ docker run --rm -i -v $PWD:$PWD -w $PWD ysoftwareab/katt --json base_url=http://172.17.0.2:18083/api/v5 username=admin password=public -- scenarios/auth.apib 2> /dev/null | jq ".status == \"pass\""
true
```
```
