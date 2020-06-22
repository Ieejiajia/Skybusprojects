<?php
error_reporting(0);
include_once("dbconnect.php");

$email = $_POST['email'];
$busid = $_POST['busid'];
$quantity = $_POST['quantity'];

$sqlupdate = "UPDATE TICKET SET BQUANTITY = '$quantity' WHERE EMAIL = '$email'             AND BUSID = '$busid'";

if ($conn->query($sqlupdate) === true)
{
    echo "success";
}
else
{
    echo "failed";
}
    
$conn->close();
?>