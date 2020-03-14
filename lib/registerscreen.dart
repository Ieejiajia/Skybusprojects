import 'package:flutter/material.dart';
import 'package:skybus/loginscreen.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
//import 'package:email_validator/email_validator.dart';

void main() => runApp(RegisterScreen());

class RegisterScreen extends StatefulWidget {

  RegisterScreen({Key key}) : super (key:key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
final GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  String name;
  String email;
  String mobile;
  String password;
  bool isPasswordVisible = false;
  bool _isChecked = false;
 double screenHeight;
 String urlRegister = "https://smileylion.com/skyBus/php/register_user.php";
  TextEditingController _nameEditingController = new TextEditingController();
  TextEditingController _emailEditingController = new TextEditingController();
  TextEditingController _phoneditingController = new TextEditingController();
  TextEditingController _passEditingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    //screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      
      home: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
          title:Text('New User Register'),
        backgroundColor: Colors.lightBlue,
          ),
      body:
            new SingleChildScrollView(
              child: new Container(
                margin: new EdgeInsets.fromLTRB(40, 90, 40, 60),
                child:new Form(
                  key: _key,
                  autovalidate:_validate ,
                  child: formUI(),
                                  ),
                                ),
                              ),
                            ),
                            );
                      
                    }
                  
  Widget formUI() {
    
    return new Column(
      children: <Widget>[
        new TextFormField(
          controller: _nameEditingController,
          keyboardType: TextInputType.text,
          decoration: new InputDecoration(hintText: 'Name',
          icon: Icon(Icons.account_circle)),
          maxLength: 32,
          validator: validateName,
          onSaved: (String val) {
            name = val;
          },
        ),  
        new TextFormField(
            
            decoration: new InputDecoration(hintText: 'Email',
            icon: Icon(Icons.email)), 
             controller: _emailEditingController,
            
            keyboardType: TextInputType.emailAddress,
             
            maxLength: 32,
            validator: validateEmail,
            onSaved: (String val) {
              email = val;
            }),
  
            new TextFormField(
            decoration: new InputDecoration(hintText: 'Mobile Number',
            icon: Icon(Icons.smartphone)),
            controller: _phoneditingController,
            keyboardType: TextInputType.phone,
            maxLength: 11,
            validator: validateMobile,
            onSaved: (String val) {
              mobile = val;
            }
            ),  new TextFormField(
          controller: _passEditingController,
             obscureText: !isPasswordVisible,  
           decoration: new InputDecoration(hintText: 'Password',
             suffixIcon: IconButton(
                      icon: Icon(isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                    icon: Icon(Icons.vpn_key)),
            keyboardType: TextInputType.phone,
            maxLength: 6,
            validator: validatePass,
            onSaved: (String val) {
              password = val;
            }, 
       ),
        SizedBox(height: 15.0),
        
     Row(
 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Checkbox(
                        value: _isChecked,
                        onChanged: (bool value) {
                          _onChange(value);
                        },
                      ),
                   GestureDetector(
                        onTap: _showEULA,
                        child: Text('I Agree to Terms  ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),     
                      
     MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        minWidth: 115,
                        height: 50,
                        child: Text('Register',
                           style: TextStyle(
                                fontSize: 19, 
                                )
                                ),
                        color: Colors.blue,
                        textColor: Colors.white,
                        elevation: 10,
                        onPressed: (){
                        if (_key.currentState.validate()) {
                         // No any error in validation
                          _key.currentState.save(); 
                           _onRegister();
                        } else{
                          setState(() {
                        _validate = true;  }); 
                        }
                         },
                      ),
      ],
     ),
                        
  SizedBox(
            height: 20,
          ),
Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Already register? ", style: TextStyle(fontSize: 16.0)),
              GestureDetector(
                onTap: _loginScreen,
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
)

      ],
    
    );
 
  }
  void _onRegister() {
    String name = _nameEditingController.text;
    String email = _emailEditingController.text;
    String mobile = _phoneditingController.text;
    String password = _passEditingController.text;
 if (!_isChecked) {
 Toast.show("Please Accept Term", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return; 
      }
     http.post(urlRegister, body: {
      "name": name,
      "email": email,
       "phone":mobile,
       "password": password,
     
    }).then((res) {
          print(res.statusCode);
         if (res.body == "success") {
        Toast.show(res.body, context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Toast.show("Registration success", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
           
      Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => LoginScreen()));
      } else {
        Toast.show("Registration failed", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }}).catchError((err) {
      print(err);
    });  
  
  }


 void _loginScreen() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
  }
void _onChange(bool value) {
    setState(() {
      _isChecked = value;
      //savepref(value);
    });
  }


  void _showEULA() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("EULA"),
          content: new Container(
            //height: screenHeight / 2,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: new SingleChildScrollView(
                    child: RichText(
                        softWrap: true,
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              //fontWeight: FontWeight.w500,
                              fontSize: 12.0,
                            ),
                            text:
                                "This End-User License Agreement (EULA) is a legal agreement between you and skyBusThis EULA agreement governs your acquisition and use of our skyBus software (Software) directly from skyBus or indirectly through a skyBus authorized reseller or distributor (a Reseller).Please read this EULA agreement carefully before completing the installation process and using the skyBus software. It provides a license to use the skyBus software and contains warranty information and liability disclaimers.If you register for a free trial of the skyBus software this EULA agreement will also govern that trial. By clicking accept or installing and/or using the skyBus software you are confirming your acceptance of the Software and agreeing to become bound by the terms of this EULA agreement.If you are entering into this EULA agreement on behalf of a company or other legal entity you represent that you have the authority to bind such entity and its affiliates to these terms and conditions. If you do not have such authority or if you do not agree with the terms and conditions of this EULA agreement do not install or use the Software and you must not accept this EULA agreement.This EULA agreement shall apply only to the Software supplied by skyBus herewith regardless of whether other software is referred to or described herein. The terms also apply to any skyBus updates supplements Internet-based services and support services for the Software unless other terms accompany those items on delivery. If so those terms apply. This EULA was created by EULA Template for skyBus.License Grant skyBus hereby grants you a personal non-transferable non-exclusive licence to use the skyBus software on your devices in accordance with the terms of this EULA agreement.You are permitted to load the skyBus software (for example a PC laptop mobile or tablet) under your control. You are responsible for ensuring your device meets the minimum requirements of the skyBus software.You are not permitted to Edit alter modify adapt translate or otherwise change the whole or any part of the Software nor permit the whole or any part of the Software to be combined with or become incorporated in any other software nor decompile disassemble or reverse engineer the Software or attempt to do any such things Reproduce copy distribute resell or otherwise use the Software for any commercial purposeAllow any third party to use the Software on behalf of or for the benefit of any third partyUse the Software in any way which breaches any applicable local national or international lawuse the Software for any purpose that skyBus considers is a breach of this EULA agreement Intellectual Property and OwnershipskyBus shall at all times retain ownership of the Software as originally downloaded by you and all subsequent downloads of the Software by you. The Software (and the copyright and other intellectual property rights of whatever nature in the Software including any modifications made thereto) are and shall remain the property of skyBus.skyBus reserves the right to grant licences to use the Software to third parties."
                            //children: getSpan(),
                            )),
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      
      },
    );
  }

     String validateName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

String validateEmail(String value) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if(!regExp.hasMatch(value)){
      return "Invalid Email";
    }else {
      return null;
    }
  }
  String validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length !=10 || value.length !=11 ) {
      return "Mobile number must 10 or 11 digits";
    } else if(value.length == 0 ){
      return "Mobile is Required";
    }else if  (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
  }
    String validatePass(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Password is Required";
    } else if(value.length != 6){
      return "Password must 6 digits";
    }else if (!regExp.hasMatch(value)) {
      return "Password must digits ";
    }
    return null;
  }

  }
  
  