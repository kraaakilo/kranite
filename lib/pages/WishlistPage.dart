import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kranite/components/AppBarComponent.dart';
import 'package:kranite/components/DrawerComponent.dart';
import 'package:kranite/models/Cosmetic.dart';
import 'package:kranite/pages/CosmeticPage.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({Key? key}) : super(key: key);

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String? uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerComponent(context),
      key: scaffoldKey,
      appBar: AppBarComponent(context, scaffoldKey),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("wishlists")
            .where("user_id", isEqualTo: uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                dynamic doc = snapshot.data!.docs[index].data();
                Map<String, dynamic> map = Map<String, dynamic>.from(doc);
                Cosmetic cosmetic = Cosmetic.fromJson(map);
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CosmeticPage(
                          cosmetic: cosmetic,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedNetworkImage(
                          imageUrl: cosmetic.imageUrl,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                        ),
                      ),
                      title: Text(cosmetic.name),
                      subtitle: Row(
                        children: [
                          SizedBox(height: 30),
                          Image.asset(
                            "images/vbucks.webp",
                            width: 20,
                            height: 20,
                          ),
                          Text(
                            cosmetic.price.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
            print(snapshot.data!.docs.length);
          }
          return Text("");
        },
      ),
    );
  }
}
