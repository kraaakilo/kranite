import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kranite/models/Cosmetic.dart';

class Wishlist {
  Cosmetic cosmetic;
  late String user_id;

  Wishlist({required this.cosmetic}) {
    user_id = FirebaseAuth.instance.currentUser!.uid;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> c = cosmetic.toJson();
    c.addAll({"user_id": user_id});
    return c;
  }

  void add() async {
    await FirebaseFirestore.instance.collection("wishlists").add(this.toJson());
  }

  Stream stream() {
    return FirebaseFirestore.instance
        .collection("wishlists")
        .where("slug", isEqualTo: this.cosmetic.slug)
        .where("user_id", isEqualTo: this.user_id)
        .snapshots();
  }
}
