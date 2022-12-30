import 'package:cached_network_image/cached_network_image.dart';
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
  void initState() {
    super.initState();
    print(widget.cosmetic.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: [
          Container(
            constraints: BoxConstraints(minHeight: 180),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                width: 180,
                fit: BoxFit.cover,
                imageUrl: widget.cosmetic.imageUrl,
                placeholder: (context, url) => Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  widget.cosmetic.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.normal
                  ),
                ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "images/vbucks.webp",
                    width: 20,
                    height: 20,
                  ),
                  Text(
                    widget.cosmetic.price.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
