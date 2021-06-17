import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:string_validator/string_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logindatacheck {
  String username = '0', password = '0';

  Logindatacheck(String username, String password) {
    this.username = username;
    this.password = password;
  }

  void loginUser(BuildContext context) async {
    if (username.length == 7 && isAlphanumeric(username) && (matches(username, 'r') || matches(username, 'u')) && isBase64(password)) {
      String decoded = utf8.decode(base64.decode(password));
      List<String> split = decoded.split('|');
      print(split);
      String name = split.elementAt(1);
      String studentnumber = split.first;
      String secret = split.last;

      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('name', name);
      sharedPreferences.setString('student number', studentnumber);
      sharedPreferences.setString('secret', secret);
      sharedPreferences.setString('base64encoded', password);

      Navigator.pushReplacementNamed(context, '/home');
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Please insert valid login information!'),
            );
          });
    }
  }
}
