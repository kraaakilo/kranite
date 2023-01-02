import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kranite/models/Cosmetic.dart';
import 'package:kranite/models/Wishlist.dart';
import '../components/TransparentAppBar.dart';

class CosmeticPage extends StatefulWidget {
  final Cosmetic cosmetic;

  const CosmeticPage({Key? key, required this.cosmetic}) : super(key: key);

  @override
  State<CosmeticPage> createState() => _CosmeticPageState();
}

class _CosmeticPageState extends State<CosmeticPage> {
  final User? _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(context),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              child: Hero(
                tag: widget.cosmetic.name,
                child: GestureDetector(
                  onVerticalDragUpdate: (DragUpdateDetails details) {
                    if (details.delta.dy > 12) {
                      Navigator.pop(context);
                    }
                  },
                  child: CachedNetworkImage(
                    imageUrl: widget.cosmetic.imageUrl,
                    placeholder: ((context, url) =>
                        const CircularProgressIndicator()),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                widget.cosmetic.name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Price : ",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 40),
                const SizedBox(width: 40),
                Image.asset(
                  "images/vbucks.webp",
                  width: 20,
                  height: 20,
                ),
                Text(
                  widget.cosmetic.price.toString(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                widget.cosmetic.description,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            const SizedBox(height: 40),
            _user != null
                ? Container(
                    width: 170,
                    child: Center(
                      child: StreamBuilder(
                          stream: Wishlist(cosmetic: widget.cosmetic).stream(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              QuerySnapshot docs = snapshot.data;
                              if(docs.docs.length > 0){
                                return Text("Already in wishlist");
                              }
                              print(docs.docs);
                            }
                            return ElevatedButton(
                              onPressed: () async {
                                Wishlist(cosmetic: widget.cosmetic).add();
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.favorite),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Add to wishlist"),
                                ],
                              ),
                            );
                          }),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
