import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'newtickets.dart';
import 'edittickets.dart';
import 'schedule.dart';
import 'package:skybus/user.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'cartscreen.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class AdminTickets extends StatefulWidget {
  final User user;

  const AdminTickets({Key key, this.user}) : super(key: key);

  @override
  _AdminTicketsState createState() => _AdminTicketsState();
}

class _AdminTicketsState extends State<AdminTickets> {
  List busdata;
  int curnumber = 1;
  double screenHeight, screenWidth;
  bool _visible = false;
  String curtype = "Recent";
  String cartquantity = "0";
  int quantity = 1;
  String titlecenter = "Loading products...";
  var _tapPosition;
  String server = "https://smileylion.com/skyBus";
  String scanPrId;

  @override
  void initState() {
    super.initState();
    _loadData();
  }
@override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    TextEditingController _prdController = new TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Manage Your Products',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: _visible
                ? new Icon(Icons.expand_more)
                : new Icon(Icons.expand_less),
            onPressed: () {
              setState(() {
                if (_visible) {
                  _visible = false;
                } else {
                  _visible = true;
                }
              });
            },
          ),

          //
        ],
      ),
 body: 
 Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: <
                  Widget>[
            Visibility(
                visible: _visible,
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
                    visible: _visible,
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
                                  
                                  onTap: () => _showPopupMenu(index),
                                   onTapDown: _storePosition,
                               
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
                                              imageUrl: server +"/busimage/${busdata[index]['company']}.jpg",
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
                                               Text(" Avail/Sold " + busdata[index]['quantity'] + "/" + busdata[index]['sold'] + " seats" ,style: TextStyle(fontSize:15,fontWeight: FontWeight.bold)),
                                           
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
           floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
              child: Icon(Icons.new_releases),
              label: "New Product",
              labelBackgroundColor: Colors.white,
              onTap: createNewProduct),
          SpeedDialChild(
              child: Icon(MdiIcons.barcodeScan),
              label: "Scan Product",
              labelBackgroundColor: Colors.white, //_changeLocality()
              onTap: () => scanProductDialog()),
          SpeedDialChild(
              child: Icon(Icons.report),
              label: "Product Report",
              labelBackgroundColor: Colors.white, //_changeLocality()
              onTap: () => null),
        ],
      ),
    );
  }
   void scanProductDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: new Text(
            "Select scan options:",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              MaterialButton(
                  color: Color.fromRGBO(101, 255, 218, 50),
                  onPressed: scanBarcodeNormal,
                  elevation: 5,
                  child: Text(
                    "Bar Code",
                    style: TextStyle(color: Colors.black),
                  )),
              MaterialButton(
                  color: Color.fromRGBO(101, 255, 218, 50),
                  onPressed: scanQR,
                  elevation: 5,
                  child: Text(
                    "QR Code",
                    style: TextStyle(color: Colors.black),
                  )),
            ],
          ),
        );
      },
    );
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      if (barcodeScanRes == "-1") {
        scanPrId = "";
      } else {
        scanPrId = barcodeScanRes;
        Navigator.of(context).pop();
        _loadSingleProduct(scanPrId);
      }
    });
  }

  void _loadSingleProduct(String busid) {
    String urlLoadJobs = server + "/php/load_schedule.php";
    http.post(urlLoadJobs, body: {
      "busid": busid,
    }).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        Toast.show("Not found", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      } else {
        setState(() {
          var extractdata = json.decode(res.body);
          busdata = extractdata["SCHEDULE"];
          print(busdata);
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      if (barcodeScanRes == "-1") {
        scanPrId = "";
      } else {
        scanPrId = barcodeScanRes;
        Navigator.of(context).pop();
        _loadSingleProduct(scanPrId);
      }
    });
  }
    void _loadData() async {
    String urlLoadJobs = "https://smileylion.com/skyBus/php/load_schedule.php";
    await http.post(urlLoadJobs, body: {}).then((res) {
         print(res.body);
        setState(() {
          var extractdata = json.decode(res.body);
          busdata = extractdata["SCHEDULE"];
          cartquantity = widget.user.quantity;
        });
    }).catchError((err) {
      print(err);
    });
  }
  
  _sortCompany(String company) {
    try {
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: true);
      pr.style(message: "Searching...");
      pr.show();
      String urlLoadJobs =
         server+"/php/load_schedule.php";
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
        server + "/php/load_schedule.php";
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
              
              FocusScope.of(context).requestFocus(new FocusNode());

              return;
            } else {
              setState(() {
                var extractdata = json.decode(res.body);
                busdata = extractdata["SCHEDULE"];
                FocusScope.of(context).requestFocus(new FocusNode());
                curtype = departurestation;
                //curtype = "search for " + "'" + departurestation + "'";
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
  gotoCart()  {
    if (widget.user.email == "unregistered") {
      Toast.show("Please register to use this function", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }else{
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => CartScreen(
                    user: widget.user,
                  )));
                  
    
    }
  }
    _onProductDetail(int index) async {
    print(busdata[index]['id']);
      Schedule schedule = new Schedule(
         id: busdata[index]['id'],
        departurestation: busdata[index]['departurestation'],
        arrivalstation: busdata[index]['arrivalstation'],
        price: busdata[index]['price'],
        quantity: busdata[index]['quantity'],
        departuretime: busdata[index]['departuretime'],
        arrivaltime: busdata[index]['arrivaltime'],
        company: busdata[index]['company'],
        date: busdata[index]['date']);
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => EditTickets(
                  user: widget.user,
                  schedule: schedule,
                )));
    _loadData();
  }
  _showPopupMenu(int index) async {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();

    await showMenu(
      context: context,
      color: Colors.white,
      position: RelativeRect.fromRect(
          _tapPosition & Size(40, 40), // smaller rect, the touch area
          Offset.zero & overlay.size // Bigger rect, the entire screen
          ),
      items: [
        //onLongPress: () => _showPopupMenu(), //onLongTapCard(index),

        PopupMenuItem(
          child: GestureDetector(
              onTap: () =>
                  {Navigator.of(context).pop(), _onProductDetail(index)},
              child: Text(
                "Update Product?",
                style: TextStyle(
                  color: Colors.black,
                ),
              )),
        ),
        PopupMenuItem(
          child: GestureDetector(
              onTap: () =>
                  {Navigator.of(context).pop(), _deleteProductDialog(index)},
              child: Text(
                "Delete Product?",
                style: TextStyle(color: Colors.black),
              )),
        ),
      ],
      elevation: 8.0,
    );
  }

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  void _deleteProductDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: new Text(
            "Delete Product Id " + busdata[index]['id'],
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          content:
              new Text("Are you sure?", style: TextStyle(color: Colors.black)),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "Yes",
                style: TextStyle(
                  color: Color.fromRGBO(101, 255, 218, 50),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteProduct(index);
              },
            ),
            new FlatButton(
              child: new Text(
                "No",
                style: TextStyle(
                  color: Color.fromRGBO(101, 255, 218, 50),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteProduct(int index) {
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Deleting bus ticket...");
    pr.show();
  
    http.post(server + "/php/delete_bus.php", body: {
      "id":busdata[index]['id'],
    }).then((res) {
      print(res.body);
      pr.dismiss();
      if (res.body == "success") {
        Toast.show("Delete success", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        _loadData();
        Navigator.of(context).pop();
      } else {
        Toast.show("Delete failed", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }).catchError((err) {
      print(err);
      pr.dismiss();
    });
  }

  Future<void> createNewProduct() async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => NewTickets()));
    _loadData();
  }
}