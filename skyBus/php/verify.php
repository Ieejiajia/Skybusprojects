<?php
error_reporting(0);
include_once ("dbconnect.php");

$email = $_GET['email'];
$verify =$_POST['verify'] ;

if (isset( $_GET['email'])){
    $email=$_GET['email'];
    $sql ="SELECT * FROM USER WHERE EMAIL ='$email'";
    $result = $conn->query ($sql);
        if($result = $conn->num_rows > 0){
             while ($row=$result->fetch_assor()){
                 $query= "UPDATE USER SET VERIFY='1' WHERE EMAIL='$email'";
                  echo "Registration Sucess";
         }
     }else{
         echo "Failed";
     }
}
?>