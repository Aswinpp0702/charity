import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class dashboard extends StatefulWidget {
  const dashboard({Key? key}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  int currentindex = 0;

  final Screens =[
    // User_home_page(),
    // Cart(),//0th position
    // Payment_User(),//1 st postion

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screens[currentindex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue[600],
        unselectedItemColor: Colors.grey,
        selectedFontSize: 15,
        unselectedFontSize: 13,
        currentIndex: currentindex,
        onTap: (Index) => setState(() => {currentindex = Index}),
        items: [


          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home',),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart',),

          BottomNavigationBarItem(icon: Icon(Icons.paypal), label: 'Payment',),
        ],
      ),
    );
  }
}
