class Cosmetic {
  late String name;
  late int price;
  late String rarity;
  late String type;
  late String description;
  late String imageUrl;

  Cosmetic({
    required this.name,
    required this.price,
    required this.rarity,
    required this.type,
    required this.description,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "price": price,
      "rarity": rarity,
      "type": type,
      "description": description,
      "imageUrl": imageUrl,
    };
  }

  Cosmetic.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        price = json["price"],
        rarity = json["rarity"],
        type = json["type"],
        description = json["description"],
        imageUrl = json["imageUrl"];
}
