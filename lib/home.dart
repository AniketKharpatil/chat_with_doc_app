import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_app/chatroom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'onboarding screen/onboard_main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;

  Future signOut() async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Logout'),
        content: Text(
            'You have been successfully logged out, now you will be redirected to HomePage'),
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

  checkAuthentication() async {
    // didChangeAppLifecycleState(state);
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Onboarding()),
        );
      }
    });
  }

  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }



  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();


  Map<String, dynamic> userMap;
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
    this.getUser();
    WidgetsBinding.instance.addObserver(this);
    setStatus("Online");
  }

  void setStatus(String status) async {
    await _firestore.collection('users').doc(_auth.currentUser.uid).update({
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

  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });

    await _firestore
        .collection('users')
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
        backgroundColor: Color(0xffF5637F),
        elevation: 0,
      ),
      drawer: Padding(
        padding: EdgeInsets.only(top: 16, bottom: 5),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: Color(0xfff78298)),

          width: MediaQuery.of(context).size.width * 0.75,
          height: MediaQuery.of(context).size.height * 0.875,
          // height: 800,
          child: ListView(
            children: [
              Container(
                height: 150,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0xfff78298),
                      Color(0xfffbccd5),
                    ]),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                new AlertDialog(
                                  title: Text('${user.displayName}'),
                                  content: new Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('${user.email}'),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    new TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Close'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Text(
                              "My profile",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                },
                child: ListTile(
                  title: Text(
                    "Logout",
                    style: TextStyle(fontSize: 17),
                  ),
                  trailing: Icon(
                    Icons.logout,
                    size: 28,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xfff8f8f8),
      body:isLoading
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: CircularProgressIndicator(),
              ),
            )
          : Column(
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
                ElevatedButton(
                  onPressed: onSearch,
                  child: Text("Search"),
                ),
                SizedBox(
                  height: size.height / 30,
                ),
                userMap != null
                    ? ListTile(
                        onTap: () {
                          String roomId = chatRoomId(
                              _auth.currentUser.displayName, userMap['name']);

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ChatRoom(
                                chatRoomId: roomId,
                                userMap: userMap,
                              ),
                            ),
                          );
                        },
                        leading: Icon(Icons.account_box, color: Colors.black),
                        title: Text(
                          userMap['name'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(userMap['email']),
                        trailing: Icon(Icons.chat, color: Colors.black),
                      )
                    : Container(),
              ],
            ),
     
    );
  }
}