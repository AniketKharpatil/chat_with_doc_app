// import 'package:contra_care/views/homepage.dart';
import 'package:doc_app/account_pages/doc_login.dart';
import 'package:doc_app/account_pages/login1.dart';
import 'package:doc_app/account_pages/signupdoc.dart';
import 'package:doc_app/services/animation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginChoice extends StatefulWidget {
  const LoginChoice({Key key}) : super(key: key);

  @override
  _LoginChoiceState createState() => _LoginChoiceState();
}

class _LoginChoiceState extends State<LoginChoice> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff7266d8),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width * 0.55,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: openLoginPage,
        child: Text(
          "User Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

    final logindocButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff7266d8),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width * 0.55,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: openSignupDoc,
        child: Text(
          "Doctor Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 250,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      // top: -20,
                      left: 90,
                      height: 320,
                      width: width,
                      child: FadeAnimation(
                          1,
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/background-2.png'),
                                    fit: BoxFit.fill)),
                          )),
                    ),
                    Positioned(
                      height: 250,
                      left: -20,
                      width: width + 20,
                      child: FadeAnimation(
                          1.3,
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/background.png'),
                                    fit: BoxFit.fill)),
                          )),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          FadeAnimation(
                            1.5,
                            Text(
                              "Choose Login Type",
                              style: GoogleFonts.quicksand(
                                  color: Color.fromRGBO(49, 39, 79, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26),
                            ),
                          ),
                          SizedBox(
                            height: 45,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding:
                                    EdgeInsets.all(20).copyWith(bottom: 30),
                                child: Column(
                                  children: [
                                    FadeAnimation(
                                      1.6,
                                      Center(
                                        child: Text(
                                          "Login as a user",
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 14,
                                    ),
                                    FadeAnimation(1.7, loginButton),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    FadeAnimation(
                                      2,
                                      Center(
                                        child: Text(
                                          "Login As Doctor",
                                          style: TextStyle(
                                              color: Colors.grey[700],
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 14,
                                    ),
                                    FadeAnimation(1.7, logindocButton),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  openLoginPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  openSignupDoc() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DocLogin()));
  }
}
