import 'package:clippers/model/model.dart';
import 'package:flutter/material.dart';
import 'package:clippers/service/UserService.dart';
import 'package:fluttertoast/fluttertoast.dart';





class Register extends StatefulWidget {
  @override
  _RegisterForm createState() => _RegisterForm();

}


class _RegisterForm extends State<Register>{





  GlobalKey<FormState> _key = new GlobalKey();

  bool _validate = false;
  String name, email, mobile,password,confirm_password;

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

    String validateMobile(String value) {

      String patttern = r'(^[0-9]*$)';
      RegExp regExp = new RegExp(patttern);
      if (value.length == 0) {
        return "Mobile is Required";
      } else if(value.length != 14){
        return "Mobile number must 10 digits";
      }else if (!regExp.hasMatch(value)) {
        return "Mobile Number must be digits";
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
      }

      return null;
    }

    _sendToServer() async {
      if (_key.currentState.validate()) {
        // No any error in validation
        _key.currentState.save();

        UserService us =  new UserService();
        await us.save(_user);

        Fluttertoast.showToast(
            msg: "please varify your email",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIos: 1,
            backgroundColor: Colors.black.withOpacity(0.6),
            textColor: Colors.white,
            fontSize: 15.0,

        );






        print("Name " + _user.username);
        print("Mobile "+ _user.password);
        print("Email "+_user.email);
      } else {
        // validation error
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
                                      'Sign up',textAlign: TextAlign.center,
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
//                                      name = val;
//                                      print(name);
                                    },
                                  ),
//                                  new TextFormField(
//
//                                    style: TextStyle(
//                                        fontSize: 14.0,
//                                        color: Colors.white
//
//                                    ),
//                                      decoration: new InputDecoration(
//
//                                        labelText: 'Mobile Number',
//                                        labelStyle: TextStyle(
//                                            color: Colors.white
//                                        ),
//                                      ),
//
//
//
//
//                                      keyboardType: TextInputType.phone,
//                                      maxLength: 10,
//                                      validator: validateMobile,
//                                      onSaved: (String val) {
//                                        mobile = val;
//                                      }),
                                  new TextFormField(
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.white

                                      ),
                                      decoration: new InputDecoration(

                                        labelText: 'Email',
                                        labelStyle: TextStyle(
                                            color: Colors.white
                                        ),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      maxLength: 32,
                                      validator: validateEmail,
                                      onSaved: (String val) {
                                        _user.email = val;
                                      //  email = val;
                                      }),

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

                                  new TextFormField(

                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.white

                                      ),
                                      decoration: new InputDecoration(

                                        labelText: 'Confirm Password',
                                        labelStyle: TextStyle(
                                            color: Colors.white
                                        ),
                                      ),
                                      obscureText: true,
                                      keyboardType: TextInputType.emailAddress,
                                      maxLength: 10,
                                      validator: validateConfirmPassword,
                                      onSaved: (String val) {
                                        confirm_password = val;
                                      }),


                                Container(

                                    width: double.infinity,
                                    child: Row(
//                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
//                                        Checkbox(
////                                          value: checkboxValueB,
//                                          onChanged: (bool value) {
//                                            setState(() {
////                                              checkboxValueB = value;
//                                            });
//                                          },
//                                        ),
                                        InkWell(
                                          child: Text(
                                              'I have read and understood \nthe terms and conditions'),
                                          onTap: () {
//                                            launch("https://google.com");
                                          },
                                        ),

                                      ],
                                    ),
                                    padding: EdgeInsets.all(1),
                                  ),

                                  Container(
                                    height: 30,
                                    padding: EdgeInsets.only(left: 2),
                                    child: Center(
                                      child: GestureDetector(
                                          child: Text(
                                              "Terms and Conditions",
                                              style: TextStyle(
                                                  decoration:
                                                  TextDecoration
                                                      .underline,
                                                  color: Colors.blue)),
                                          onTap: () {
                                            // _launchURL();
                                          }),
                                    ),

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
                                            child: const Text('Let\'s go',
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







//******************************************************************************************************************************************










//*****************************************************************************************************************************************



















//import 'package:flutter/material.dart';
//
//class Register extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//
//    return Scaffold(
//
//      body: Stack(
//
//        children: <Widget>[
//
//          Container(
//
//            width: double.infinity,
//            height: double.infinity,
//            decoration: BoxDecoration(
//              gradient: LinearGradient(
//                  begin: Alignment.topLeft,
//                  end: Alignment.centerRight,
//                  colors: [Colors.black87 , Colors.blueGrey[500]])
//
//          )
//
//          ),
//          ClipPath(
//
//            child: Container(
//
//              width: double.infinity,
//              height: double.infinity,
////              color: Colors.green,
//                decoration: BoxDecoration(
//                  boxShadow: [
//                    BoxShadow(
//                      color: Colors.grey.withOpacity(0.2),
//                      spreadRadius: 10,
//                      blurRadius: 5,
//                      offset: Offset(0, 55), // changes position of shadow
//                    ),
//                  ],
//
//
//                )
//            ),
//            clipper: CustomClipPath_1(),
//
//          ),
//
//          ClipPath(
//
//            child: Container(
//
//                width: double.infinity,
//                height: double.infinity,
////              color: Colors.green,
//                decoration: BoxDecoration(
//                  boxShadow: [
//                    BoxShadow(
//                      color: Colors.grey.withOpacity(0.3),
//                      spreadRadius: 20,
//                      blurRadius: 20,
//                      offset: Offset(0, 50), // changes position of shadow
//                    ),
//                  ],
//
//
//                )
//            ),
//            clipper: CustomClipPath_2(),
//
//          )
//
//        ],
//
//      )
//
//    );
//  }
//
//
//
//
//}
//
//
//class CustomClipPath_1 extends CustomClipper<Path> {
//  var radius=10.0;
//
//  @override
//  Path getClip(Size size) {
//    Path path = Path();
//    path.lineTo(0,200);
//    path.lineTo(size.width-100, size.height-180);
////
//    path.lineTo(90, size.height);
//    path.lineTo(size.width, size.height);
//    path.lineTo(size.width, 0);
//
//    path.close();
//
//    return path;
//
//  }
//
//  @override
//  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
//
//}
//
//
//
//
//class CustomClipPath_2 extends CustomClipper<Path> {
//
//
//  @override
//  Path getClip(Size size) {
//    Path path = Path();
//    path.lineTo(165,0);
//    path.lineTo(80,100);
//
//    path.lineTo(size.width, size.height-240);
//    path.lineTo(size.width, 0);
////    path.lineTo(size.width, 0);
//
//    path.close();
//
//    return path;
//
//  }
//
//  @override
//  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
//
//}