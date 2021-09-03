import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_app/Screens/chatbot.dart';
import 'package:doc_app/chatroom.dart';
import 'package:doc_app/qrscan/qr_scan_page.dart';
import 'package:doc_app/queryform.dart';
import 'package:doc_app/services/userdatafordoc.dart';
import 'package:doc_app/services/docdataforuser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class ChatListDoc extends StatefulWidget {
  const ChatListDoc({Key key}) : super(key: key);

  @override
  _ChatListDocState createState() => _ChatListDocState();
}

class _ChatListDocState extends State<ChatListDoc> with WidgetsBindingObserver {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;

  Future signOut() async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Logout'),
        content: Text(
            'You have been successfully logged out, now you will be redirected to ChatListDoc'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('OK'),
          )
        ],
      ),
    );
    return await _auth.signOut();
  }

  // Future adharOtp() async {
  //   var url = Uri.parse('https://auth.uidai.gov.in');
  //   var response = await http.post(url, body: {});
  //   print(response.body);
  //   print(response.statusCode);
  // }

  // getUser() async {
  //   User firebaseUser = _auth.currentUser;
  //   await firebaseUser?.reload();
  //   firebaseUser = _auth.currentUser;

  //   if (firebaseUser != null) {
  //     setState(() {
  //       this.user = firebaseUser;
  //       this.isloggedin = true;
  //     });
  //   }
  // }

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Map<String, dynamic> userMap;
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    // this.checkAuthentication();
    // this.getUser();
    WidgetsBinding.instance.addObserver(this);
    setStatus("Online");
  }

  void setStatus(String status) async {
    await _firestore.collection('doctors').doc(_auth.currentUser.uid).update({
      "status": status,
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // online
      setStatus("Online");
    } else {
      // offline
      setStatus("Offline");
    }
  }

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  // void listofchats()async{

  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });

    await _firestore
        .collection('doctors')
        .where("email", isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
      print(userMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xff7266d8),
        elevation: 0,
      ),
      backgroundColor: Color(0xfff8f8f8),
      body: isLoading
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height / 20,
                  ),
                  
                  Container(
                    height: size.height / 14,
                    width: size.width,
                    alignment: Alignment.center,
                    child: Container(
                      height: size.height / 14,
                      width: size.width / 1.15,
                      child: TextField(
                        controller: _search,
                        decoration: InputDecoration(
                          hintText: "Search",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 50,
                  ),
                  DoctordataforUser(),
                ],
              ),
            ),
    );
  }
}
