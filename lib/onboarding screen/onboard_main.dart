import 'package:doc_app/account_pages/login1.dart';
// import 'package:doc_app/account_pages/newpage.dart';
import 'package:doc_app/home.dart';
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
          builder: (context) => Login(),
        ),
      ),
      onSkip: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
      ),
      footerBgColor: TinyColor(Color(0xffF5637F)).color,
      activeDotColor: Colors.white,
      footerRadius: 18.0,
//      indicatorType: IndicatorType.CIRCLE,
      slides: [
        IntroScreen(
          title: 'Search Pills',
          imageAsset: 'assets/images/onboard3.png',
          description: 'Know more about options for different contraceptive pills',
          headerBgColor: Colors.white,
        ),
        IntroScreen(
          title: 'Pill tracker',
          headerBgColor: Colors.white,
          imageAsset: 'assets/images/onboard2.png',
          description: "Track you medication cycle for any number of days",
        ),
        IntroScreen(
          title: 'FAQs',
          headerBgColor: Colors.white,
          imageAsset: 'assets/images/onboard1.png',
          description: "Educate yourself as well as ask any doubts from professional",
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
            return HomePage2();
          }
          // return user ? Home() : SignUpView();
        }
        return CircularProgressIndicator();
      },
    );
  }
}