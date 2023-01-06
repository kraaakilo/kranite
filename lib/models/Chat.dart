import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Chat {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late List users;
  late List messages;

  Future<dynamic> createChat() async {
    Future<QuerySnapshot> result = firebaseFirestore
        .collection("chats")
        .where("users", arrayContains: "elvis")
        .get();
    return result;
  }
}

class TestWidget extends StatelessWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          DocumentSnapshot doc = snapshot.data.docs.first;
          FirebaseFirestore.instance
              .collection("/chats/${doc.id}/messages")
              .get()
              .then((value) => print(value.docs.first.data()));
        }
        return Placeholder();
      },
      future: Chat().createChat(),
    );
  }
}
