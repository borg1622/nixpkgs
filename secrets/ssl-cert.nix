{
  sslCert = "/etc/letsencrypt/live/0hq.de/fullchain.pem";
  sslCertKey = "/etc/letsencrypt/live/0hq.de/privkey.pem";

# verify chain of trust of OCSP response using Root CA and Intermediate certs
  sslTrustedCert = "/etc/letsencrypt/live/0hq.de/chain.pem";

}
