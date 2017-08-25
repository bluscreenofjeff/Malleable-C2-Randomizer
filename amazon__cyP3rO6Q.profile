# This profile has been modified to use with the Malleable C2 Profile Randomizer

#
# Amazon browsing traffic profile
# 
# Author: @harmj0y
#

set sleeptime "5300";
set jitter    "16";
set maxdns    "243";
set useragent "Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:5.0) Gecko/20100101 Firefox/5.0";

http-get {

    set uri "/s/ref=nb_sb_noss_1/500-95834106-2583217/field-keywords=work";

    client {

        header "Accept" "*/*";
        header "Host" "www.amazon.com";

        metadata {
            base64;
            prepend "session-token=";
            prepend "skin=noskin;";
            append "csm-hit=s-kqhykrhMfuqrFj659p1Y|2708363776168";
            header "Cookie";
        }
    }

    server {

        header "Server" "Server";
        header "x-amz-id-1" "51nwIqJSHJdOS900OIyT";
        header "x-amz-id-2" "eqhkJenEg7SeOoTnQIb9vibKvx7Y6CSVbX2Q1vriMcpJAL0MGF74wCwjU5cS0Fc=";
        header "X-Frame-Options" "SAMEORIGIN";
        header "Content-Encoding" "gzip";

        output {
            print;
        }
    }
}

http-post {
    
    set uri "/N8291/adj/amzn.us.sr.aps";

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

        parameter "s" "3768";
        parameter "dc_ref" "http%3A%2F%2Fwww.amazon.com";

        output {
            base64;
            print;
        }
    }

    server {

        header "Server" "Server";
        header "x-amz-id-1" "YBgi7sc1ovTdPHh19vRj";
        header "x-amz-id-2" "HEP6YXcpXu2aewTjOwJZCaL2qJjaPronthnoJ4Wcvo3HD5B1OMRZEOblO2EUzgJ=";
        header "X-Frame-Options" "SAMEORIGIN";
        header "x-ua-compatible" "IE=edge";

        output {
            print;
        }
    }
}
