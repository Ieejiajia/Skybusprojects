import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
//import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:random_string/random_string.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:skybus/user.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'mainscreen.dart';
import 'payment.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CartScreen extends StatefulWidget {
 final User user;

  const CartScreen({Key key, this.user}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List cartData;
  double screenHeight, screenWidth, latitude, longitude;
  double  _totalprice = 0.0;
  GlobalKey<RefreshIndicatorState> refreshKey;
  List markerlist;
  double insurancecharge;
  double amountpayable;
  String titlecenter = "Loading your cart";
  final f = new DateFormat('dd-MM-yyyy hh:mm a');
bool _noninsurance = true;
  bool _storeCredit = false;
  bool _withinsurance = false;

@override
  void initState() {
    super.initState();
  
    _loadCart();
  }
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(title: Text('My Cart'), actions: <Widget>[
          IconButton(
            icon: Icon(MdiIcons.deleteEmpty),
            onPressed: () {
              deleteAll();
            },
          ),
        ]),
        body: Container(
            child: Column(
          children: <Widget>[
            Text(
              "Content of your Cart",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            cartData == null
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
                        itemCount: cartData == null ? 1 : cartData.length + 2,
                        itemBuilder: (context, index) {
                          
                          if (index == cartData.length) {
                            return Container(
                                height: screenHeight / 3.9,
                                width: screenWidth / 2.5,
                                child: InkWell(
                                  onLongPress: () => {print("Delete")},
                                  child: Card(
                                    //color: Colors.yellow,
                                    elevation: 5,
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text("Protect your journey with the coverage below from Takaful Ikhlas for just 1.0MYR",
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                        
                                        Expanded(
                                            child: Column(
                                          children: <Widget>[
                                            Container(
                                              // color: Colors.red/,
                                              width: screenWidth / 2,
                                              // height: screenHeight / 3,
                                              child: Column(
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Checkbox(
                                                        value: _withinsurance,
                                                        onChanged:
                                                            (bool value) {
                                                          _onwithinsurance(
                                                             value);
                                                        },
                                                      ),
                                                      Text(
                                                        "Yes",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    2, 1, 2, 1),
                                                child: SizedBox(
                                                    width: 2,
                                                    child: Container(
                                                      
                                                      color: Colors.grey,
                                                    ))),
                                            Expanded(
                                                child: Container(
                                              //color: Colors.blue,
                                              width: screenWidth / 2,
                                              //height: screenHeight / 3,
                                              child: Column(
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Checkbox(
                                                        value: _noninsurance,
                                                        onChanged:
                                                            (bool value) {
                                                          _onnoninsurance(value);
                                                        },
                                                      ),
                                                      Text(
                                                        "NO",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                 
                                                ],
                                              ),
                                            )),
                                          ],
                                        ))
                                      ],
                                    ),
                                  ),
                                ));
                          }

                          if (index == cartData.length + 1) {
                            return Container(
                                //height: screenHeight / 3,
                                child: Card(
                              elevation: 5,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("Payment",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  SizedBox(height: 10),
                                  Container(
                                      padding:
                                          EdgeInsets.fromLTRB(50, 0, 50, 0),
                                      //color: Colors.red,
                                      child: Table(
                                          defaultColumnWidth:
                                              FlexColumnWidth(1.0),
                                          columnWidths: {
                                            0: FlexColumnWidth(7),
                                            1: FlexColumnWidth(3),
                                          },
                                          //border: TableBorder.all(color: Colors.white),
                                          children: [
                                            TableRow(children: [
                                              TableCell(
                                                child: Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    height: 20,
                                                    child: Text(
                                                        "Total Item Price ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black))),
                                              ),
                                              TableCell(
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  height: 20,
                                                  child: Text(
                                                      "RM" +
                                                              _totalprice
                                                                .toStringAsFixed(
                                                                     2) ??
                                                          "0.0",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14,
                                                          color: Colors.black)),
                                                ),
                                              ),
                                            ]),
                                            TableRow(children: [
                                              TableCell(
                                                child: Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    height: 20,
                                                    child: Text(
                                                        "Insurance Charge ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black))),
                                              ),
                                              TableCell(
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  height: 20,
                                                  child: Text(
                                                      "RM" +
                                                            insurancecharge
                                                                  .toStringAsFixed(
                                                                     2) ??
                                                          "0.0",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14,
                                                          color: Colors.black)),
                                                ),
                                              ),
                                            ]),
                                            TableRow(children: [
                                              TableCell(
                                                child: Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    height: 20,
                                                    child: Text(
                                                        "Store Credit RM" +
                                                            widget.user.credit,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black))),
                                              ),
                                              TableCell(
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  height: 20,
                                                  child: Checkbox(
                                                    value: _storeCredit,
                                                    onChanged: (bool value) {
                                                      _onStoreCredit(value);
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ]),
                                            TableRow(children: [
                                              TableCell(
                                                child: Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    height: 20,
                                                    child: Text("Total Amount ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black))),
                                              ),
                                              TableCell(
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  height: 20,
                                                  child: Text(
                                                      "RM" +
                                                              amountpayable
                                                                  .toStringAsFixed(
                                                                     2) ??
                                                          "0.0",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                ),
                                              ),
                                            )]),
                                          ])),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    minWidth: 200,
                                    height: 40,
                                    child: Text('Make Payment',
                                    style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          )),
                                    color: Color.fromRGBO(101, 255, 218, 50),
                                    textColor: Colors.black,
                                    elevation: 10,
                                    onPressed: makePayment,
                                  ),
                                ],
                              ),
                            ));
                          }
                          index -= 0;
                          return Card(
                              elevation: 10,
                              child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Row(children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Container(
                                          height: screenHeight / 8,
                                          width: screenWidth / 5,
                                           child:ClipOval(
                                             child: 
                                            CachedNetworkImage(
                                           fit:BoxFit.fill,
                                           imageUrl: "https://smileylion.com/skyBus/busimage/${cartData[index]['company']}.jpg",
                                           placeholder: (context, url) =>
                                                new CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    new Icon(Icons.error),
                                          ),
                                        )
                                        ),
                                        SizedBox(height:10 ,),
                                        Text(cartData[index]['id'].toString(),
                                       style: TextStyle(
                                           fontWeight:FontWeight.bold ,
                                          color: Colors.black,
                                          ),
                                          
                                          ),
                                      ],
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(5, 1, 10, 1),
                                        child: SizedBox(
                                            width: 2,
                                            child: Container(
                                              height: screenWidth / 3.5,
                                              color: Colors.black,
                                            ))),
                                    Container(
                                        width: screenWidth / 1.45,
                                        //color: Colors.blue,
                                        child: Row(
                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                          //mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Flexible(
                                              child: Column(
                                                children: <Widget>[
                                                 Text(cartData[index]['departurestation'].toString()+" --> "+cartData[index]['arrivalstation'].toString(),
                                                   
                                                      style: TextStyle(fontSize:16,fontWeight: FontWeight.bold)),
                                              Text(cartData[index]
                                                      ['departuretime'].toString() +
                                                  " --> " +
                                                  cartData[index]
                                                      ['arrivaltime'].toString(),
                                                       style: TextStyle(fontSize:15,fontWeight: FontWeight.bold)),
                                                  Text(
                                                    "Available " +
                                                        cartData[index]
                                                            ['quantity'] +
                                                        " seats",
                                                    style: TextStyle(
                                                      
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Your Quantity " +
                                                        cartData[index]
                                                            ['bquantity'],
                                                    style: TextStyle(
                                                      color: Colors.black
                                                    ),
                                                  ),
                                                  Container(
                                                      height: 20,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          FlatButton(
                                                            onPressed: () => {
                                                            _updateCart(
                                                                index, "add")
                                                            },
                                                            child: Icon(
                                                              MdiIcons.plus,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      101,
                                                                      255,
                                                                      218,
                                                                      50),
                                                            ),
                                                          ),
                                                          Text(
                                                            cartData[index]
                                                                ['bquantity'],
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          FlatButton(
                                                            onPressed: () => {
                                                              _updateCart(index,
                                                                  "remove")
                                                            },
                                                            child: Icon(
                                                              MdiIcons.minus,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      101,
                                                                      255,
                                                                      218,
                                                                      50),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Text(
                                                          "Total RM " +
                                                              cartData[index]
                                                                  ['yourprice'],
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .black)),
                                                                  
                                                      FlatButton(
                                                        onPressed: () => {
                                                          _deleteCart(index)
                                                        },
                                                        child: Icon(
                                                          MdiIcons.delete,
                                                          color: Color.fromRGBO(
                                                              101,
                                                              255,
                                                              218,
                                                              50),
                                                        ),
                                                      ),
                                                      
                                                    ],
                                                  ),
                                                  
                                                  
                                                ],
                                              ),
                                            )
                                          ],
                                        )),
                                  ])));
                        })),
          ],
        )));
  }
  void _loadCart() {
    _totalprice = 0.0;
    amountpayable = 0.0;
    insurancecharge = 0.0;
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Updating ...");
    pr.show();
    String urlLoadJobs = "https://smileylion.com/skyBus/php/load_ticket.php";
    http.post(urlLoadJobs, body: {
      "email": widget.user.email,
    }).then((res) {
      print(res.body);
      pr.dismiss();
      if (res.body == "Ticket Empty") {
        //Navigator.of(context).pop(false);
        widget.user.quantity = "0";
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => MainScreen(
                      user: widget.user,
                    )));
      }
       setState(() {
        var extractdata = json.decode(res.body);
        cartData = extractdata["ticket"];
        for (int i = 0; i < cartData.length; i++) {
         
          _totalprice = double.parse(cartData[i]['yourprice']) + _totalprice;
        }
        
        amountpayable = _totalprice;


        print(_totalprice);
      });
    }).catchError((err) {
      print(err);
      pr.dismiss();
    });
    pr.dismiss();
  }
