import 'package:flutter/material.dart';
import 'package:miaged/models/product.dart';
import 'package:miaged/screens/home/components/product_card.dart';
import 'package:miaged/services/authentication.dart';
import 'package:miaged/services/product_service.dart';
import 'package:miaged/widgets/app_bar.dart';
import 'package:miaged/widgets/bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthenticationService _authenticationService = AuthenticationService();
  final ProductService _productService = ProductService();

  @override
  Widget build(BuildContext context) {
    Product p = Product("aaa", "bbb", "xl", 19.99, "falzar", "https://cdn.pixabay.com/photo/2020/04/20/08/08/beret-5066979_1280.png");
    final List<Product> list = _productService.readProducts();
    return Scaffold(
      appBar: MyAppBar(),
      body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: GridView.builder(
                itemCount: list.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) => ProductCard(
                  product: list[index],
                  press: null
                )),
          ),
        ),
      ],
    ),
      bottomNavigationBar: const BottomNavBar()
    );
  }
}

