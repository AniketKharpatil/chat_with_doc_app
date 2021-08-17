// import 'package:doc_app/account_pages/login1.dart';
// import 'package:doc_app/services/animation.dart';
// import 'package:doc_app/home.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class LoginChoice extends StatefulWidget {
//   const LoginChoice({Key key}) : super(key: key);
//
//   @override
//   _LoginChoiceState createState() => _LoginChoiceState();
// }
//
// class _LoginChoiceState extends State<LoginChoice> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   @override
//   Widget build(BuildContext context) {
//
//     final width = MediaQuery.of(context).size.width;
//     final loginButton = Material(
//       elevation: 5.0,
//       borderRadius: BorderRadius.circular(30.0),
//       color: Color(0xffEB6383),
//       child: MaterialButton(
//         minWidth: MediaQuery.of(context).size.width * 0.55,
//         padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//         onPressed: openLoginPage,
//         child: Text(
//           "Login",
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Container(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Container(
//                 height: 300,
//                 child: Stack(
//                   children: <Widget>[
//                     Positioned(
//                       top: -40,
//                       height: 350,
//                       width: width,
//                       child: FadeAnimation(
//                           1,
//                           Container(
//                             decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                     image: AssetImage(
//                                         'assets/images/background-2.png'),
//                                     fit: BoxFit.fill)),
//                           )),
//                     ),
//                     Positioned(
//                       height: 350,
//                       width: width + 20,
//                       child: FadeAnimation(
//                           1.3,
//                           Container(
//                             decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                     image: AssetImage(
//                                         'assets/images/background.png'),
//                                     fit: BoxFit.fill)),
//                           )),
//                     )
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 40),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       child: Column(
//                         children: <Widget>[
//                           FadeAnimation(
//                             1.5,
//                             Text(
//                               "Choose Login Type",
//                               style: GoogleFonts.quicksand(
//                                   color: Color.fromRGBO(49, 39, 79, 1),
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 26),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 45,
//                           ),
//                           Container(
//                               decoration: BoxDecoration(
//                                   color: Colors.grey[100],
//                                   borderRadius: BorderRadius.circular(20)),
//                               child: Padding(padding: EdgeInsets.all(20).copyWith(bottom: 30),
//                                 child: Column(
//                                   children: [
//                                     FadeAnimation(
//                                       1.6,
//                                       Center(
//                                         child: Text(
//                                           "Login to your account",
//                                           style: TextStyle(
//                                             color: Color(0xffEB6383)
//                                                 .withOpacity(0.8),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 14,
//                                     ),
//                                     FadeAnimation(1.7, loginButton),
//                                     SizedBox(
//                                       height: 32,
//                                     ),
//                                     FadeAnimation(
//                                       2,
//                                       Center(
//                                         child: Text(
//                                           "Don't want to create an account",
//                                           style:
//                                               TextStyle(color: Colors.grey[700]),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 14,
//                                     ),
//                                   ],
//                                 ),
//                               )),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   openLoginPage() {
//     Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
//     // alertbox();
//   }
//
//   Future alertbox() async {
//     await showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: Text('Alert'),
//         content: Text(
//             'Oral Contraceptive pills are intended to be used to prevent pregnancy. Pills DO NOT protect against transmission of HIV (AIDS) or any other Sexually Transmitted Disease.'),
//         actions: <Widget>[
//           FlatButton(
//             onPressed: () {
//               Navigator.of(ctx).pop();
//             },
//             child: Text('OK'),
//           )
//         ],
//       ),
//     );
//   }
// }
