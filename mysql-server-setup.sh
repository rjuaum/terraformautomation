#!/bin/bash
# Evita prompts interativos do MySQL

export DEBIAN_FRONTEND=noninteractive

# Atualiza pacotes e instala MySQL Server
sudo apt-get update
sudo apt-get install -y mysql-server

# Inicia o serviço do MySQL
sudo systemctl start mysql.service

# Permite ligações remotas ao MySQL
sed -i "s/^bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf

# Define utilizador e password da base de dados
DB_USER="${DB_USER}"
DB_PASS="${DB_PASS}"

# Cria utilizador apenas se ainda não existir
USER_EXISTS=$(mysql -u root -e "SELECT EXISTS(SELECT 1 FROM mysql.user WHERE user='$DB_USER')" | tail -n 1)
if [ "$USER_EXISTS" = "0" ]; then
  mysql -u root -e "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';"
fi

# Concede permissões totais ao utilizador
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;"

# Reinicia o MySQL para aplicar alterações
sudo systemctl restart mysql