import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:skybus/user.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'cartscreen.dart';
import 'paymenthistory.dart';
//import 'profilescreen.dart';

void main() => runApp(MainScreen());

class MainScreen extends StatefulWidget {
  final User user;

  const MainScreen({Key key, this.user}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List busdata;
  int curnumber = 1;
  double screenHeight, screenWidth;
  bool visible = false;
  String curtype = "Recent";
  String cartquantity = "0";
  int quantity = 1;
  bool _isadmin = false;
  String titlecenter = "Loading...";
  String selectedOrigin,selectedDes;
  List<String> originlist=[
    "Johor Bahru",
    "Kluang",
  ];
  List<String> deslist=[
  "Johor Bahru",
    "Kluang",
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
   _loadTicketQuantity();
    if (widget.user.email == "admin@skyBus.com") {
    _isadmin = true;}
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    TextEditingController _prdController = new TextEditingController();
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        drawer: mainDrawer(context),
        appBar: AppBar(
          title: Text(
            'Schedule Selection',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: visible
                  ? new Icon(Icons.expand_more)
                  : new Icon(Icons.expand_less),
              onPressed: () {
                setState(() {
                  if (visible) {
                    visible = false;
                  } else {
                    visible = true;
                  }
                });
              },
            ),
          ],
        ),
        body: Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: <
                  Widget>[
            Visibility(
                visible: visible,
                child: Card(
                    elevation: 10,
                    child: Padding(
                        padding: EdgeInsets.all(5),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  FlatButton(
                                      onPressed: () => _sortCompany("Recent"),
                                      color: Colors.blueAccent,
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        children: <Widget>[
                                          Icon(MdiIcons.update,
                                              color: Colors.black),
                                          Text("Recent",
                                              style: TextStyle(
                                                  color: Colors.black)),
                                        ],
                                      )),
                                ],
                              ),
                              SizedBox(width: 3),
                              Column(
                                children: <Widget>[
                                  FlatButton(
                                      onPressed: () => _sortCompany("S&S EXPRESS"),
                                      color: Colors.blueAccent,
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        children: <Widget>[
                                          Icon(
                                            MdiIcons.seat,
                                            color: Colors.black,
                                          ),
                                          Text("S&S EXPRESS",
                                              style: TextStyle(
                                                  color: Colors.black)),
                                        ],
                                      )),
                                ],
                              ),
                              SizedBox(width: 3),
                              Column(
                                children: <Widget>[
                                  FlatButton(
                                      onPressed: () => _sortCompany("KKKL EXPRESS"),
                                      color: Colors.blueAccent,
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        children: <Widget>[
                                          Icon(
                                            MdiIcons.seatReclineExtra,
                                            color: Colors.black,
                                          ),
                                          Text("KKKL EXPRESS",
                                              style: TextStyle(
                                                  color: Colors.black)),
                                        ],
                                      )),
                                ],
                              ),
                              SizedBox(width: 3),
                              Column(
                                children: <Widget>[
                                  FlatButton(
                                      onPressed: () =>_sortCompany("CAUSEWAY LINK"),
                                      color: Colors.blueAccent,
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        children: <Widget>[
                                          Icon(
                                            MdiIcons.seatReclineNormal,
                                            color: Colors.black,
                                          ),
                                          Text("CAUSEWAY LINK",
                                              style: TextStyle(
                                                  color: Colors.black)),
                                        ],
                                      )),
                                ],
                              ),
                                    SizedBox(width: 3),
                              Column(
                                children: <Widget>[
                                  FlatButton(
                                      onPressed: () => _sortCompany("CEPAT EXPRESS"),
                                      color: Colors.blueAccent,
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        children: <Widget>[
                                          Icon(
                                            MdiIcons.seatReclineExtra,
                                            color: Colors.black,
                                          ),
                                          Text("CEPAT EXPRESS",
                                              style: TextStyle(
                                                  color: Colors.black)),
                                        ],
                                      )),
                                ],
                              ),
                            ],
                          ),
                        )))),
            Visibility(
                    visible: visible,
                    child: Card(
                      elevation: 5,
                      child: Container(
                        height: screenHeight / 12.5,
                        margin: EdgeInsets.fromLTRB(20, 2, 20, 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Flexible(
                                child: Container(
                              height: 30,
                              child: TextField(
                                  style: TextStyle(
                                    color: Colors.black87,
                                  ),
                                  autofocus: false,
                                  controller: _prdController,
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.search),
                                      border: OutlineInputBorder())),
                            )),
                        Flexible(
                            child: MaterialButton(
                                color:  Color.fromRGBO(101, 255, 218, 50),
                                onPressed: () => {_sortdeparturestation(_prdController.text)},
                                elevation: 5,
                                child: Text(
                                  "Search",
                                  style: TextStyle(color: Colors.black),
                                ))),
                      ],
                    ),
                  ),
                )),
            Text(curtype,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            busdata == null
                ? Flexible(
                    child: Container(
                        child: Center(
                            child: Text(
                    titlecenter,
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ))))
                : Expanded(
                    child: ListView.builder(
                        itemCount: busdata.length,
                        itemBuilder: (context, index) {
                          //index -= 0;
                          return Column(
                            children: <Widget>[
                              InkWell(
                                  onTap: () => {insertTicketdialog(index)}, //addTicket(index),
                                  child: Card(
                                    elevation: 10,
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Row(
                                        children: <Widget>[
                                            Column(
                                      children: <Widget>[
                                        Container(
                                          height: screenHeight / 8,
                                          width: screenWidth / 5,
                                         child: ClipOval(
                                            child: CachedNetworkImage(
                                              fit:BoxFit.fill,
                                              imageUrl:"https://smileylion.com/skyBus/busimage/${busdata[index]['company']}.jpg",
                                              placeholder: (context, url) =>
                                                new CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    new Icon(Icons.error),

                                            ),
                                          ),
                                        ),
                                       ] ),
                                          SizedBox(width: 10),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(busdata[index]['departurestation'].toString() +
                                                  " --> " +
                                                  busdata[index]
                                                      ['arrivalstation'].toString(),
                                                      style: TextStyle(fontSize:16,fontWeight: FontWeight.bold)),
                                              Text(busdata[index]
                                                      ['departuretime'].toString() +
                                                  " --> " +
                                                  busdata[index]
                                                      ['arrivaltime'].toString(),
                                                      style: TextStyle(fontSize:15,fontWeight: FontWeight.bold)),
                                              Text("RM"+ busdata[index]['price'],style: TextStyle(fontSize:15,fontWeight: FontWeight.bold)),
                                             // Text(busdata[index]['company'],style: TextStyle(fontSize:15,fontWeight: FontWeight.bold)),
                                               Text(busdata[index]['quantity']+  " seats",style: TextStyle(fontSize:15,fontWeight: FontWeight.bold))
                                            ],
                                          )),
                                        ],
                                      ),
                                    ),
                                  ))
                            ],
                          );
                        }),
                  )
          ]),
        ),
         floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              if (widget.user.email == "unregistered") {
                Toast.show("Please register to use this function", context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                return;
              } else if (widget.user.email == "admin@skyBus.com") {
                Toast.show("Admin mode!!!", context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                return;
              } else if (widget.user.quantity == "0") {
                Toast.show("Cart empty", context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                return;
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>CartScreen(
                              user: widget.user,
                            )));
                      _loadData();
                     _loadTicketQuantity();      
              }
            },
            icon: Icon(Icons.add_shopping_cart),
            label: Text(cartquantity,
             style: TextStyle(fontSize: 16.0, color: Colors.black)
            ),
            backgroundColor:Colors.blueAccent,
          ),
      ),
    );
  }

  void _loadData() async {
    String urlLoadJobs = "https://smileylion.com/skyBus/php/load_schedule.php";
    await http.post(urlLoadJobs, body: {}).then((res) {
      if (res.body == "nodata") {
        cartquantity = "0";
        titlecenter = "No bus found";
        setState(() {
          busdata = null;
        });
      } else {
        setState(() {
          var extractdata = json.decode(res.body);
          busdata = extractdata["SCHEDULE"];
          cartquantity = widget.user.quantity;
        });
   
      }
    }).catchError((err) {
      print(err);
    });
  }
  void _loadTicketQuantity() async {
    String urlLoadJobs = "https://smileylion.com/skyBus/php/load_ticketquantity.php";
    await http.post(urlLoadJobs, body: {
      "email": widget.user.email,
    }).then((res) {
      if (res.body == "nodata") {
      } else {
        widget.user.quantity = res.body;
      }
    }).catchError((err) {
      print(err);
    });
  }
 
  Widget mainDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(widget.user.name),
            accountEmail: Text(widget.user.email),
            otherAccountsPictures: <Widget>[
              Text("RM " + widget.user.credit,
              style: TextStyle(fontSize: 16.0, color: Colors.white)),
            ],
            currentAccountPicture: CircleAvatar(
              backgroundColor:
                  Theme.of(context).platform == TargetPlatform.android
                      ? Colors.white
                      : Colors.black,
              child: Text(
              widget.user.name.toString().substring(0, 1).toUpperCase(),
              style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          ListTile(
            title: Text("Bus List"),
            trailing: Icon(Icons.arrow_forward),
          onTap: () => {
                    Navigator.pop(context),
                    _loadData(),
                  }),
          ListTile(
            title: Text("Shopping Cart"),
            trailing: Icon(Icons.arrow_forward),    
             onTap: () => {
                    Navigator.pop(context),
                    gotoCart(),
                  }
          ),
          ListTile(
            title: Text("Purchased History"),
            trailing: Icon(Icons.arrow_forward),
             onTap: () => {
                    Navigator.pop(context),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                PaymentHistoryScreen(
                                  user: widget.user,
                                ))),
                  }
          ),
          ListTile(
            title: Text("User Profile"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => {
                    Navigator.pop(context),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>null, //ProfileScreen(
                                  //user: widget.user,)
                                ))
                  }),  ],
      ),
    );
  }

  _sortCompany(String company) {
    try {
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: true);
      pr.style(message: "Searching...");
      pr.show();
      String urlLoadJobs =
          "https://smileylion.com/skyBus/php/load_schedule.php";
      http.post(urlLoadJobs, body: {
        "company": company,
      }).then((res) {
         if (res.body == "nodata") {
          setState(() {
            busdata = null;
            curtype = company;
            titlecenter = "No bus found";
          });
          pr.dismiss();
        } else {
          setState(() {
            curtype = company;
            var extractdata = json.decode(res.body);
            busdata = extractdata["SCHEDULE"];
            FocusScope.of(context).requestFocus(new FocusNode());
            pr.dismiss();
          });
        }
      }).catchError((err) {
        print(err);
        pr.dismiss();
      });
      pr.dismiss();
    } catch (e) {
      Toast.show("Error", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

   void _sortdeparturestation(String departurestation) {
    try {
      print(departurestation);
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: true);
      pr.style(message: "Searching...");
      pr.show();
      String urlLoadJobs =
         "https://smileylion.com/skyBus/php/load_schedule.php";
      http
          .post(urlLoadJobs, body: {
            "departurestation": departurestation.toString(),
          })
          .timeout(const Duration(seconds: 4))
          .then((res) {
            if (res.body == "nodata") {
              Toast.show("Station not found", context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              pr.dismiss();
               setState(() {
                titlecenter = "No bus found";
                curtype = "search for " + "'" + departurestation + "'";
                busdata = null;
              });
              FocusScope.of(context).requestFocus(new FocusNode());

              return;
            } else {
              setState(() {
                var extractdata = json.decode(res.body);
                busdata = extractdata["SCHEDULE"];
                FocusScope.of(context).requestFocus(new FocusNode());
                //curtype = prname;
                curtype = "search for " + "'" + departurestation + "'";
                pr.dismiss();
              });
            }
          })
          .catchError((err) {
            pr.dismiss();
          });
      pr.dismiss();
    } on TimeoutException catch (_) {
      Toast.show("Time out", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } on SocketException catch (_) {
      Toast.show("Time out", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } catch (e) {
      Toast.show("Error", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }
            
 insertTicketdialog(int index) {
    if (widget.user.email == "unregistered@skyBus.com") {
      Toast.show("Please register to use this function", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (widget.user.email == "admin@skyBus.com") {
      Toast.show("Admin Mode!!!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    quantity = 1;
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, newSetState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: new Text(
                "Add " + busdata[index]['id'] + " to Cart?",
                style: TextStyle(
                  color: Colors.black87,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Select quantity of product",
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () => {
                            newSetState(() {
                                if (quantity > 1) {
                                  quantity--;
                                }
                              })
                              
                            },
                            child: Icon(
                              MdiIcons.minus,
                              color: Color.fromRGBO(101, 255, 218, 50),
                            ),
                          ),
                          Text(
                            quantity.toString(),
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                          ),
                          FlatButton(
                            onPressed: () => {
                            newSetState(() {
                                if (quantity <
                                    (int.parse(busdata[index]['quantity']) -
                                        10)) {
                                  quantity++;
                                } else {
                                  Toast.show("Quantity not available", context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.BOTTOM);
                                }
                              })
                            },
                            child: Icon(
                              MdiIcons.plus,
                              color: Color.fromRGBO(101, 255, 218, 50),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              actions: <Widget>[
                MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                      insertTicket(index);
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
            );
          });
        });
  }


  void insertTicket(int index) {
    try {
      int bquantity = int.parse(busdata[index]["quantity"]);
      print(bquantity);
      print(busdata[index]["id"]);
      print(widget.user.email);
      if (bquantity > 0) {
        ProgressDialog pr = new ProgressDialog(context,
            type: ProgressDialogType.Normal, isDismissible: true);
        pr.style(message: "Add to cart...");
        pr.show();
        String urlLoadJobs =
          "https://smileylion.com/skyBus/php/insert_ticket.php";
        http.post(urlLoadJobs, body: {
          "email": widget.user.email,
          "busid": busdata[index]["id"],
          "quantity": quantity.toString(),
        }).then((res) {
          print(res.body);
          if (res.body == "failed") {
            Toast.show("Failed add to cart", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            pr.dismiss();
            return;
          } else {
            List respond = res.body.split(",");
            setState(() {
              cartquantity = respond[1];
              widget.user.quantity = cartquantity;
            });
            Toast.show("Success add to cart", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          }
          pr.dismiss();
        }).catchError((err) {
          print(err);
          pr.dismiss();
        });
        pr.dismiss();
      } else {
        Toast.show("Out of stock", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    } catch (e) {
      Toast.show("Failed add to cart", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }
gotoCart() async {
    if (widget.user.email == "unregistered") {
      Toast.show("Please register to use this function", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    } else if (widget.user.email == "admin@grocery.com") {
      Toast.show("Admin mode!!!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    } else if (widget.user.quantity == "0") {
      Toast.show("Cart empty", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => CartScreen(
                    user: widget.user,
                  )));
                   _loadData();
                   _loadTicketQuantity();
    
    }
  }
  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: new Text(
              'Are you sure?',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            content: new Text(
              'Do you want to exit an App',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                  child: Text(
                    "Exit",
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
        ) ??
        false;
  }
    
  

  }

