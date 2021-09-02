import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:doc_app/Constants/DoctorList.dart';
import 'package:doc_app/Screens/DoctorPage/DoctorPage.dart';
import 'package:doc_app/Screens/HomePage/HomePage.dart';
import 'package:doc_app/chatbot.dart';
import 'package:doc_app/home.dart';
import 'package:flutter/material.dart';

// class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({Key key}) : super(key: key);

//   @override
//   _BottomNavBarState createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {
//   @override
//   Widget build(BuildContext context) {
//     var _selectedIndex;
//     final List<Widget> _widgetOptions = <Widget>[
//       BottomNavBarPage2(),
//       ChatBotPage(),
//       DoctorPage(
//         doctor: kDoctorList?.first,
//       )
//     ];

//     void _onItemTapped(int index) {
//       setState(() {
//         _selectedIndex = index;
//       });
//     }

//     return Scaffold(
//       bottomNavigationBar: BottomNavigationBar(
//         onTap: _onItemTapped,
//         items: [
//           BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.BottomNavBar,
//                 color: Colors.black54,
//                 size: 30,
//               ),
//               label: "BottomNavBar"),
//           BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.message,
//                 color: Colors.black54,
//                 size: 30,
//               ),
//               label: "ChatBot"),
//           BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.calendar_today,
//                 color: Colors.black54,
//                 size: 30,
//               ),
//               label: "Schedule"),
//         ],
//       ),
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//     );
//   }
// }

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      HomePage(),
      ChatBotPage(),
      HomePage2(),
    ];

    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        onTap: onTabTapped,
        color: Color(0xff7266d8),
        animationCurve: Curves.easeIn,
        height: 60,
        items: [
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.chat_bubble,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.calendar_today,
            size: 30,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
