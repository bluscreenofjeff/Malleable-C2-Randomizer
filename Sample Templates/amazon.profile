# This profile has been modified to use with the Malleable C2 Profile Randomizer

#
# Amazon browsing traffic profile
# 
# Author: @harmj0y
#

set sleeptime "%%number:2%%00";
set jitter    "1%%number%%";
set maxdns    "24%%number%%";
set useragent "%%useragent%%";

http-get {

    set uri "/s/ref=nb_sb_noss_1/%%number:3%%-%%number:8%%-%%number:7%%/field-keywords=%%word%%";

    client {

        header "Accept" "*/*";
        header "Host" "www.amazon.com";

        metadata {
            base64;
            prepend "session-token=";
            prepend "skin=noskin;";
            append "csm-hit=s-%%alphanumeric:20%%|%%number:13%%";
            header "Cookie";
        }
    }

    server {

        header "Server" "Server";
        header "x-amz-id-1" "%%alphanumeric:20%%";
        header "x-amz-id-2" "%%alphanumeric:63%%=";
        header "X-Frame-Options" "SAMEORIGIN";
        header "Content-Encoding" "gzip";

        output {
            print;
        }
    }
}

http-post {
    
    set uri "/N%%number:4%%/adj/amzn.us.sr.aps";

    client {

        header "Accept" "*/*";
        header "Content-Type" "text/xml";
        header "X-Requested-With" "XMLHttpRequest";
        header "Host" "www.amazon.com";

        parameter "sz" "160x600";
        parameter "oe" "oe=ISO-8859-1;";

        id {
            parameter "sn";
        }

        parameter "s" "%%number:4%%";
        parameter "dc_ref" "http%3A%2F%2Fwww.amazon.com";

        output {
            base64;
            print;
        }
    }

    server {

        header "Server" "Server";
        header "x-amz-id-1" "%%alphanumeric:20%%";
        header "x-amz-id-2" "%%alphanumeric:63%%=";
        header "X-Frame-Options" "SAMEORIGIN";
        header "x-ua-compatible" "IE=edge";

        output {
            print;
        }
    }
}
