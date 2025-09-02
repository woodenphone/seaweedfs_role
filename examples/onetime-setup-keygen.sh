#!/usr/bin/env bash
## onetime-setup-keygen.sh
## Example of creating certificates for weed components.
## i.e. this avoids typing things manually for convenience.
## ---------------------------------------- ##
echo "[${0##*/}] Starting (at $(date -Is))" >&2

## ----------< Config values >---------- ##
## CA certificate:
ca_common_name='SeaweedFS_CA'
ca_passphrase='this example passphrase is shit'
ca_expiry='5 years'

## Regular certificates:
certs_passphrase='you ought to fucking change this'
cert_expiry='5 years'
## ----------< /Config values >---------- ##


## ----------< CA Certificate >---------- ##
## Create self-signed certificate to act as the CA.
echo "[${0##*/}] Make CA (self-signed) cert: ${ca_common_name@Q}" >&2
certstrap init \
	--expires="${ca_expiry?}" \
	--passphrase="${ca_passphrase?}" \
	--common-name="${ca_common_name?}"
## ----------< /CA Certificate >---------- ##


## ----------< Regular Certificates >---------- ##
## Create normal certificates that are signed by the CA.
echo "[${0##*/}] Make client certs" >&2
cert_names=(
	'master'
	'filer'
	'volume'
	'client'
)

for cert_name in ${cert_names[@]}; do
	echo "[${0##*/}] Create certificate request: ${cert_name@Q}" >&2
  ## Create certificate request
	certstrap request-cert \
		--passphrase="${certs_passphrase?}" \
		--common-name="${cert_name?}"

	echo "[${0##*/}] Sign certificate request: ${cert_name@Q}" >&2
	certstrap sign \
		--CA="${ca_common_name?}" \
		--passphrase="${ca_passphrase?}" \
		--expires="${cert_expiry?}" \
		"${cert_name?}"
done
## ----------< /Regular Certificates >---------- ##


echo "[${0##*/}] Finished (at $(date -Is)). Script took $((${SECONDS?} / 86400))d $((${SECONDS?} / 3600))h $(((${SECONDS?} / 60) % 60))m $((${SECONDS?} % 60))s (${SECONDS?} seconds total) to complete" >&2
exit

