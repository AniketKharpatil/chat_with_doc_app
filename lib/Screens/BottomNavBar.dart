import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:doc_app/Constants/DoctorList.dart';
import 'package:doc_app/Screens/DoctorPage/DoctorPage.dart';
import 'package:doc_app/Screens/HomePage/HomePage.dart';
import 'package:doc_app/Screens/HomePage/chatlistdoctor.dart';
import 'package:doc_app/Screens/chatbot.dart';
import 'package:doc_app/Screens/dochome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../onboarding screen/onboard_main.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;

  checkAuthentication() async {
    // didChangeAppLifecycleState(state);
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Onboarding()),
        );
      }
      // else {
      //    Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => BottomNavBar()),
      //   );
      // }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      HomePage(),
      ChatBotPage(),
      ChatListDoc(),
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
            Icons.chat_bubble_rounded,
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
