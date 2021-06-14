import 'package:flutter/material.dart';

class bottomNavBar extends StatelessWidget {
  const bottomNavBar({
    Key? key,
    required int currentIndex,
  })   : _currentIndex = currentIndex,
        super(key: key);

  final int _currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      backgroundColor: Colors.teal.shade500,
      selectedItemColor: Colors.white,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        BottomNavigationBarItem(
            icon: Icon(Icons.home_work), label: 'Workspaces'),
        /*BottomNavigationBarItem(
            icon: Icon(Icons.edit), label: 'Certificates'),*/
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/home');
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/history');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/workspaces');
            break;
          /*case 3:
            Navigator.pushReplacementNamed(context, '/certificates');
            break;*/
        }
      },
    );
  }
}
