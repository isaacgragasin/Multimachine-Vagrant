#!/bin/bash
echo "PHP5 provisioning - begin"
sudo apt-get install php libapache2-mod-php php-mysql -y #install php
sudo systemctl restart apache2.service 
echo "PHP5 provisioning - end"
