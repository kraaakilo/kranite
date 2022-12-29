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
          Image.network(
            widget.cosmetic.imageUrl,
            width: 160,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("images/vbucks.webp",width: 20,),
                  const Text(
                    "1500",
                    style: TextStyle(
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
