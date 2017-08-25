# This profile has been modified to use with the Malleable C2 Profile Randomizer

#
# Standard Pandora traffic profile
# 
# Author: @harmj0y
#

set sleeptime "%%number:2%%0";
set jitter    "0";
set maxdns    "24%%number%%";
set useragent "%%useragent%%";


http-get {

    set uri "/access/";

    client {

        header "Accept" "*/*";
        header "GetContentFeatures.DLNA.ORG" "1";
        header "Host" "audio-sv5-t1-3.pandora.com";
        header "Cookie" " __utma=%%number:9%%.%%number:10%%.%%number:10%%.%%number:10%%.%%number:10%%.%%number%%;";

        parameter "version" "4";
        parameter "lid" "%%number:10%%";

        metadata {
            netbios;
            parameter "token";
        }
    }

    server {

        header "Server" "Apache";
        header "Cache-Control" "no-cache, no-store, must-revalidate, max-age=-1";
        header "Pragma" "no-cache, no-store";
        #header "Expires" "-1";
        header "Connection" "close";
        header "Content-Type" "audio/mp4";

        output {

            # mp4 header
            # 0000000: 0000 001c 6674 7970 6d70 3432 0000 0001  ....ftypmp42....
            # 0000010: 4d34 5620 6d70 3432 6973 6f6d 0001 6fd9  M4V mp42isom..o.

            prepend "\x6d\x6f\x6f\x76\x00\x00\x00\x6c\x6d\x76\x68\x64";
            prepend "\x4d\x34\x56\x20\x6d\x70\x34\x32\x69\x73\x6f\x6d\x00\x01\x6f\xd9";
            prepend "\x00\x00\x00\x1c\x66\x74\x79\x70\x6d\x70\x34\x32\x00\x00\x00\x01";

            print;
        }
    }
}

http-post {
    
    set uri "/radio/xmlrpc/v35";

    client {

        header "Accept" "*/*";
        header "Content-Type" "text/xml";
        header "X-Requested-With" "XMLHttpRequest";
        header "Host" "www.pandora.com";

        id {
            parameter "rid";
        }

        parameter "lid" "%%number:10%%";
        parameter "method" "getSearchRecommendations";

        output {
            base64;
            print;
        }
    }

    server {

        header "Content-Type" "text/xml";
        header "Cache-Control" "no-cache, no-store, no-transform, must-revalidate, max-age=0";
        header "Expires" "-1";
        header "Vary" "Accept-Encoding";
        header "Content-Encoding" "gzip";

        output {
            print;
        }
    }
}