_updateCart(int index, String op) {
    int curquantity = int.parse(cartData[index]['quantity']);
    int quantity = int.parse(cartData[index]['bquantity']);
    if (op == "add") {
      quantity++;
      if (quantity > (curquantity - 2)) {
        Toast.show("Quantity not available", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        return;
      }
    }
    if (op == "remove") {
      quantity--;
      if (quantity == 0) {
        _deleteCart(index);
        return;
      }
    }
 String urlLoadJobs = "https://smileylion.com/skyBus/php/update_ticket.php";
    http.post(urlLoadJobs, body: {
      "email": widget.user.email,
      "busid": cartData[index]['id'],
      "quantity": quantity.toString()
    }).then((res) {
      print(res.body);
      if (res.body == "success") {
        Toast.show("Cart Updated", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        _loadCart();
      } else {
        Toast.show("Failed", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }).catchError((err) {
      print(err);
    });
}
_deleteCart(int index) {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: new Text(
          'Delete item?',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(false);
                http.post("https://smileylion.com/skyBus/php/delete_ticket.php",
                    body: {
                      "email": widget.user.email,
                      "busid": cartData[index]['id'],
                    }).then((res) {
                  print(res.body);

                  if (res.body == "success") {
                    _loadCart();
                  } else {
                    Toast.show("Failed", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  }
                }).catchError((err) {
                  print(err);
                });
              },
              child: Text(
                "Yes",
                style: TextStyle(
                  color: Color.fromRGBO(101, 255, 218, 50),
                ),
              )),
          MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Color.fromRGBO(101, 255, 218, 50),
                ),
              )),
        ],
      ),
    );
  }
 void _onnoninsurance(bool newValue) => setState(() {
        _noninsurance = newValue;
        if (_noninsurance) {
          _withinsurance = false;
          _updatePayment();
        } else {
          //_homeDelivery = true;
          _updatePayment();
        }
      });
      void _onStoreCredit(bool newValue) => setState(() {
        _storeCredit = newValue;
        if (_storeCredit) {
          _updatePayment();
        } else {
          _updatePayment();
        }
      });
