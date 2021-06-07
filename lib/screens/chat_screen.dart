import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _fire = FirebaseFirestore.instance;
User loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  final _auth = FirebaseAuth.instance;
  //FirebaseUser is replace with the User
  String messageText;
  void getCurrentUser() {
    try {
      //currentuser() is replace with currentUser is no longer return the future
      final user = _auth.currentUser;
      if (user != null) {
        print(
            'this is me for a while it cluld be like we are doing the work for once');
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessages() async {
  //   //getDocument is deprecated use get instead of it use get method
  //   final getmessages = await _fire.collection('messages').get();
  //   for (var messag in getmessages.docs) {
  //     print(messag.data());
  //   }
  // }

  //stream which produce snapshot of data add to the stream which is collection of the future event
  //this snapshot is not use to call this will call automatically once data added to it
  // This method will listen the stream of messages
  // that come from firebase
  //  void messagesStream() async {
  //    await for (var snapshot in _fire.collection('messages').snapshots()) {
  //      for (var message in snapshot.docs) {
  //        print(message.data());
  //      }
  //    }
  //  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
                // getMessages();
              }),
        ],
        title: Text('⚡Chat'),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      style: TextStyle(color: Colors.black),
                      onChanged: (value) {
                        messageText = value;
                        print(
                            'this is message which was sed ti fire base $messageText');
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      print(
                          'Everything is ok here just of now%%**!((!(((!***!');
                      print(
                          'the value of loged in user who are just sign in at the movement8***@@^^ ${loggedInUser.email}');
                      messageTextController.clear();
                      _fire.collection('messages').add(
                          {'text': messageText, 'sender': loggedInUser.email});
                    },
                    child: Text(
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

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fire.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data.size);
          final messages = snapshot.data.docs.reversed;
          List<MessageBubble> messageBubbles = [];
          for (var messageComes in messages) {
            print('good to done this');
            final messageText = messageComes['text'];
            final messageSender = messageComes['sender'];
            print('$messageSender is sending messages $messageText');
            final messageBubble = MessageBubble(
                sender: messageSender,
                text: messageText,
                isMe: messageSender == loggedInUser.email);
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: messageBubbles,
            ),
          );
        }
        return null;
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text, this.isMe});
  final bool isMe;
  final String sender;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(sender),
          Material(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30)),
            elevation: 10,
            color: isMe ? Colors.green : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                '$text',
                style: TextStyle(
                    color: isMe ? Colors.white : Colors.black54,
                    fontSize: 15.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
