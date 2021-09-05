import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_app/Constants/Colors.dart';
import 'package:doc_app/Constants/Doubles.dart';
import 'package:doc_app/qrscan/qr_scan_page.dart';
import 'package:doc_app/services/chatbotService.dart';
import 'package:doc_app/services/fileModel.dart';
import 'package:doc_app/services/storageApi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../chatroom2.dart';
import 'HomeCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
   Future<List<FirebaseFile>> futureFiles;
    @override
  void initState() {
    super.initState();

    futureFiles = FirebaseApi.listAll('files/profile');
  }

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
              backgroundColor: Color(0xff7266d8),
              title: Text(
                'Welcome to Doc chat App',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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
                  crossAxisSpacing: MediaQuery.of(context).size.height * 0.02,
                  mainAxisSpacing: MediaQuery.of(context).size.height * 0.02,
                  crossAxisCount: 1,
                  children: [
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('doctors_data')
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData)
                          return Center(child: CircularProgressIndicator());
                        else {
                          return Container(
                            child: ListView.builder(
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
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Container(
                                            child: Card(
                                              shadowColor: Colors.indigo,
                                              elevation: 3,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25.0),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    2, 5, 2, 0),
                                                            child: CircleAvatar(
                                                              radius: 36,
                                                              backgroundImage:
                                                                  AssetImage(
                                                                      'assets/images/background.png'),
                                                            ),
                                                          ),
                                                        ),
                                                        Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                              .all(
                                                                          8.0)
                                                                      .copyWith(
                                                                          bottom:
                                                                              2,
                                                                          left:
                                                                              10),
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    snapshot.data
                                                                                .docs[
                                                                            index]
                                                                        ['name'],
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      // color: kPrimaryColor,
                                                                      fontSize:
                                                                          20,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                              .all(
                                                                          8.0)
                                                                      .copyWith(
                                                                          bottom:
                                                                              2,
                                                                          left:
                                                                              20),
                                                              child: Text(
                                                                "${snapshot.data.docs[index]['specialization']}",
                                                                style: TextStyle(
                                                                    fontSize: 15
                                                                    // color: kPrimaryColor,
                                                                    ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )),
                                  );
                                  //       Container(
                                  //         child: Card(
                                  //           child: Column(
                                  //             children: [
                                  //               CircleAvatar(
                                  //                 radius: 30,
                                  //                 backgroundImage: AssetImage(
                                  //                     'assets/images/background.png'),
                                  //               ),
                                  //               Padding(
                                  //                 padding:
                                  //                     const EdgeInsets.all(8.0),
                                  //                 child: Row(
                                  //                   children: [
                                  //                     Text(
                                  //                       snapshot.data.docs[index]
                                  //                           ['name'],
                                  //                       style: TextStyle(
                                  //                         fontWeight:
                                  //                             FontWeight.bold,
                                  //                         // color: kPrimaryColor,
                                  //                         fontSize: 20,
                                  //                       ),
                                  //                     ),
                                  //                   ],
                                  //                 ),
                                  //               ),
                                  //               Text(
                                  //                 "Therapist",
                                  //                 style: TextStyle(fontSize: 15
                                  //                     // color: kPrimaryColor,
                                  //                     ),
                                  //               )
                                  //             ],
                                  //           ),
                                  //         ),
                                  //       )),
                                  // );
                                }),
                          );
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
  //   await _firestore
  //       .collection('doctors_data')
  //       .doc(_auth.currentUser.uid)
  //       .update({
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
    ////////i've made chnages heree////////////////
    await _firestore.collection('doctors_data').get().then((value) {
      setState(() {
        userMap = value.docs[index].data();
      });
      setState(() {});
      print(userMap);
    });
  }

  showDetails(String name, int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Color(0xffd4d1f3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
        ),
        // title: Text(name),
        content: Container(
          height: 365,
          width: 350,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28.0),
            ),
            color: Color(0xff7266d8),
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('doctors_data')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());
                  else {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                AssetImage('assets/images/onboard1.png'),
                          ),
                        ),
                        Text(
                          "${snapshot.data.docs[index]['name']}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "${snapshot.data.docs[index]['specialization']}",
                          style: TextStyle(
                            fontSize: 18.0,
                            letterSpacing: 2.5,
                            color: Colors.blue.shade50,
                          ),
                        ),
                        Container(
                          width: 170.0,
                          margin: EdgeInsets.symmetric(vertical: 2.0),
                          child: Divider(
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2)
                                  .copyWith(left: 10, right: 10),
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      "Experience: ${snapshot.data.docs[index]['experience']} yrs",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        letterSpacing: 2.5,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      "${snapshot.data.docs[index]['college']}",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        letterSpacing: 2.5,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Status: ${snapshot.data.docs[index]['status']}",
                            style: TextStyle(
                                fontSize: 15.0,
                                letterSpacing: 2.5,
                                color: Colors.white),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
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
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0)
                                  .copyWith(bottom: 0),
                              child: Card( shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),color: Colors.indigo[300],
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Chat Now",
                                      style: TextStyle(
                                        fontSize: 16,
                                        letterSpacing: 2.5,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.chat,
                                      color: Colors.black,
                                      size: 35,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(1).copyWith(right: 30, top: 0),
            child: RaisedButton(
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: 15),
              ),
              shape: StadiumBorder(),
              color: Colors.indigo[400],
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ),
        ],
      ),
    );
  }

}

