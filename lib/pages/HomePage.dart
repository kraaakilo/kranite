import 'package:flutter/material.dart';
import 'package:kranite/components/AppBarComponent.dart';
import 'package:kranite/components/CosmeticElement.dart';
import 'package:kranite/components/ScrollableCategory.dart';
import 'package:kranite/data/APIService.dart';
import 'package:kranite/models/Cosmetic.dart';
import 'package:kranite/providers/CosmeticProvider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  final double commSize = 45;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Cosmetic> _data = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void getData() async {
    List<Cosmetic> d = await APIService.api();
    setState(() {
      _data = d;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      key: scaffoldKey,
      appBar: AppBarComponent(context,scaffoldKey),
      body: Consumer<CosmeticProvider>(
        builder: (context, cosmetics, child) => Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: widget.commSize,
                      child: TextField(
                        onChanged: (value) =>
                            cosmetics.searchCosmetics(value),
                        decoration: InputDecoration(
                          filled: true,
                          prefixIcon: Icon(
                            Icons.search,
                          ),
                          fillColor: Colors.black38,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              width: 3,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              width: 3,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      height: widget.commSize,
                      width: widget.commSize,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: IconButton(
                        icon: Icon(Icons.hub),
                        onPressed: () {
                          Provider.of<CosmeticProvider>(context, listen: false)
                              .setCosmetics(_data);
                        },
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
              child: cosmetics.getCosmetics.length > 0
                  ? GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      children: List.generate(
                        cosmetics.getCosmetics.length,
                        (index) => CosmeticElement(
                          cosmetic: cosmetics.getCosmetics[index],
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        "Aucune donnée disponible.",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
