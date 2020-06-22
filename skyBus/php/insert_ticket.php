<?php
error_reporting(0);
include_once ("dbconnect.php");
$email = $_POST['email'];
$busid = $_POST['busid'];
$userquantity = $_POST['quantity'];


$sqlquantity = "SELECT * FROM TICKET WHERE EMAIL = '$email' AND BUSID = '$busid'";

$result = $conn->query($sqlsearch);
if ($resultq->num_rows > 0) {

    while ($row = $result ->fetch_assoc()){
        $prquantity = $row["BQUANTITY"] ;
    }
 $prquantity = $prquantity + $userquantity;
    $sqlinsert = "UPDATE TICKET SET BQUANTITY = '$prquantity' WHERE BUSID = '$busid' AND EMAIL = '$email'";
}else{
    $sqlinsert = "INSERT INTO TICKET(EMAIL,BUSID,BQUANTITY) VALUES ('$email','$busid',$userquantity)";
}

if($conn->query($sqlinsert)==true){
    $sqlquantity = "SELECT * FROM TICKET WHERE EMAIL = '$email'";
    
    $resultq = $conn->query($sqlquantity);
    if($resultq->num_rows >0){
        $quantity = 0;
        while($row = $resultq ->fetch_assoc()){
            $quantity = $row["BQUANTITY"] + $quantity;
        }
    }
    
    $quantity = $quantity;
    echo "success,".$quantity;
}
else{
    echo "failed";
}

?>
    



