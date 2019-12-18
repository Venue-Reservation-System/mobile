
import 'package:flutter/material.dart';

import 'auth/register/Register.dart';




class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    void navigate_to_dashboard(){

      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new Register()));


    }



    return Scaffold(


      body: Stack(

        children: <Widget>[

          Container(

              width: double.infinity,
              height: double.infinity,

              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Colors.blue, Colors.red])

              )

          ),

          ClipPath(


            child: Container(
              width: MediaQuery.of(context).size.width,
              height: double.infinity,

                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.blue, Colors.red])

                )
            ),
            clipper: CustomClipPath()


          ),
          
          Container(
            
            color: Colors.transparent,
            height: double.infinity,
            width: double.infinity,
            child: Column(

              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[

                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.transparent,


                  ),
                ),

                Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.transparent,
                  child: Align(

                      alignment:Alignment(0.0, 0.7),
                      child: CircleAvatar(
                        radius: 70.0,
                        backgroundColor: Colors.red.shade300,
                        child: CircleAvatar(

//
                          radius: 60,
                          backgroundImage: AssetImage('assets/uni.jpeg'),


                        ),
                      )

                  ),
                ),
              ),


                Expanded(
                  flex: 5,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[

                        SizedBox(height: 30,),
                        Text("Venue Resevation System",style: TextStyle(color: Colors.white,fontSize: 25),),
                        SizedBox(height: 10,),
                        Text("university of Moratuwa",style: TextStyle(color: Colors.white,fontSize: 20)),
                        SizedBox(height: 60),

                        RaisedButton(
                          child: Text("Navigate"),
                          onPressed: () {
                              navigate_to_dashboard();
                          }),

//                        CircularProgressIndicator(backgroundColor: Colors.lightBlueAccent,strokeWidth: 5,),



                      ],


                    ),
//                    color: Colors.red,
                  ),
                ),



//            child: CircularProgressIndicator(backgroundColor: Colors.green,),

                
              ],
              
              
            ),
            
            
          )



        ]
      )

    );
  }

}




class CustomClipPath extends CustomClipper<Path> {
  var radius=10.0;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height*5/6);
    path.quadraticBezierTo(size.width/4, size.height - 350, size.width/2, size.height-200);
    path.quadraticBezierTo(3/4*size.width, size.height-80, size.width, size.height-450);
    path.lineTo(size.width, 0);

    path.close();



    return path;


  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;

}