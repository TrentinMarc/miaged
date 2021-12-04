import 'package:flutter/material.dart';
import 'package:miaged/models/product_family.dart';
import 'package:miaged/services/product_family_service.dart';
import 'package:miaged/widgets/dogo_progress_indicator.dart';

import '../../../tools/constant.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key, required this.callBackParent}) : super(key: key);
  final Function callBackParent;

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final ProductFamilyService _productFamilyService = ProductFamilyService();
  late Future<List<ProductFamily>> listProductFamily;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    listProductFamily = _productFamilyService.getProductFamilies();
    listProductFamily.then((list) {
      ProductFamily firstItem = list.singleWhere(
          (element) => element.title == ProductFamily.ALL_FAMILY_VALUE);
      var index = list.indexWhere(
          (element) => element.title == ProductFamily.ALL_FAMILY_VALUE);
      list.removeAt(index);
      list.insert(0, firstItem);
    });
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding),
      child: SizedBox(
        height: 25,
        child: FutureBuilder<List<ProductFamily>>(
          future: listProductFamily,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final productFamilies = snapshot.data;
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: productFamilies!.length,
                  itemBuilder: (context, index) =>
                      buildCategory(productFamilies[index], index));
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const Center(child: DogoProgressIndicator());
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
          widget.callBackParent(pF);
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              pF.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedIndex == index ? Colors.white : Colors.white60,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: defaultPadding / 4),
              //top padding 5
              height: 2,
              width: 30,
              color: selectedIndex == index ? Colors.white : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