void _onwithinsurance(bool newValue) {
    
    setState(() {
      _withinsurance = newValue;
      if (_withinsurance) {
        _updatePayment();
        _noninsurance = false;
      } else {
        _updatePayment();
      }
    });
  }
void _updatePayment() {
    _totalprice=0.0;
    amountpayable=0.0;
    setState(() {
      for(int i= 0; i<cartData.length;i++){
        _totalprice= double.parse(cartData[i]['yourprice'])+_totalprice;
      }
     print(_noninsurance);
      if (_noninsurance) {
        insurancecharge=0.0;
      }
      
       if(_withinsurance){
        insurancecharge = 1.0;
      }
    
       if (_storeCredit) {
        amountpayable =
             double.parse(widget.user.credit)-(insurancecharge + _totalprice) ;
      }
      else  {
        amountpayable = insurancecharge + _totalprice;
      }

      print("Dev Charge:" + insurancecharge.toStringAsFixed(3));
     
      print(_totalprice);
    });
  }
      Future<void> makePayment() async {
    if (_noninsurance) {
      print("no insurance");
      Toast.show("no insurance", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else if (_withinsurance) {
      print("with insurance");
      Toast.show("Insurance", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      Toast.show("Please select insurance option", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
    var now = new DateTime.now();
    var formatter = new DateFormat('ddMMyyyy-');
    String orderid = widget.user.email.substring(1,4) +
        "-" +
        formatter.format(now) +
        randomAlphaNumeric(6);
    print(orderid);
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => PaymentScreen(
                  user: widget.user,
                  val: _totalprice.toStringAsFixed(2),
                  orderid: orderid,
                )));
    _loadCart();
  }
 void deleteAll() {
     showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: new Text(
          'Delete all items?',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(false);
                http.post("https://smileylion.com/skyBus/php/delete_ticket.php",
                    body: {
                      "email": widget.user.email,
                    }).then((res) {
                  print(res.body);

                  if (res.body == "success") {
                    _loadCart();
                  } else {
                    Toast.show("Failed", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  }
                }).catchError((err) {
                  print(err);
                });
              },
              child: Text(
                "Yes",
                style: TextStyle(
                  color: Color.fromRGBO(101, 255, 218, 50),
                ),
              )),
          MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Color.fromRGBO(101, 255, 218, 50),
                ),
              )),
        ],
      ),
    );

  }

}

