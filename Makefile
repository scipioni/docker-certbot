SHELL := bash

all: dns-key.ini

.PHONY=query-txt
query-txt: dns-key.ini
	dig @$(DNS) _acme-challenge.mail.nawigare.it txt

.PHONY=update-txt
update-txt: dns-key.conf
	nsupdate -k dns-key.conf $(DNS) -v < nsupdate.cmd

dns-key.conf:
	@tsig-keygen -a hmac-md5 csgalileo.org. > dns-key.conf
	@echo copy dns-key.conf to $(DNS):/etc/bind (chmod 600 and bind owner)

dns-key.ini: dns-key.conf
	@./generate-ini.sh dns-key.conf > dns-key.ini
	
clean:
	rm dns-key.conf

dryrun:
	@DRYRUN="--dry-run -v" ./get-certificate.sh $(DOMAIN)

run:
	@./get-certificate.sh $(DOMAIN)
