import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class Data {
  String url;

  Data({@required this.url});

  Future getPrice() async {
    var decodedData;

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      decodedData = jsonDecode(response.body);
      return decodedData;
    } else {
      Fluttertoast.showToast(
          msg: "${response.statusCode} Something went wrong!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
