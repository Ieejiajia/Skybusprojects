<?php
error_reporting(0);
include_once ("dbconnect.php");
$email = $_POST['email'];

if (isset($email)){
   $sql = "SELECT SCHEDULE.ID, SCHEDULE.DEPARTURE_STATION, SCHEDULE.ARRIVAL_STATION, SCHEDULE.DEPARTURE_TIME, SCHEDULE.ARRIVAL_TIME, SCHEDULE.PRICE, SCHEDULE.COMPANY, SCHEDULE.QUANTITY, TICKET.BQUANTITY FROM SCHEDULE INNER JOIN TICKET ON TICKET.BUSID=SCHEDULE.ID WHERE TICKET.EMAIL = '$email'";
}

$result = $conn->query($sql);

if ($result->num_rows > 0)
{
    $response["ticket"] = array();
    while ($row = $result->fetch_assoc())
    {
        $ticketlist = array();
        $ticketlist["id"] = $row["ID"];
     $ticketlist["departurestation"] = $row["DEPARTURE_STATION"];
        $ticketlist["arrivalstation"] = $row["ARRIVAL_STATION"];
        $ticketlist["departuretime"] = $row["DEPARTURE_TIME"];
        $ticketlist["arrivaltime"] = $row["ARRIVAL_TIME"];
        $ticketlist["price"] = $row["PRICE"];
        $ticketlist["company"] = $row["COMPANY"];
        $ticketlist["quantity"] = $row["QUANTITY"];
        $ticketlist["bquantity"] = $row["BQUANTITY"];
        $ticketlist["yourprice"] = round(doubleval($row["PRICE"])*(doubleval($row["BQUANTITY"])),2)."";
        
        array_push($response["ticket"], $ticketlist);
    }
    echo json_encode($response);
}
else
{
    echo "Ticket Empty";
}
?>