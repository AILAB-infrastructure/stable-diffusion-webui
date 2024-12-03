NAME="stable_diffucion"


find_next_port() {
    taken=()
    for value in $(docker ps --format "{{.Ports}}" | grep  -oP "(?<=:::)([0-9]+)"); do  
        taken+=($value)
    done

    for port in {8000..9000}; do
        if ! [[ ${taken[@]} =~ $port ]]
        then
            echo $port
            break
        fi
    done
}

PORT="$(find_next_port)"

docker build --tag "$NAME" -f Dockerfile .
docker run \
    --restart unless-stopped \
    -p $PORT:7860 \
    -e PAGE="$NAME|$PORT" \
    --env-file .env \
    --gpus all \
    -d $NAME