////////////////////////////////////////////////////////////////////////////////

// import 'dart:ui';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:doc_app/Constants/Colors.dart';
// import 'package:doc_app/Constants/Doubles.dart';
// import 'package:doc_app/qrscan/qr_scan_page.dart';
// import 'package:doc_app/services/chatbotService.dart';
// import 'package:doc_app/services/fileModel.dart';
// import 'package:doc_app/services/storageApi.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../../chatroom2.dart';
// import 'HomeCard.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   Future<List<FirebaseFile>> futureFiles;
//   @override
//   void initState() {
//     super.initState();

//     futureFiles = FirebaseApi.listAll('files/profile');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: Padding(
//         padding: EdgeInsets.only(top: 16, bottom: 5),
//         child: Container(
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                 bottomRight: Radius.circular(40),
//                 topRight: Radius.circular(40),
//               ),
//               color: Color(0xff7266d8)),

//           width: MediaQuery.of(context).size.width * 0.75,
//           height: MediaQuery.of(context).size.height * 0.875,
//           // height: 800,
//           child: ListView(
//             children: [
//               Container(
//                 height: 150,
//                 child: DrawerHeader(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(colors: [
//                       Color(0xff7266d8),
//                       Colors.white,
//                     ]),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Row(
//                     children: [
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "My profile",
//                             style: TextStyle(
//                                 fontSize: 25,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {
//                   FirebaseAuth.instance.signOut();
//                   Navigator.pop(context);
//                 },
//                 child: ListTile(
//                   title: Text(
//                     "Logout",
//                     style: TextStyle(fontSize: 17),
//                   ),
//                   trailing: Icon(
//                     Icons.logout,
//                     size: 28,
//                   ),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => QRScanPage()),
//                   );
//                 },
//                 child: ListTile(
//                   title: Text(
//                     "QR Scan",
//                     style: TextStyle(fontSize: 17),
//                   ),
//                   trailing: Icon(
//                     Icons.qr_code,
//                     size: 28,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: CustomScrollView(
//           slivers: [
//             SliverAppBar(
//               floating: true,
//               backgroundColor: Color(0xff7266d8),
//               title: Text(
//                 'Welcome to Doc chat App',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               actions: [
//                 IconButton(
//                   onPressed: () {},
//                   icon: Icon(
//                     Icons.person_rounded,
//                     color: kPrimaryColor,
//                   ),
//                 ),
//               ],
//             ),
//             SliverPadding(
//               padding:
//                   EdgeInsets.all(MediaQuery.of(context).size.height * 0.032),
//               sliver: SliverGrid.count(
//                 crossAxisSpacing: MediaQuery.of(context).size.height * 0.035,
//                 crossAxisCount: 2,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       ChatBotService().chatBot();
//                     },
//                     child: HomeCard(
//                       icon: Icons.chat_bubble,
//                       title: "ChatBot",
//                       subHeading: "Chat with virtual assistant",
//                       isActive: true,
//                       function: () {},
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => QRScanPage()),
//                       );
//                     },
//                     child: HomeCard(
//                         icon: Icons.qr_code,
//                         title: "Scan QR ",
//                         subHeading: "for the medicines",
//                         isActive: false,
//                         function: () {}
//                         //   Navigator.push(
//                         //     context,
//                         //     MaterialPageRoute(builder: (context) => QRScanPage()),
//                         //   );
//                         // },
//                         ),
//                   ),
//                 ],
//               ),
//             ),
//             SliverPadding(
//               padding: padding,
//               sliver: SliverGrid.count(
//                   crossAxisSpacing: MediaQuery.of(context).size.height * 0.02,
//                   mainAxisSpacing: MediaQuery.of(context).size.height * 0.02,
//                   crossAxisCount: 1,
//                   children: [
//                     StreamBuilder<QuerySnapshot>(
//                       stream: FirebaseFirestore.instance
//                           .collection('doctors_data')
//                           .snapshots(),
//                       builder:
//                           (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                         if (!snapshot.hasData)
//                           return Center(child: CircularProgressIndicator());
//                         else {
//                           return Row(
//                             children: [
//                               FutureBuilder<List<FirebaseFile>>(
//                                   future: futureFiles,
//                                   builder: (context, snap) {
//                                     if (snap.hasData) {
//                                       final files = snap.data;
//                                       return ListView.builder(
//                                         shrinkWrap: true,
//                                           itemCount: snap.data.length,
//                                           itemBuilder: (context, index) {
//                                             final file = files[index];

