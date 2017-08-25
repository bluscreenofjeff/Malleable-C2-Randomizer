# This profile has been modified to use with the Malleable C2 Profile Randomizer

#
# Amazon browsing traffic profile
# 
# Author: @harmj0y
#

set sleeptime "8400";
set jitter    "11";
set maxdns    "243";
set useragent "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36";

http-get {

    set uri "/s/ref=nb_sb_noss_1/625-19565332-5648629/field-keywords=woman";

    client {

        header "Accept" "*/*";
        header "Host" "www.amazon.com";

        metadata {
            base64;
            prepend "session-token=";
            prepend "skin=noskin;";
            append "csm-hit=s-UqpGbDpzGgL4UJwloq5L|9552354882460";
            header "Cookie";
        }
    }

    server {

        header "Server" "Server";
        header "x-amz-id-1" "EoIx0oGVa8nVcfcWq7la";
        header "x-amz-id-2" "hrhVNXBocwiSIWCXDyJAqc2pj30T3PS4QDO6MQZwxnUpU65i8weP5QFZ8i6MRhH=";
        header "X-Frame-Options" "SAMEORIGIN";
        header "Content-Encoding" "gzip";

        output {
            print;
        }
    }
}

http-post {
    
    set uri "/N1342/adj/amzn.us.sr.aps";

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

        parameter "s" "2832";
        parameter "dc_ref" "http%3A%2F%2Fwww.amazon.com";

        output {
            base64;
            print;
        }
    }

    server {

        header "Server" "Server";
        header "x-amz-id-1" "srUKLnJBtuPqoz6uUx58";
        header "x-amz-id-2" "KCJXe8QAiFMb2whoSfomZbo3E0LfhPewDV1IagFyuiFwZn9ziQtpHSCNZl5o5Jy=";
        header "X-Frame-Options" "SAMEORIGIN";
        header "x-ua-compatible" "IE=edge";

        output {
            print;
        }
    }
}
