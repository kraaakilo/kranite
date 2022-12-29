import 'package:flutter/material.dart';
import 'package:kranite/models/Cosmetic.dart';

class CosmeticElement extends StatefulWidget {
  final Cosmetic cosmetic;

  const CosmeticElement({Key? key, required this.cosmetic}) : super(key: key);

  @override
  State<CosmeticElement> createState() => _CosmeticElementState();
}

class _CosmeticElementState extends State<CosmeticElement> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              widget.cosmetic.imageUrl,
              width: 160,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Text(
              widget.cosmetic.name,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "images/vbucks.webp",
                    width: 20,
                  ),
                  Text(
                    widget.cosmetic.price.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
