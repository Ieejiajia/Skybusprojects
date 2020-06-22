<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];
$orderid = $_POST['orderid'];
$billid= $_POST['billid'];


if(isset($_POST['busid'])){
     $sqldelete = "DELETE FROM TICKETHISTORY WHERE EMAIL = '$email' AND BILLID='$billid'";
     }else{
    $sqldelete = "DELETE FROM TICKETHISTORY WHERE EMAIL = '$email'";
}
    if ($conn->query($sqldelete) === TRUE){
       echo "success";
    }else {
        echo "failed";
    }
?>