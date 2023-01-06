import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kranite/components/AppBarComponent.dart';
import 'package:kranite/components/DrawerComponent.dart';
import 'package:kranite/models/Cosmetic.dart';
import 'package:kranite/pages/CosmeticPage.dart';
import 'package:provider/provider.dart';

import '../providers/UserProvider.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({Key? key}) : super(key: key);

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerComponent(context),
      key: scaffoldKey,
      appBar: AppBarComponent(context, scaffoldKey),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("wishlists")
            .where("user_id", isEqualTo: Provider.of<UserProvider>(context).getUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.length > 0) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                dynamic doc = snapshot.data!.docs[index];
                Map<String, dynamic> map =
                    Map<String, dynamic>.from(doc.data());
                Cosmetic cosmetic = Cosmetic.fromJson(map);
                return Dismissible(
                  direction: DismissDirection.endToStart,
                  dismissThresholds: {DismissDirection.endToStart: 0.6},
                  key: Key(cosmetic.id),
                  background: Container(
                    color: Colors.red,
                    child: Padding(
                      padding: EdgeInsets.only(right: 25),
                      child: Align(
                        child: Icon(Icons.delete),
                        alignment: Alignment.centerRight,
                      ),
                    ),
                  ),
                  onDismissed: (DismissDirection direction) {
                    FirebaseFirestore.instance
                        .collection("wishlists")
                        .doc(doc.id)
                        .delete();
                    snapshot.data!.docs
                        .removeWhere((element) => element.id == doc.id);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(duration: Duration(milliseconds: 500), content: Text("The item : ${cosmetic.name} has been removed successfully from wishlist")));
                  },
                  child: GestureDetector(
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
                  ),
                );
              },
            );
          }
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "You have not added any cosmetic here.",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          );
        },
      ),
    );
  }
}
