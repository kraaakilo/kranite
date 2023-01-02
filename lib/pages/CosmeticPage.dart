import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kranite/models/Cosmetic.dart';

class CosmeticPage extends StatefulWidget {
  final Cosmetic cosmetic;

  const CosmeticPage({Key? key, required this.cosmetic}) : super(key: key);

  @override
  State<CosmeticPage> createState() => _CosmeticPageState();
}

class _CosmeticPageState extends State<CosmeticPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                "Prix : ",
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
        ],
      ),
    );
  }
}