//                                             return Container(
//                                               child: Padding(
//                                                 padding:
//                                                     const EdgeInsets.fromLTRB(
//                                                         2, 5, 2, 0),
//                                                 child: CircleAvatar(
//                                                   radius: 36,
//                                                   backgroundImage:
//                                                       NetworkImage(file.url),
//                                                 ),
//                                               ),
//                                             );
//                                           });
//                                     } else
//                                       return Container(
//                                         child: CircularProgressIndicator(),
//                                       );
//                                   }),
//                               Container(
//                                 child: ListView.builder(
//                                     shrinkWrap: true,
//                                     itemCount: snapshot.data.docs.length,
//                                     itemBuilder: (context, index) {
//                                       return Container(
//                                         child: GestureDetector(
//                                             onTap: () {
//                                               showDetails(
//                                                   snapshot.data.docs[index]
//                                                       ['name'],
//                                                   index);
//                                             },
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(5.0),
//                                               child: Container(
//                                                 child: Card(
//                                                   shadowColor: Colors.indigo,
//                                                   elevation: 3,
//                                                   shape: RoundedRectangleBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             25.0),
//                                                   ),
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             8.0),
//                                                     child: Column(
//                                                       children: [
//                                                         Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                       .all(8.0)
//                                                                   .copyWith(
//                                                                       bottom: 2,
//                                                                       left: 10),
//                                                           child: Row(
//                                                             children: [
//                                                               Text(
//                                                                 snapshot.data
//                                                                             .docs[
//                                                                         index]
//                                                                     ['name'],
//                                                                 style:
//                                                                     TextStyle(
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold,
//                                                                   // color: kPrimaryColor,
//                                                                   fontSize: 20,
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                       .all(8.0)
//                                                                   .copyWith(
//                                                                       bottom: 2,
//                                                                       left: 20),
//                                                           child: Text(
//                                                             "${snapshot.data.docs[index]['specialization']}",
//                                                             style: TextStyle(
//                                                                 fontSize: 15
//                                                                 // color: kPrimaryColor,
//                                                                 ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             )),
//                                       );
//                                       //       Container(
//                                       //         child: Card(
//                                       //           child: Column(
//                                       //             children: [
//                                       //               CircleAvatar(
//                                       //                 radius: 30,
//                                       //                 backgroundImage: AssetImage(
//                                       //                     'assets/images/background.png'),
//                                       //               ),
//                                       //               Padding(
//                                       //                 padding:
//                                       //                     const EdgeInsets.all(8.0),
//                                       //                 child: Row(
//                                       //                   children: [
//                                       //                     Text(
//                                       //                       snapshot.data.docs[index]
//                                       //                           ['name'],
//                                       //                       style: TextStyle(
//                                       //                         fontWeight:
//                                       //                             FontWeight.bold,
//                                       //                         // color: kPrimaryColor,
//                                       //                         fontSize: 20,
//                                       //                       ),
//                                       //                     ),
//                                       //                   ],
//                                       //                 ),
//                                       //               ),
//                                       //               Text(
//                                       //                 "Therapist",
//                                       //                 style: TextStyle(fontSize: 15
//                                       //                     // color: kPrimaryColor,
//                                       //                     ),
//                                       //               )
//                                       //             ],
//                                       //           ),
//                                       //         ),
//                                       //       )),
//                                       // );
//                                     }),
//                               ),
//                             ],
//                           );
//                         }
//                       },
//                     ),
//                   ]),
//             )

