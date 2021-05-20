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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 160),
              child: Text(
                'Luca QR Certification App',
                style:
                    TextStyle(fontStyle: FontStyle.italic, color: Colors.cyan, fontSize: 25),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your username',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your Password',
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
                        return null; // Use the component's default.
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
                  style: TextButton.styleFrom(primary: Colors.purple),
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
