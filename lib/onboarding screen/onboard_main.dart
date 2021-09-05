import 'package:doc_app/Screens/BottomNavBar.dart';
import 'package:doc_app/account_pages/login1.dart';
// import 'package:doc_app/account_pages/newpage.dart';
import 'package:doc_app/Screens/dochome.dart';
import 'package:doc_app/onboarding%20screen/newpage.dart';
import 'package:doc_app/onboarding%20screen/intro_screen.dart';
import 'package:doc_app/onboarding%20screen/intro_screens.dart';
import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: HomeController(),
    );
  }
}

class OnBoardPage extends StatefulWidget {
  @override
  OnBoardPageState createState() {
    return OnBoardPageState();
  }
}

class OnBoardPageState extends State<OnBoardPage> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {

    var screens = IntroScreens(
      onDone: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => LoginChoice(),
        ),
      ),
      onSkip: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => LoginChoice(),
        ),
      ),
      footerBgColor: TinyColor(Color(0xff7266d8)).color,
      activeDotColor: Colors.white,
      footerRadius: 18.0,
//      indicatorType: IndicatorType.CIRCLE,
      slides: [
        IntroScreen(
          title: 'Healthcare at home',
          imageAsset: 'assets/images/onboard3.png',
          description: 'Easy access to medical consultation even in remote areas',
          headerBgColor: Colors.white,
        ),
        IntroScreen(
          title: 'Connect with Doctors',
          headerBgColor: Colors.white,
          imageAsset: 'assets/images/onboard2.png',
          description: "One-to-one Video Chat for Doctor Patient Communication",
        ),
        IntroScreen(
          title: 'ChatBot',
          headerBgColor: Colors.white,
          imageAsset: 'assets/images/onboard1.png',
          description: " Ask any doubts to our Chatbot",
        ),
      ],
    );

    return Scaffold(
      body: screens,
    );
  }

  openLoginPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Login()));
    // alertbox();
  }
}

class NextPage extends StatefulWidget {
  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
    );
  }

}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final AuthService auth = Provider.of(context).auth;
    return StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            return OnBoardPage();
            // return Home();
          } else {
            return LoginChoice();
          }
          // return user ? Home() : SignUpView();
        }
        return CircularProgressIndicator();
      },
    );
  }
}