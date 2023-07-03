# emqx_api_testsuite

## Prerequisites

There are other ways but this is most convenient if you ask me.

* docker
* jq

## How to run

Have a running EMQX node:

```sh
$ docker-compose up -d
```

Run the tests:

```sh
$ ./run_tests.sh
```

If you've changed or added a dashboard user or password you can pass the credentials as environment variables:

```sh
$ EMQX_DASHBOARD_USERNAME=my_user EMQX_DASHBOARD_PASSWORD=my_secret ./run_tests.sh
```

Run a single test scenario

```sh
$ docker run --rm -i -v $PWD:$PWD -w $PWD --network emqx_bridge ysoftwareab/katt --json base_url=http://emqx:18083/api/v5 username=admin password=public -- scenarios/auth.apib 2> /dev/null | jq '.status == "pass"'
true
```
