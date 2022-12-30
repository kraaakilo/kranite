import 'package:flutter/material.dart';
import 'package:kranite/components/CosmeticElement.dart';
import 'package:kranite/components/ScrollableCategory.dart';
import 'package:kranite/data/APIService.dart';

// Cached Images Branch

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: "Fortnite"
    ),
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      drawer: const Drawer(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 85,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0),
          child: Image.asset(
            "images/fortnite.png",
            width: 200,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => scaffoldKey.currentState!.openDrawer(),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Row(
              children: const [
                Icon(Icons.favorite),
              ],
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                        fillColor: const Color(0xFFE8E6FE),
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
                        color: Colors.purple,
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
                    "None",
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
