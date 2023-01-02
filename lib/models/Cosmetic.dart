import 'package:slugify/slugify.dart';
import 'package:uuid/uuid.dart';

class Cosmetic {
  String id = Uuid().v1();
  late String name;
  late int price;
  late String rarity;
  late String type;
  late String description;
  late String imageUrl;
  String? slug;

  Cosmetic({
    required this.name,
    required this.price,
    required this.rarity,
    required this.type,
    required this.description,
    required this.imageUrl,
  }) {
    slug = slugify(name);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "price": price,
      "rarity": rarity,
      "type": type,
      "description": description,
      "imageUrl": imageUrl,
      "slug": slug,
    };
  }

  Cosmetic.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        price = json["price"],
        rarity = json["rarity"],
        type = json["type"],
        description = json["description"],
        imageUrl = json["imageUrl"],
        slug = json["slug"];
}
