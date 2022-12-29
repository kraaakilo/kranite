class Cosmetic {
  late String name;
  late int price;
  late String rarity;
  late String type;
  late String imageUrl;

  Cosmetic(
    this.name,
    this.price,
    this.rarity,
    this.type,
    this.imageUrl,
  );

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "price": price,
      "rarity": rarity,
      "type": type,
      "imageUrl": imageUrl,
    };
  }

  Cosmetic.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        price = json["price"],
        rarity = json["rarity"],
        type = json["type"],
        imageUrl = json["imageUrl"];
}
