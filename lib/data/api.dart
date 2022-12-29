import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:kranite/models/Cosmetic.dart';

Future<List<Cosmetic>> api() async {
  List<Cosmetic> array = [];
  var url = Uri.parse("https://fortniteapi.io/v2/shop?lang=fr");
  var response = await http.get(url,
      headers: {"Authorization": "e2a0e0a6-7245ad49-ad3c1d0a-2eb46ee8"});

  dynamic data = jsonDecode(response.body.toString());
    debugPrint(data);



  for (int k = 0; k < data["shop"].length; k++) {
    dynamic shopItem = data["shop"][k];
    Cosmetic cosmetic = Cosmetic(
      shopItem["displayName"],
      shopItem["price"]["regularPrice"],
      shopItem["rarity"]["name"],
      shopItem["displayType"],
      shopItem["displayAssets"][0]["full_background"],
    );
    array.add(cosmetic);
  }

  return array;
}
