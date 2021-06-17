import 'package:flutter/material.dart';
import 'package:certificate_app/data/login.dart';
import 'package:certificate_app/pages/home.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var usercontroller = TextEditingController();
  var pwcontroller = TextEditingController();

  Future<bool> checkIfSharedPrefsExists() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.containsKey('name');
  }

  void login(String username, String pw) {
    Logindatacheck userData = Logindatacheck(username, pw);

    userData.loginUser(context);

    //return 0;
  }

  Future<void> openBrowserTab(String url) async {
    await FlutterWebBrowser.openWebPage(url: url);
  }

  @override
  Widget build(BuildContext context) {
    const String toLaunch = 'https://krisc-informatica.be/fhaachen/';
    return FutureBuilder(
        future: checkIfSharedPrefsExists(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.data == true) {
            return Home();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return SafeArea(
              child: Scaffold(
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 40, top: 100),
                        child: Text(
                          'Luca QR Certification App',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.teal.shade500,
                            fontSize: 25,
                            fontFamily: 'Roboto-Medium',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                      child: TextFormField(
                        controller: usercontroller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'User number (uXXXXXX)',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(
                                width: 1, color: Colors.teal.shade500),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      child: TextFormField(
                        controller: pwcontroller,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Base64 code',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(
                                width: 1, color: Colors.teal.shade500),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 50, vertical: 8),
                          child: ElevatedButton(
                            child: Text('Login'),
                            onPressed: () {
                              login(usercontroller.text, pwcontroller.text);
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed))
                                    return Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.5);
                                  return Colors.teal
                                      .shade500; // Use the component's default.
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 50, vertical: 8),
                          child: TextButton(
                            onPressed: () {
                              openBrowserTab(toLaunch);
                            },
                            child: Text('Register here'),
                            style: TextButton.styleFrom(
                                primary: Colors.teal.shade500),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
