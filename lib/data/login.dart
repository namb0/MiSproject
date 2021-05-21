import 'package:flutter/material.dart';



class Logindatacheck {

  String username = '0', password = '0';

  Logindatacheck(String username, String password) {
    this.username = username;
    this.password = password;
  }

  void loginUser ( BuildContext context){

    if(username == 'John' && password =='123')
       Navigator.pushReplacementNamed(context, '/home');
    else
       Navigator.pushReplacementNamed(context, '/login');
    }
}




//  String username;
//     String pw;
    
//     print('logged in!');
//     Navigator.pushReplacementNamed(context, '/home');


//     login(String username,String pw){

//       this.username = username;
//       this.pw = pw;
//     };
