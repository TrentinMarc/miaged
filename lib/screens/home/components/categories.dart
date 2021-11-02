import 'package:flutter/material.dart';
import 'package:miaged/models/product_family.dart';
import 'package:miaged/services/product_family_service.dart';

import '../../../constant.dart';

// We need satefull widget for our categories

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final ProductFamilyService _productFamilyService = ProductFamilyService();
  late Future<List<ProductFamily>> listProductFamily;

  List<String> categories = ["Hand bag", "Jewellery", "Footwear", "Dresses"];

  // By default our first item will be selected
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    listProductFamily = _productFamilyService.getProductFamilies();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DefaultPadding),
      child: SizedBox(
        height: 25,
        child: FutureBuilder<List<ProductFamily>>(
          future: listProductFamily,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final productFamilies = snapshot.data;
              print(productFamilies);
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: productFamilies!.length,
                  itemBuilder: (context, index) =>
                      buildCategory(productFamilies[index], index));
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget buildCategory(ProductFamily pF, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              pF.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedIndex == index ? Colors.black : Colors.black54,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: DefaultPadding / 4),
              //top padding 5
              height: 2,
              width: 30,
              color: selectedIndex == index ? Colors.black : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
