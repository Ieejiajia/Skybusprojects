<?php
error_reporting(0);
include_once ("dbconnect.php");
$name = $_POST['name'];
$email = $_POST['email'];
$phone = $_POST['phone'];
$password = sha1($_POST['password']);
$verify= $_POST['verify'];

$sqlinsert = "INSERT INTO USER(NAME,EMAIL,PASSWORD,PHONE,VERIFY) VALUES ('$name','$email','$password','$phone','$verify')";

if ($conn->query($sqlinsert) === true)
{
    sendEmail($email);
    echo "success";
    
}
else
{
    echo "failed";
}



function sendEmail($useremail) {
    $to      = $useremail; 
    $subject = 'Verification for skyBus'; 
    $message = 'http://smileylion.com/skyBus/php/verify.php?email='.$useremail; 
    $headers = 'From: noreply@skyBus.com' . "\r\n" . 
    'Reply-To: '.$useremail . "\r\n" . 
    'X-Mailer: PHP/' . phpversion(); 
    mail($to, $subject, $message,$message, $headers); 
}

?>