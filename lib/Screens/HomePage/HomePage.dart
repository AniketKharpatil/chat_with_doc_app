import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_app/Constants/Colors.dart';
import 'package:doc_app/Constants/Doubles.dart';
import 'package:doc_app/qrscan/qr_scan_page.dart';
import 'package:doc_app/services/chatbotService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../chatroom.dart';
import '../../chatroom2.dart';
import 'HomeCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Padding(
        padding: EdgeInsets.only(top: 16, bottom: 5),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: Color(0xff7266d8)),

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
                      Color(0xff7266d8),
                      Colors.white,
                    ]),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "My profile",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
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
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QRScanPage()),
                  );
                },
                child: ListTile(
                  title: Text(
                    "QR Scan",
                    style: TextStyle(fontSize: 17),
                  ),
                  trailing: Icon(
                    Icons.qr_code,
                    size: 28,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              backgroundColor: Colors.white70,
              title: Text(
                'Welcome to Doc chat App',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.person_rounded,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
            SliverPadding(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.032),
              sliver: SliverGrid.count(
                crossAxisSpacing: MediaQuery.of(context).size.height * 0.035,
                crossAxisCount: 2,
                children: [
                  GestureDetector(
                    onTap: () {
                      ChatBotService().chatBot();
                    },
                    child: HomeCard(
                      icon: Icons.chat_bubble,
                      title: "ChatBot",
                      subHeading: "Chat with virtual assistant",
                      isActive: true,
                      function: () {},
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => QRScanPage()),
                      );
                    },
                    child: HomeCard(
                        icon: Icons.qr_code,
                        title: "Scan QR ",
                        subHeading: "for the medicines",
                        isActive: false,
                        function: () {}
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(builder: (context) => QRScanPage()),
                        //   );
                        // },
                        ),
                  ),
                ],
              ),
            ),
            SliverPadding(
              padding: padding,
              sliver: SliverGrid.count(
                  crossAxisSpacing: MediaQuery.of(context).size.height * 0.025,
                  mainAxisSpacing: MediaQuery.of(context).size.height * 0.025,
                  crossAxisCount: 1,
                  children: [
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('doctors')
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData)
                          return Center(child: CircularProgressIndicator());
                        else {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: GestureDetector(
                                      onTap: () {
                                        showDetails(
                                            snapshot.data.docs[index]['name'],
                                            index);
                                      },
                                      child: Container(
                                        child: Card(
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                radius: 30,
                                                backgroundImage: AssetImage(
                                                    'assets/images/background.png'),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      snapshot.data.docs[index]
                                                          ['name'],
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        // color: kPrimaryColor,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    Text(
                                                      snapshot.data.docs[index]
                                                          ['email'],
                                                      style: TextStyle(
                                                        // color: kPrimaryColor,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                "Therapist",
                                                style: TextStyle(fontSize: 15
                                                    // color: kPrimaryColor,
                                                    ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )),
                                );
                              });
                        }
                      },
                    ),
                  ]),
            )

            // SliverPadding(
            //   padding: padding,
            //   sliver: SliverGrid.count(
            //     // crossAxisSpacing: MediaQuery.of(context).size.height * 0.025,
            //     // mainAxisSpacing: MediaQuery.of(context).size.height * 0.025,
            //     crossAxisCount: 1,
            // children: [Expanded(child: Userdata())],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Map<String, dynamic> userMap;
  
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addObserver(this);
  //   setStatus("Online");
  // }

  // void setStatus(String status) async {
  //   await _firestore.collection('doctors').doc(_auth.currentUser.uid).update({
  //     "status": status,
  //   });
  // }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.resumed) {
  //     // online
  //     setStatus("Online");
  //   } else {
  //     // offline
  //     setStatus("Offline");
  //   }
  // }

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  void getdata(index) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore.collection('doctors_data').get().then((value) {
      setState(() {
        userMap = value.docs[index].data();
      });
      print(userMap);
    });
  }

  showDetails(String name, int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(name),
        content: Card(
          child: Container(
              height: 300,
              width: 300,
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('doctors_data')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData)
                      return Center(child: CircularProgressIndicator());
                    else {
                      return Container(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  AssetImage('assets/images/background.png'),
                            ),
                            Text(
                              "Doctor Name: ${snapshot.data.docs[index]['name']}",
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "College Name: ${snapshot.data.docs[index]['college']}",
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "Years of Experience: ${snapshot.data.docs[index]['experience']}",
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "Specialization: ${snapshot.data.docs[index]['specialization']}",
                              style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  getdata(index);
                                  String roomId = chatRoomId(
                                      _auth.currentUser.displayName,
                                      snapshot.data.docs[index]['name']);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => ChatRoom2(
                                        chatRoomId: roomId,
                                        userMap: userMap,
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.chat, color: Colors.black))
                          ],
                        ),
                      );
                    }
                  })),
        ),
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
  }
}
