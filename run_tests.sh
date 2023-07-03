#!/bin/sh

DEFAULT_USERNAME="admin"
DEFAULT_PASSWORD="public"

username="${EMQX_DASHBOARD_USERNAME:-$DEFAULT_USERNAME}"
password="${EMQX_DASHBOARD_PASSWORD:-$DEFAULT_PASSWORD}"

token=$(curl -s --json "{\"username\": \"${username}\", \"password\": \"${password}\"}" http://localhost:18083/api/v5/login 2> /dev/null | jq -r '.token')

for scenario in scenarios/*; do
    echo "running $scenario"
    run=$(docker run --rm -i -v $PWD:$PWD -w $PWD --network emqx_bridge ysoftwareab/katt --json base_url=http://emqx:18083/api/v5 username=${username} password=${password} token=${token} -- ${scenario} 2> /dev/null)
    ret=$(echo $run | sed 's/$/\\n/' | tr -d '\n' | sed -e 's/“/"/g' -e 's/”/"/g' | sed '$ s/\\n$//' | jq '.status == "pass"')
    if [ $ret != "true" ]; then
        echo $run | sed 's/$/\\n/' | tr -d '\n' | sed -e 's/“/"/g' -e 's/”/"/g' | sed '$ s/\\n$//' | jq . -C;
    fi
done
