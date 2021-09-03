import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_app/chatroom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class DoctordataforUser extends StatefulWidget {
  const DoctordataforUser({Key key}) : super(key: key);
  @override
  _Doctordatafordoctorstate createState() => _Doctordatafordoctorstate();
}

class _Doctordatafordoctorstate extends State<DoctordataforUser> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    Map<String, dynamic> userMap;

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
      await _firestore.collection('doctors').get().then((value) {
        setState(() {
          userMap = value.docs[index].data();
        });
        print(userMap);
      });
    }

    return Container(
      child:
       StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('doctors').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          else {
            return Container(
              child: SingleChildScrollView(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      // return Container(
                      //     child: Card(
                      //       child: Column(
                      //         children: [
                      //           Text(
                      //               snapshot.data.docs[index]['name']),
                      //               Text(
                      //               snapshot.data.docs[index]['email']),
                      //         ],
                      //       ),
                      //     ));
                      return Container(
                        child: ListTile(
                          onTap: () {
                            getdata(index);
                            String roomId = chatRoomId(
                                _auth.currentUser.displayName,
                                snapshot.data.docs[index]['name']);
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
                            snapshot.data.docs[index]['name'],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(snapshot.data.docs[index]['email']),
                          trailing: Icon(Icons.chat, color: Colors.black),
                        ),
                      );
                    }),
              ),
            );
          }
        },
      ),
    );
  }
}
