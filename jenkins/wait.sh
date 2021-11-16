while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' $1)" != "$2" ]]
do
    echo "$(date) waiting for $1"
    sleep 5
done

