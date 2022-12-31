import 'package:flutter/material.dart';
import 'package:kranite/components/AppBarComponent.dart';
import 'package:kranite/components/CosmeticElement.dart';
import 'package:kranite/components/ScrollableCategory.dart';
import 'package:kranite/data/APIService.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(context),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 55,
                    child: TextField(
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        prefixIcon: const Icon(Icons.search),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: const Icon(
                      Icons.hub,
                      color: Colors.white,
                    ),
                  ),
                ),
                // Icon(Icons.filter)
              ],
            ),
          ),
          const ScrollableCategoryListView(),
          const SizedBox(height: 20),
          Expanded(
              child: FutureBuilder(
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                return GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  children: List.generate(
                    snapshot.data!.length,
                    (index) => CosmeticElement(
                      cosmetic: snapshot.data!.elementAt(index),
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: Text(
                    "Chargement des ressources... Veuillez patienter.",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
            },
            future: APIService.api(),
          ))
        ],
      ),
    );
  }
}
