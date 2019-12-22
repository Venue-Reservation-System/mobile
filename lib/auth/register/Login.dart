import 'package:clippers/Profile/VenuePage.dart';
import 'package:clippers/admin/venues/AddVenues.dart';
import 'package:clippers/model/model.dart';
import 'package:flutter/material.dart';
import 'package:clippers/service/UserService.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/SecurityHandler.dart';





class Login extends StatefulWidget {
  @override
  _LoginForm createState() => _LoginForm();

}


class _LoginForm extends State<Login>{

  GlobalKey<FormState> _key = new GlobalKey();

  bool _validate = false;
  String name, email, mobile,password,confirm_password;
  bool agreed = false;

//  String confirm_password;

  User _user = new User();


  final conf_pass_controller = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    conf_pass_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


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


    String validatePassword(String value) {


      return null;
    }

    String validateConfirmPassword(String value){

      String pass = conf_pass_controller.text;

      if(value != pass){
        return 'password missmatch';
      }

      return null;
    }

    handleResponse(data) async {

      if(data.statusCode == 200){


        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new AddVenue())

        );

        print("loggedddddddddddddddddd");

      }else{

        Fluttertoast.showToast(
          msg: "Credentials are not valid",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.black.withOpacity(0.6),
          textColor: Colors.white,
          fontSize: 15.0,

        );
        print("errrrrrooooooooo");
      }


    }

    _sendToServer() async {

      if (_key.currentState.validate() && agreed) {
        // No any error in validation
        _key.currentState.save();

        new SecurityHandler().getToken({"username" : _user.username, "password" : _user.password}).then((res) => {

          handleResponse(res)

        });

//        Fluttertoast.showToast(
//          msg: "please varify your email",
//          toastLength: Toast.LENGTH_SHORT,
//          gravity: ToastGravity.TOP,
//          timeInSecForIos: 1,
//          backgroundColor: Colors.black.withOpacity(0.6),
//          textColor: Colors.white,
//          fontSize: 15.0,
//
//        );

      } else {

        if(!agreed){

          Fluttertoast.showToast(
            msg: "please select term & conditions !",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIos: 1,
            backgroundColor: Colors.black87.withOpacity(0.4),
            textColor: Colors.white,
            fontSize: 15.0,

          );
        }

        setState(() {
          _validate = true;
        });
      }
    }



    return Scaffold(

      body: Container(
//        margin: EdgeInsets.all(5),

          child: Stack(

            children: <Widget>[

              Container(


                  width: MediaQuery.of(context).size.width,
                  height: double.infinity,
                  decoration: BoxDecoration(

                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Colors.pink[300], Colors.white])

                  )

              ),

              ClipPath(

                child: Container(

                    width: MediaQuery.of(context).size.width,
                    height: 400,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Colors.blue, Colors.red]
                        )

                    )


                ),
                clipper: CustomClipPath(),

              ),

              Container(
                padding: const EdgeInsets.only(
                    top: 60, right: 12, bottom: 5, left: 12),

                child: ListView(
                  children: <Widget>[
                    Container(
                        width: double.infinity,
                        height: 500,
                        child: Card(
                          color: Colors.black26.withOpacity(0.1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            width: 930,
                            padding: const EdgeInsets.only(
                                right: 12, top: 10, left: 12),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: FlatButton.icon(
                                          icon: const Icon(Icons.arrow_back_ios,color: Colors.white,
                                          ),
                                          label: const Text('Back',style: TextStyle(color:Colors.white),
                                              semanticsLabel: 'FLAT BUTTON 2'),
                                          onPressed: () {

                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Login',textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Tomorrow',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            decoration: TextDecoration.none),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(),
                                    )
                                  ],
                                ),


                                Form(
                                  key: _key,
                                  autovalidate: _validate,

                                  child :Column(

                                    children: <Widget>[

                                      new TextFormField(

                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.white

                                        ),

                                        decoration: new InputDecoration(

                                          labelText: 'username',
                                          labelStyle: TextStyle(
                                              color: Colors.white
                                          ),
                                        ),
                                        maxLength: 8,
                                        validator: validateName,

                                        onSaved: (String val) {
                                          _user.username = val;

                                        },
                                      ),



                                      new TextFormField(

                                          controller: conf_pass_controller,
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.white

                                          ),
                                          decoration: new InputDecoration(

                                            labelText: 'Password',
                                            labelStyle: TextStyle(
                                                color: Colors.white
                                            ),
                                          ),
                                          obscureText: true,
                                          maxLength: 10,
                                          validator: validatePassword,
                                          onSaved: (String val) {
                                            password = val;
                                            _user.password = val;
                                          }),



                                      Container(

                                        width: double.infinity,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Checkbox(
                                              value: agreed,

                                              onChanged: (bool value) {
                                                setState(() {
                                                  agreed = value;
                                                });
                                              },

                                            ),
                                            InkWell(

                                              child: Text('remember-me'),
                                              onTap: () {
//                                            launch("https://google.com");
                                              },
                                            ),

                                          ],
                                        ),
                                        padding: EdgeInsets.all(1),
                                      ),


                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 1,
                                            child: ButtonTheme(
                                              padding: EdgeInsets.all(15),
//                                  minWidth: 300,
                                              buttonColor:
                                              Color.fromARGB(255, 255, 157, 0),
                                              child: RaisedButton(
                                                  child: const Text('Login',
                                                      style: TextStyle(
                                                        color: Colors.white,
//                                                  fontSize: 1,
                                                      ),
                                                      semanticsLabel:
                                                      'RAISED BUTTON 1'),
                                                  onPressed: _sendToServer
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),


                                    ],
                                  ),

                                ),
                              ],
                            ),
                          ),
                        ))
                  ],
                ),


                //****************************************************************************************
              )

            ],

          )

      ),

    );
  }




}


class CustomClipPath extends CustomClipper<Path> {

  var radius=10.0;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.quadraticBezierTo(0, 200, 30, 200);
//    path.quadraticBezierTo(3/4*size.width, size.height-80, size.width, size.height-450);
    path.lineTo(size.width-90, 200);
    path.quadraticBezierTo(size.width-60, 200, size.width, 350);
    path.lineTo(size.width, 0);

    path.close();



    return path;


  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;

}