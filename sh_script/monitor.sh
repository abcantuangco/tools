#!/bin/sh

server="http://yourapidomain.here"
ping_url="/utility/ping"
lockfile="path/to/monitor.lock"
content_type="Accept: application/json"

if [ -e $lockfile ]; then
    if [[ $(find "$lockfile" -mtime +2 -print) ]]; then
        # delete lock file since lockfile exists more than 2 hours
        rm $lockfile
    else
        # exit now since lockfile was already created less than 2 hours ago
        exit;
    fi
fi

max_retry=5
set_interval=1
counter=0

# this function is dependent on sendEmail library
# you need to install it on server that 
# this script runs
send_email () {
    from="no-reply@yourdomain.com"
    to="manager@yourdomain.com"
    cc="observer@yourdomain.com"
    subject="Error Accessing Server: 0000.00.00.0000"
    body="Server Status Response: $1 \nServer Full Response: $2"
    smtp_server="0000.00.00.0000" # smtp server

    if [ "$response_code" == "" ] ; then
        body="Server is completely inaccessible."
    fi
   
    sendEmail -f  $from -s $smtp_server -t $to -cc $cc -u $subject -m $body
}

# curl health check API
curl_api () {
    response_full=$(curl -sb -IH $content_type $server$ping_url )
    response_code=$(curl -s -IH $content_type $server$ping_url | head -n 1 | cut -d$' ' -f2  )
}

# create human readable response for logging
show_message () {
    echo "---------------------------------------"
    echo "Fetching: $server$ping_url"
    echo "Message: $1" 
    echo "---------------------------------------"
}

curl_api

if [ "$response_code" != "200" ] || [ "$response_code" == "" ] ; then
    touch $lockfile
    show_message "Error fetching URL with response code $response_code"
    while [ $counter -le $max_retry ]; do
        if [ $counter -ge $max_retry ]; then
            send_email "$response_code" "$response_full"
            rm $lockfile;
            exit;
        fi
        counter=$[$counter+1]
        sleep $set_interval
        show_message "Retrying in $set_interval second/s."
        curl_api
        if [ "$response_code" == "200" ]; then
            show_message "Your service is now running."
            rm $lockfile;
            exit;
        else
            show_message "Error fetching URL with response code $response_code"
        fi
    done
else
    show_message "Your service is running fine."
fi
