<?php
error_reporting(0);
include_once ("dbconnect.php");
$orderid = $_POST['orderid'];

$sql = "SELECT SCHEDULE.ID, SCHEDULE.DEPARTURE_STATION, SCHEDULE.ARRIVAL_STATION, SCHEDULE.DEPARTURE_TIME,SCHEDULE.ARRIVAL_TIME, SCHEDULE.PRICE,SCHEDULE.COMPANY,SCHEDULE.QUANTITY,TICKETHISTORY.BQUANTITY FROM SCHEDULE INNER JOIN TICKETHISTORY ON TICKETHISTORY.BUSID = SCHEDULE.ID WHERE  TICKETHISTORY.ORDERID = '$orderid'";

$result = $conn->query($sql);

if ($result->num_rows > 0)
{
    $response["tickethistory"] = array();
    while ($row = $result->fetch_assoc())
    {
         $ticketlist = array();
        $ticketlist["id"] = $row["ID"];
        $ticketlist["departurestation"] = $row["DEPARTURE_STATION"];
        $ticketlist["arrivestation"] = $row["ARRIVAL_STATION"];
        $ticketlist["departuretime"] = $row["DEPARTURE_TIME"];
        $ticketlist["arrivaltime"] = $row["ARRIVAL_TIME"];
        $ticketlist["price"] = $row["PRICE"];
        $ticketlist["company"] = $row["COMPANY"];
        $ticketlist["bquantity"] = $row["BQUANTITY"];
        array_push($response["tickethistory"], $ticketlist);
    }
    echo json_encode($response);
}
else
{
    echo "Cart Empty";
}
?>