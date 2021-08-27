import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({Key key}) : super(key: key);

  @override
  _ChatBotPageState createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("hello"),
          Container(
              child: Center(
                child: ElevatedButton(
                    child: Text("chatnow"),
                    onPressed: () async {
                      try {
                        dynamic conversationObject = {
                          'appId':
                              '32d09a0ebd4837ab71c0c8929307298c7' // The [APP_ID](https://dashboard.kommunicate.io/settings/install) obtained from kommunicate dashboard.
                        };
                        dynamic result =
                            await KommunicateFlutterPlugin.buildConversation(
                                conversationObject);
                        print("Conversation builder success : " +
                            result.toString());
                      } on Exception catch (e) {
                        print("Conversation builder error occurred : " +
                            e.toString());
                      }
                    }),
              )),
        ],
      ),
    );
  }
}
