<?php
error_reporting(0);
include_once ("dbconnect.php");
$company = $_POST['company'];
$departurestation = $_POST['departurestation'];
$arrivalstation = $_POST["arrivalstation"]; 

if (isset($company)){
    if ($company == "Recent"){
        $sql = "SELECT * FROM SHEDULE ORDER BY ID ASC";    
    }else{
        $sql = "SELECT * FROM SCHEDULE WHERE COMPANY = '$company'";    
    }
}else{
    $sql = "SELECT * FROM SCHEDULE ORDER BY ID ASC";    
}

if (isset($departurestation)){
   $sql = "SELECT * FROM SCHEDULE WHERE DEPARTURE_STATION LIKE  '%$departurestation%'";
}
if (isset($arrivalstation)){
   $sql = "SELECT * FROM SCHEDULE WHERE ARRIVAL_STATION = '$arrivalstation'";
}




$result = $conn->query($sql);
if ($result->num_rows > 0)
{
    $response["SCHEDULE"] = array();
    while ($row = $result->fetch_assoc())
    {
        $productlist = array();
        $productlist["id"] = $row["ID"];
        $productlist["departurestation"] = $row["DEPARTURE_STATION"];
        $productlist["arrivalstation"] = $row["ARRIVAL_STATION"];
        $productlist["departuretime"] = $row["DEPARTURE_TIME"];
        $productlist["arrivaltime"] = $row["ARRIVAL_TIME"];
        $productlist["price"] = $row["PRICE"];
        $productlist["company"] = $row["COMPANY"];
        $productlist["quantity"] = $row["QUANTITY"];
        $productlist["date"] = $row["DATE"];
        $productlist["sold"] = $row["SOLD"];
       
        array_push($response["SCHEDULE"], $productlist);
    }
    echo json_encode($response);
}
else
{
    echo "nodata";
}
?>