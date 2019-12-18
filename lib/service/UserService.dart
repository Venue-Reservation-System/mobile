


import 'dart:convert';

import 'package:clippers/model/model.dart';
import 'package:http/http.dart';

 class UserService {
  final String postsURL = "http://10.10.22.189:8080/api/user/register";

  Map<String, String> headers = {
    "content-type": "application/json"
  };


  Future<User> save(User data) async {

    data.name = "name";
    Response res = await post(postsURL ,headers: headers, body:jsonEncode(data));

    if (res.statusCode == 200) {

      return User.fromJson(json.decode(res.body));


    } else {
      throw new Exception("Error while fetching data ");
    }

  }
}