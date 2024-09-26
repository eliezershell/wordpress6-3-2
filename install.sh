#!/bin/bash

sudo apt update

sudo apt install apache2 libapache2-mod-php -y
sudo a2dismod mpm_event
sudo a2enmod mpm_prefork rewrite php8.1
sudo systemctl restart apache2

sudo apt install php8.1 php-json php-curl php-dom php-exif php-fileinfo php-igbinary php-imagick php-intl php-mbstring php-xml php-zip php-apcu php-opcache php-iconv php-shmop php-simplexml php-xmlreader php-ssh2 php-ftp php-sockets -y

sudo apt install mariadb-server -y
sudo apt install php-mysqli
read -p "Nome de usuário MySQL: " usuario
read -p "Senha de usuário MySQL: " senha
read -p "Nome do banco de dados MySQL: " banco
sudo mysql -u root <<MYSQL_SCRIPT
CREATE USER '$usuario'@'localhost' IDENTIFIED BY '$senha';
CREATE DATABASE $banco;
GRANT ALL PRIVILEGES ON $banco.* TO '$usuario'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

sudo apt install unzip -y
sudo wget -P /var/www/html https://wordpress.org/latest.zip
sudo rm -f /var/www/html/index.html
sudo unzip /var/www/html/latest.zip -d /var/www/html/
sudo rm -f /var/www/html/latest.zip
sudo mv /var/www/html/wordpress/* /var/www/html/
sudo rmdir /var/www/html/wordpress/
sudo chown -R www-data /var/www/
sudo chmod 755 -R /var/www/

sudo systemctl restart apache2

#sudo snap install --classic certbot
#sudo ln -s /snap/bin/certbot /usr/bin/certbot
#sudo certbot --apache

echo "------------------------------Instalação concluída com sucesso!------------------------------"
echo "----------------------Script by: Eliezer Ribeiro | linkedin.com/in/elinux--------------------"
exit 0
