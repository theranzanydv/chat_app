import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';

class ChatScreen extends StatefulWidget {
  static String routeName = 'chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  // FirebaseUser loggedInUser;
  late String messageText;
  List messageWidgets = [];

  @override
  void initState() {
    super.initState();
    // getCurrentUser();
    print(_auth.currentUser!.email);
  }

  //
  // void getCurrentUser() {
  //   final user = _auth.currentUser!;
  //   if (user != null) {
  //     // loggedInUser = user;
  //     print(user.email);
  //   }
  // }

  void getMessageStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var doc in snapshot.docs) {
        print(doc.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                // _auth.signOut();
                // Navigator.pop(context);

                getMessageStream();
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FutureBuilder(builder: (context, snapshot) {
              getMessageStream();
              return ListView.builder(
                  itemCount: messageWidgets.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: messageWidgets[index],
                    );
                  });
            }),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('messages').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(backgroundColor: Colors.greenAccent),
                  );
                }
                // List<QueryDocumentSnapshot<Object?>>? messageWidgets = snapshot.data?.docs ?? [];
                List<Text> messageWidgets = [];
                FirebaseFirestore.instance.collection('messages').get().then((QuerySnapshot querySnapshot) {
                  for (var doc in querySnapshot.docs) {
                    messageWidgets.add(doc['sender']);
                  }
                });
                return Column(
                  children: messageWidgets,
                );
                // for (var message in messages) {
                //   var messageData = message.data!;
                //   final messageText = messageData['text'];
                // }
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //Implement send functionality.
                      _firestore.collection('messages').add({'text': messageText, 'sender': _auth.currentUser!.email});
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
