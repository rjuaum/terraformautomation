#!/bin/bash

DB_HOST="${DB_HOST}"
DB_USER="${DB_USER}"
DB_PASS="${DB_PASS}"

sudo apt-get update
sudo apt-get install -y apache2 php php-mysqli libapache2-mod-php mysql-client-core-8.0

# Reinicia o serviço Apache
sudo systemctl restart apache2

# Cria a página phpinfo
sudo echo "<?php phpinfo(); ?>" > /var/www/html/info.php

# Cria o script PHP para testar conexão à base de dados
sudo cat <<'EOF' > /var/www/html/testdb.php
<?php
$servername = "10.0.1.4";
$database = "mysql";
$username = "mysqladmin";
$password = "11@&ym94#nRjzF";

// Cria a conexão
$conn = new mysqli($servername, $username, $password, $database);

// Verifica a conexão
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
echo "Connected successfully";
?>
EOF

# Define permissões apropriadas (opcional)
sudo chmod 644 /var/www/html/info.php /var/www/html/testdb.php
