#!/bin/bash
path=/etc/postfix/main.cf
path1=/etc/postfix/sasl_passwd
sudo apt-get install postfix mailutils libsasl2-2 ca-certificates libsasl2-modules -y
sudo mv /etc/postfix/main.cf /etc/postfix/main.cf.bak

echo "relayhost = [smtp.gmail.com]:587" >> $path
echo "smtp_sasl_auth_enable = yes" >> $path
echo "smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd" >> $path
echo "smtp_sasl_security_options = noanonymous" >> $path
echo "smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt" >> $path
echo "smtp_use_tls = yes" >> $path
echo "[smtp.gmail.com]:587	monitoring.paques@gmail.com:ulxoyvwgqhlzrtyt" >> $path1

sudo chown root:root /etc/postfix/sasl_passwd
sudo chmod 600 /etc/postfix/sasl_passwd
sudo postmap /etc/postfix/sasl_passwd 
sudo systemctl restart postfix

ssh-keygen -t rsa -b 4096 -C "paques@10.200.168.15"
sudo cat .ssh/id_rsa.pub | ssh paques@10.200.168.15 'cat >> .ssh/authorized_keys'
