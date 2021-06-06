import 'package:flutter/material.dart';
import 'package:certificate_app/data/login.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var usercontroller = TextEditingController();
  var pwcontroller = TextEditingController();

  void login(String username, String pw) {
    Logindatacheck userData = Logindatacheck(username, pw);

    userData.loginUser(context);

    //return 0;
  }

  void pwfg() {
    print('i forgot my password');
  }

  @override
  Widget build(BuildContext context) {
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
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              child: TextFormField(
                controller: usercontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide:
                        BorderSide(width: 1, color: Colors.teal.shade500),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              child: TextFormField(
                controller: pwcontroller,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide:
                        BorderSide(width: 1, color: Colors.teal.shade500),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 8),
                  child: ElevatedButton(
                    child: Text('Login'),
                    onPressed: () {
                      login(usercontroller.text, pwcontroller.text);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5);
                          return Colors
                              .teal.shade500; // Use the component's default.
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: TextButton(
                    child: Text('Password Forgotten?'),
                    onPressed: pwfg,
                    style: TextButton.styleFrom(primary: Colors.teal.shade500),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
