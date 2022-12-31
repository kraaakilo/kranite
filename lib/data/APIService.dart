import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kranite/models/Cosmetic.dart';

class APIService {
  static Future<List<Cosmetic>> api() async {
    List<Cosmetic> array = [];
    var url = Uri.parse("https://fortniteapi.io/v2/shop?lang=fr");
    var response = await http.get(url,
        headers: {"Authorization": "e2a0e0a6-7245ad49-ad3c1d0a-2eb46ee8"});

    dynamic data = jsonDecode(response.body.toString());

    for (int k = 0; k < data["shop"].length; k++) {
      dynamic shopItem = data["shop"][k];
      Cosmetic cosmetic = Cosmetic(
        name: shopItem["displayName"],
        price: shopItem["price"]["regularPrice"],
        rarity: shopItem["rarity"]["name"],
        type: shopItem["mainType"],
        imageUrl: shopItem["displayAssets"][0]["background"],
      );
      array.add(cosmetic);
    }

    return array;
  }
}
