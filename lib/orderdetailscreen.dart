  
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'order.dart';
import 'package:http/http.dart' as http;

class OrderDetailScreen extends StatefulWidget {
  final Order order;

  const OrderDetailScreen({Key key, this.order}) : super(key: key);
  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  List _orderdetails;
  String titlecenter = "Loading order details...";
  double screenHeight, screenWidth;

  @override
  void initState() {
    super.initState();
    _loadOrderDetails();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: Center(
        child: Column(children: <Widget>[
          Text(
            "Order Details",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          _orderdetails == null
              ? Flexible(
                  child: Container(
                      child: Center(
                          child: Text(
                  titlecenter,
                  style: TextStyle(
                      color: Color.fromRGBO(101, 255, 218, 50),
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ))))
              : Expanded(
                  child: ListView.builder(
                      //Step 6: Count the data
                      itemCount:
                          _orderdetails == null ? 0 : _orderdetails.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: EdgeInsets.fromLTRB(10, 1, 10, 1),
                            child: InkWell(
                                onTap: null,
                                child: Card(
                                  elevation: 10,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                            (index + 1).toString(),
                                            style:
                                                TextStyle(color: Colors.black),
                                          )),
                                      Expanded(
                                          flex: 2,
                                          child: Text(
                                            _orderdetails[index]['id'],
                                            style:
                                                TextStyle(color: Colors.black),
                                          )),
                                      Expanded(
                                          flex: 4,
                                          
                                         child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                            Text(_orderdetails[index]['departurestation'] +
                                                  " --> " +
                                                 _orderdetails[index]
                                                      ['arrivestation'],
                                                      style: TextStyle(fontSize:16,fontWeight: FontWeight.bold)),
                                              Text(_orderdetails[index]
                                                      ['departuretime'] +
                                                  " --> " +
                                                 _orderdetails[index]
                                                      ['arrivaltime'],
                                                      style: TextStyle(fontSize:15,fontWeight: FontWeight.bold)),
                                              
                                            ],
                                          )
                          
                                     
                                      ),
                                         
                                      Expanded( 
                                        flex: 3,
                                         child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text( "RM" +
                                          _orderdetails[index]['price'],
                                          style: TextStyle(color: Colors.black),
                                        ),
                                             
                                              Text(
                                                _orderdetails[index]
                                                    ['bquantity'] + " seats",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),  
                                              
                                            ],
                                          )
                          
                                     
                                      ),
                                    ],
                                  ),
                                )));
                      }))
        ]),
      ),
    );
  }

  _loadOrderDetails() async {
    String urlLoadJobs =
        "https://smileylion.com/skyBus/php/load_tickethistory.php";
    await http.post(urlLoadJobs, body: {
      "orderid": widget.order.orderid,
    }).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        setState(() {
          _orderdetails = null;
          titlecenter = "No Previous Payment";
        });
      } else {
        setState(() {
          var extractdata = json.decode(res.body);
          _orderdetails = extractdata["tickethistory"];
        });
      }
    }).catchError((err) {
      print(err);
    });
  }
}