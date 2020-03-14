<?php
$servername = "localhost";
$username   = "smileyli_skyBus";
$password   = "smileylion@@@1111";
$dbname     = "smileyli_skyBus";
 
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

?>