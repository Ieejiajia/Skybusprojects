<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];
$busid = $_POST['busid'];

if(isset($_POST['busid'])){
     $sqldelete = "DELETE FROM TICKET WHERE EMAIL = '$email' AND BUSID='$busid'";
     }else{
    $sqldelete = "DELETE FROM TICKET WHERE EMAIL = '$email'";
}
    if ($conn->query($sqldelete) === TRUE){
       echo "success";
    }else {
        echo "failed";
    }
?>