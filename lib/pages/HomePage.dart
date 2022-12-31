import 'package:flutter/material.dart';
import 'package:kranite/components/AppBarComponent.dart';
import 'package:kranite/components/CosmeticElement.dart';
import 'package:kranite/components/ScrollableCategory.dart';
import 'package:kranite/data/APIService.dart';
import 'package:kranite/models/Cosmetic.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  final double commSize = 45;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Cosmetic> _data = [];
  List<Cosmetic> _untouched = [];

  void getData() async {
    List<Cosmetic> d = await APIService.api();
    setState(() {
      _data = _untouched = d;
    });
  }

  void search(String value) {
    setState(() {
      _data = _untouched
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    print(_data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(context),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: widget.commSize,
                    child: TextField(
                      onChanged: (value) => search(value),
                      decoration: InputDecoration(
                        filled: true,
                        prefixIcon: Icon(
                          Icons.search,
                        ),
                        fillColor: Colors.black38,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
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
                      onPressed: null,
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
            child: _data.length > 0
                ? GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    children: List.generate(_data.length,
                        (index) => CosmeticElement(cosmetic: _data[index])),
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
    );
  }
}
