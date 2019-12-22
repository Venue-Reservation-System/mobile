
import 'package:clippers/service/UserService.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SecurityHandler{


  Future getToken(data) async{

    Future res = new UserService().getCreadentials(data);

    res.then((onValue) => {

      dowork(onValue)

    }

    );

  return res;
  }


  dowork(tokendata) async {


    if(tokendata.statusCode == 200){

      final prefs = await SharedPreferences.getInstance();

      var resposbody = jsonDecode(tokendata.body);

      var token = resposbody["accessToken"];

      prefs.setString("token", token);

      print("tokenn "+token);



    }

  }









}