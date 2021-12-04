import 'package:flutter/material.dart';
import 'package:miaged/models/product.dart';
import 'package:miaged/models/product_family.dart';
import 'package:miaged/screens/details/details_screen.dart';
import 'package:miaged/screens/home/components/categories.dart';
import 'package:miaged/screens/home/components/product_card.dart';
import 'package:miaged/services/product_service.dart';
import 'package:miaged/widgets/dogo_progress_indicator.dart';

import '../../tools/constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    listProduct = _productService.getProducts();
  }

  void callBack(ProductFamily family) async {
    listProduct = _productService.getProductsByFamily(family);
    setState(() {});
  }

  final ProductService _productService = ProductService();
  late Future<List<Product>> listProduct;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Categories(
          callBackParent: callBack,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Container(
              child: FutureBuilder<List<Product>>(
                future: listProduct,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final products = snapshot.data;
                    return GridView.builder(
                        itemCount: products!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: defaultPadding,
                          crossAxisSpacing: defaultPadding,
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (context, index) {
                          return ProductCard(
                              product: products[index],
                              press: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailsScreen(
                                          product: products[index]))));
                        });
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  // By default, show a loading spinner.
                  return const Center(child: DogoProgressIndicator());
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
