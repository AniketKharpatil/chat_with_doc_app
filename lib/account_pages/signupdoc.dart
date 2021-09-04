import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_app/account_pages/login1.dart';
import 'package:doc_app/Screens/dochome.dart';
import 'package:doc_app/queryform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:doc_app/services/animation.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpDoc extends StatefulWidget {
  @override
  _SignUpDocState createState() => _SignUpDocState();
}

class _SignUpDocState extends State<SignUpDoc> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String id;
  final db = FirebaseFirestore.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name, _email, _password, _role = 'doctor';

  // checkAuth() async {
  //   _auth.authStateChanges().listen((user) {
  //     if (user != null) {
  //       print(user);
  //       _auth.currentUser.updateDisplayName(_name);
  //        Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => HomePage2()),
  //       );
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // this.checkAuth();
  }

  signUpDoc() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      //createData();

      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        User user1 = FirebaseAuth.instance.currentUser;
        await db.collection('doctors').doc(user1.uid).set({
          'email': _email,
          'uid': user1.uid,
          'role': _role,
          "status": "Unavalible",
          'name': _name,
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FormFour()),
        );
        if (user != null) {
          await _auth.currentUser.updateDisplayName(_name);
          print(_name);
        }
      } catch (e) {
        showError(e.message);
        print(e);
      }
    }
  }

  showError(String errormessage) {
    showDialog(
      context: context,
      builder: (cntx) => AlertDialog(
        title: Text('ERROR'),
        content: Text(errormessage),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.of(cntx).pop();
              },
              child: Text('OK'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final SignUpDocButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff7266d8),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width * 0.55,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: signUpDoc,
        child: Text(
          "Sign Up",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
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
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              FadeAnimation(
                                1.5,
                                Text(
                                  "Sign Up",
                                  style: GoogleFonts.quicksand(
                                      color: Color.fromRGBO(49, 39, 79, 1),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              FadeAnimation(
                                1.7,
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Color.fromRGBO(196, 135, 198, .3),
                                          blurRadius: 20,
                                          offset: Offset(0, 10),
                                        )
                                      ]),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey[200]))),
                                        child: TextFormField(
                                            validator: (input) {
                                              if (input.isEmpty)
                                                return 'Enter Name';
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                                enabledBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Color(0xff7266d8),
                                                      width: 0.7),
                                                ),
                                                border:
                                                    const OutlineInputBorder(),
                                                hintText: "name",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[600])),
                                            onSaved: (input) => _name = input),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey[200]))),
                                        child: TextFormField(
                                            validator: (input) {
                                              if (input.isEmpty)
                                                return 'Enter Email';
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                                enabledBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Color(0xff7266d8),
                                                      width: 0.7),
                                                ),
                                                border:
                                                    const OutlineInputBorder(),
                                                hintText: "email",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[600])),
                                            onSaved: (input) => _email = input),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey[200]))),
                                        child: TextFormField(
                                            obscureText: true,
                                            validator: (input) {
                                              if (input.length < 6)
                                                return 'Provide Minimum 6 Character';
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                                enabledBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Color(0xff7266d8),
                                                      width: 0.7),
                                                ),
                                                border:
                                                    const OutlineInputBorder(),
                                                hintText: "password",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[600])),
                                            onSaved: (input) =>
                                                _password = input),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              FadeAnimation(1.9, SignUpDocButton),
                              FadeAnimation(
                                2,
                                Center(
                                  child: TextButton(
                                    child: Text("Account already exists?",
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                49, 39, 79, .6))),
                                    onPressed: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => Login()),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
