import 'package:doc_app/Constants/DoctorList.dart';
import 'package:doc_app/Screens/DoctorPage/DoctorPage.dart';
import 'package:doc_app/Screens/HomePage/HomePage.dart';
import 'package:doc_app/chatbot.dart';
import 'package:doc_app/chatroom.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../home.dart';

// class BottomNavBar extends StatelessWidget {

//   const BottomNavBar({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {

//     return BottomNavigationBar(
//       items: [
//         BottomNavigationBarItem(
//             icon: Icon(
//               Icons.home,
//               color: Colors.black54,
//               size: 30,
//             ),
//             label: "Home"),
//         BottomNavigationBarItem(
//             icon: Icon(
//               Icons.message,
//               color: Colors.black54,
//               size: 30,
//             ),
//             label: "Chat"),
//         BottomNavigationBarItem(
//             icon: Icon(
//               Icons.calendar_today,
//               color: Colors.black54,
//               size: 30,
//             ),
//             label: "Schedule"),
//       ],
//     );
//   }
// }
class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

/// This is the private State class that goes with BottomNavBar.
class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final List<Widget> _widgetOptions = <Widget>[
    HomePage2(),
    ChatBotPage(),
    DoctorPage(doctor: kDoctorList?.first,)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        // animationDuration: Duration(milliseconds: 1000),
        fixedColor: Color(0xffF38BA0),
        // animationCurve: Curves.easeInOutQuad,
        // height: 70,
        // buttonBackgroundColor: Colors.blueGrey.shade100,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label:"YO" ),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble),label:"YO"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today),label:"YO"),
        ],
        onTap: _onItemTapped,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
