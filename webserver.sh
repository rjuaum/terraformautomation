#!/bin/bash

DB_USER="${DB_USER}"
DB_PASS="${DB_PASS}"
DB_HOST="${DB_HOST}"

# Atualiza pacotes e instala Apache2
sudo apt-get update
sudo apt-get install -y apache2 php php-mysqli libapache2-mod-php mysql-client-core-8.0

# Reinicia o serviço Apache
sudo systemctl restart apache2

# Cria phpinfo
echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/info.php

# Cria testdb.php com variáveis substituídas
echo "<?php
\$servername = \"${DB_HOST}\";
\$database = \"mysql\";
\$username = \"${DB_USER}\";
\$password = \"${DB_PASS}\";

// Cria a conexão
\$conn = new mysqli(\$servername, \$username, \$password, \$database);

// Verifica a conexão
if (\$conn->connect_error) {
    die(\"Connection failed: \" . \$conn->connect_error);
}
echo \"Connected successfully\";
?>" > /var/www/html/testdb.php

# Define permissões apropriadas (opcional)
sudo chmod 644 /var/www/html/info.php /var/www/html/testdb.php