//             // SliverPadding(
//             //   padding: padding,
//             //   sliver: SliverGrid.count(
//             //     // crossAxisSpacing: MediaQuery.of(context).size.height * 0.025,
//             //     // mainAxisSpacing: MediaQuery.of(context).size.height * 0.025,
//             //     crossAxisCount: 1,
//             // children: [Expanded(child: Userdata())],
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }

//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Map<String, dynamic> userMap;

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   WidgetsBinding.instance.addObserver(this);
//   //   setStatus("Online");
//   // }

//   // void setStatus(String status) async {
//   //   await _firestore
//   //       .collection('doctors_data')
//   //       .doc(_auth.currentUser.uid)
//   //       .update({
//   //     "status": status,
//   //   });
//   // }

//   // @override
//   // void didChangeAppLifecycleState(AppLifecycleState state) {
//   //   if (state == AppLifecycleState.resumed) {
//   //     // online
//   //     setStatus("Online");
//   //   } else {
//   //     // offline
//   //     setStatus("Offline");
//   //   }
//   // }

//   String chatRoomId(String user1, String user2) {
//     if (user1[0].toLowerCase().codeUnits[0] >
//         user2.toLowerCase().codeUnits[0]) {
//       return "$user1$user2";
//     } else {
//       return "$user2$user1";
//     }
//   }

//   void getdata(index) async {
//     FirebaseFirestore _firestore = FirebaseFirestore.instance;
//     await _firestore.collection('doctors_data').get().then((value) {
//       setState(() {
//         userMap = value.docs[index].data();
//       });
//       setState(() {});
//       print(userMap);
//     });
//   }

