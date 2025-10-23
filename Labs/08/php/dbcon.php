<?php
try {
    $server = "mysql:host=db;dbname=crud_db";
    $user = "user";
    $password = "password";
    $pdo = new PDO($server, $user, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    echo "<h1 style=\"color:lightgreen;text-align:center;padding-top:10px\">Connected successfully!</h1>";
} catch(PDOException $e) {
    echo "<h1 style=\"color:tomato;text-align:center;padding-top:10px\">Error ".$e->getMessage()."</h1>";
}
?>
