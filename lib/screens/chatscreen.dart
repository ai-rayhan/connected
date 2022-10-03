import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/constants/constants.dart';

// final _firestore = FirebaseFirestore.instance;


// class Chat_screen extends StatefulWidget {
//   const Chat_screen({Key? key}) : super(key: key);
//   static const String id = "Chatscreen";

//   @override
//   State<Chat_screen> createState() => _Chat_screenState();
// }

// class _Chat_screenState extends State<Chat_screen> {
//   final messagecontroller = TextEditingController();
//   final _auth = FirebaseAuth.instance;
// late User loggedinuser;
//   late String textmassage;
//   @override
//   void initState() {
//     super.initState();
//     getcurrentuser();
//   }

//   void getcurrentuser() async {
//     try {
//       final user = await _auth.currentUser;
//       if (user != null) {
//         loggedinuser = user;
//       }
//     } catch (e) {
//       print(e);
//     }
//   }



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: null,
//         actions: [
//           IconButton(
//             onPressed: () {
//               // messagesStream();
//               _auth.signOut();
//               Navigator.pushNamed(context, LoginScreen.id);
//             },
//             icon: Icon(Icons.close),
//           ),
//         ],
//         title: Text("⚡️Chat"),
//         backgroundColor: Colors.lightBlueAccent,
//       ),
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             MessageStream(),
//             Container(
//               decoration: kMessageContainerDecoration,
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: messagecontroller,
//                       decoration: kMessageTextFieldDecoration,
//                       onChanged: (value) {
//                         textmassage = value;
//                       },
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       messagecontroller.clear();
//                       _firestore.collection("messages").add({
//                         'text': textmassage,
//                         'sender': loggedinuser.email,
//                       });
//                     },
//                     child: Text(
//                       "Send",
//                       style: kSendButtonTextStyle,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MessageStream extends StatelessWidget {
//   const MessageStream({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _firestore.collection('messages').snapshots(),
//       builder: (BuildContext context, AsyncSnapshot snapsot) {
//         if (!snapsot.hasData) {
//           return Center(
//             child: CircularProgressIndicator(
//               backgroundColor: Colors.lightBlueAccent,
//             ),
//           );
//         }
//         final messages = snapsot.data.docs.reversed;
//         List<MessageBuble> MessageBubles = [];
//         for (var message in messages) {
//           final messageText = message.data()['text'];
//           final massegeSender = message.data()['sender'];
//           final currentUser = loggedinuser.email;
          
//           final messageWidget =
//               MessageBuble(message: messageText, sender: massegeSender,isMe: currentUser==massegeSender,);
//           MessageBubles.add(messageWidget);
//         }
//         return Expanded(
//           child: ListView(children: [
//             Column(
//               children: MessageBubles,
//             ),
//           ]),
//         );
//       },
//     );
//   }
// }

// class MessageBuble extends StatelessWidget {
//   final String message;
//   final String sender;
//   final bool isMe;

//   MessageBuble(
//       {required this.message, required this.sender, required this.isMe});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Column(
//         crossAxisAlignment:isMe? CrossAxisAlignment.end:CrossAxisAlignment.start,
//         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             sender,
//             style: TextStyle(
//               fontSize: 12.0,
//               color: isMe?Colors.white54:Colors.black54,
//             ),
//           ),
//           Material(
//             borderRadius: isMe
//                 ? BorderRadius.only(
//                     topLeft: Radius.circular(30),
//                     bottomLeft: Radius.circular(30),
//                     bottomRight: Radius.circular(30))
//                 : BorderRadius.only(
//                     topRight: Radius.circular(30),
//                     bottomLeft: Radius.circular(30),
//                     bottomRight: Radius.circular(30)),
//             elevation: 5.0,
//             color: isMe ? Colors.lightBlueAccent : Colors.white,
//             child: Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
//               child: Text(message),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



class Chat_screen extends StatefulWidget {
  static const String id = 'Chatscreen';
  const Chat_screen({Key? key}) : super(key: key);

  @override
  _Chat_screenState createState() => _Chat_screenState();
}

class _Chat_screenState extends State<Chat_screen> {
  final messageTextControler = TextEditingController();
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  late String message;
  final _firestore = FirebaseFirestore.instance;

  void logout() async {
    await _auth.signOut();
    Navigator.pushNamed(context, LoginScreen.id);
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              logout();
            },
          ),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('messages')
                  .orderBy('timestamp')
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.redAccent,
                    ),
                  );
                }
                final messages = snapshot.data.docs.reversed;
                List<MessageBubble> messageWidgets = [];
                for (var message in messages) {
                  final messageText = message.data()['text'];
                  final messageSender = message.data()['sender'];
                  final a = loggedInUser.email;

                  final messageWidget = MessageBubble(
                    sender: messageSender,
                    text: messageText,
                    isMe: (a == messageSender),
                  );
                  messageWidgets.add(messageWidget);
                }

                return Expanded(
                  child: ListView(
                    reverse: true,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    children: messageWidgets,
                  ),
                );
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextControler,
                      onChanged: (value) {
                        message = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextControler.clear();
                      _firestore.collection('messages').add(
                        {
                          'text': message,
                          'sender': loggedInUser.email,
                          'timestamp': DateTime.now()
                        },
                      );
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

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {required this.sender, required this.text, required this.isMe, Key? key})
      : super(key: key);
  final String text;
  final String sender;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 10,
            ),
          ),
          Material(
            elevation: 5,
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15,
                  color: isMe ? Colors.white : Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
