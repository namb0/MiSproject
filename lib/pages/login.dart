import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  void login() {
   
    print('logged in!');
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
                padding: EdgeInsets.only(bottom: 40,top: 100),
                child: Text(
                  'Luca QR Certification App',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.teal.shade500,
                      fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                  //hoverColor: Colors.teal.shade500,
                  //focusColor: Colors.teal.shade500,
                  //fillColor: Colors.teal.shade500,
                  
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              child: TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 8),
                  child: ElevatedButton(
                    child: Text('Login'),
                    onPressed: login,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5);
                          return Colors.teal.shade500; // Use the component's default.
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