//   showDetails(String name, int index) {
//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         backgroundColor: Color(0xffd4d1f3),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(28.0),
//         ),
//         // title: Text(name),
//         content: Container(
//           height: 360,
//           width: 350,
//           child: Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(28.0),
//             ),
//             color: Color(0xff7266d8),
//             child: StreamBuilder<QuerySnapshot>(
//                 stream: FirebaseFirestore.instance
//                     .collection('doctors_data')
//                     .snapshots(),
//                 builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (!snapshot.hasData)
//                     return Center(child: CircularProgressIndicator());
//                   else {
//                     return Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: CircleAvatar(
//                             radius: 40,
//                             backgroundImage:
//                                 AssetImage('assets/images/onboard1.png'),
//                           ),
//                         ),
//                         Text(
//                           "${snapshot.data.docs[index]['name']}",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 22.0,
//                             color: Colors.white,
//                           ),
//                         ),
//                         Text(
//                           "${snapshot.data.docs[index]['specialization']}",
//                           style: TextStyle(
//                             fontSize: 18.0,
//                             letterSpacing: 2.5,
//                             color: Colors.blue.shade50,
//                           ),
//                         ),
//                         Container(
//                           width: 170.0,
//                           margin: EdgeInsets.symmetric(vertical: 2.0),
//                           child: Divider(
//                             color: Colors.white,
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Card(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(2)
//                                   .copyWith(left: 10, right: 10),
//                               child: Column(
//                                 children: [
//                                   Container(
//                                     alignment: Alignment.bottomLeft,
//                                     child: Text(
//                                       "Experience: ${snapshot.data.docs[index]['experience']} yrs",
//                                       style: TextStyle(
//                                         fontSize: 15.0,
//                                         letterSpacing: 2.5,
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   Container(
//                                     alignment: Alignment.bottomLeft,
//                                     child: Text(
//                                       "${snapshot.data.docs[index]['college']}",
//                                       style: TextStyle(
//                                         fontSize: 15.0,
//                                         letterSpacing: 2.5,
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   // ListTile(
//                                   //   title: Text(
//                                   //     "Experience: ${snapshot.data.docs[index]['experience']} yrs",
//                                   //     style: TextStyle(
//                                   //       fontSize: 15.0,
//                                   //       letterSpacing: 2.5,
//                                   //       fontWeight: FontWeight.bold,
//                                   //     ),
//                                   //   ),
//                                   //   subtitle: Text(
//                                   //     "${snapshot.data.docs[index]['college']}",
//                                   //     style: TextStyle(
//                                   //       fontSize: 15.0,
//                                   //       letterSpacing: 2.5,
//                                   //       fontWeight: FontWeight.bold,
//                                   //     ),
//                                   //   ),
//                                   // ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         Container(
//                           child: Text(
//                             "Status: ${snapshot.data.docs[index]['status']}",
//                             style: TextStyle(
//                                 fontSize: 15.0,
//                                 letterSpacing: 2.5,
//                                 color: Colors.white),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () async {
//                             getdata(index);
//                             String roomId = chatRoomId(
//                                 _auth.currentUser.displayName,
//                                 snapshot.data.docs[index]['name']);
//                             Navigator.of(context).push(
//                               MaterialPageRoute(
//                                 builder: (_) => ChatRoom2(
//                                   chatRoomId: roomId,
//                                   userMap: userMap,
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Center(
//                             child: Padding(
//                               padding: const EdgeInsets.all(20.0)
//                                   .copyWith(bottom: 0),
//                               child: Card(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10.0),
//                                 ),
//                                 color: Colors.indigo[300],
//                                 child: Row(
//                                   children: [
//                                     SizedBox(
//                                       width: 10,
//                                     ),
//                                     Text(
//                                       "Chat Now",
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         letterSpacing: 2.5,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 10,
//                                     ),
//                                     Icon(
//                                       Icons.chat,
//                                       color: Colors.black,
//                                       size: 35,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   }
//                 }),
//           ),
//         ),
//         actions: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(1).copyWith(right: 30, top: 0),
//             child: RaisedButton(
//               child: Text(
//                 'Cancel',
//                 style: TextStyle(fontSize: 15),
//               ),
//               shape: StadiumBorder(),
//               color: Colors.indigo[400],
//               textColor: Colors.white,
//               onPressed: () {
//                 Navigator.of(ctx).pop();
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
