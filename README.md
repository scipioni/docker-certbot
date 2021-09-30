# certbot with docker

## setup 

generate tsig key
```
make clean
make all DNS=nsa.csgalileo.org 
```

transfer dns-key.conf to nsa.csgalileo.org:/etc/bind with 600 chmod and 'bind' owner

include key and enable rfc2136 updates on domain in /etc/bind/named.conf.local
```
...
// valido per tutti i domini
include "/etc/bind/dns-key.conf";
...


zone "nawigare.it" {
    ......
            
    // this is for certbot
    allow-update { key csgalileo.org.; };
    check-names warn;

    // restrict optional
    //update-policy {
    //    grant csgalileo.org. name _acme-challenge.mail.nawigare.it. txt;
    //    };
    };
```


```
systemctl reload bind9
```

test rfc2136 access
```
make update-txt DNS=nsa.csgalileo.org
make query-txt DNS=nsa.csgalileo.org
...
;; ANSWER SECTION:
_acme-challenge.mail.nawigare.it. 120 IN TXT	"test5"
```

## certificate request

dryrun
```
make dryrun DOMAIN=mail.nawigare.it
```

certificate download
```
make run DOMAIN=mail.nawigare.it
```

certificate renew
```
make run DOMAIN=mail.nawigare.it
```
