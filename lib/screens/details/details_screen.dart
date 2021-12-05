import 'package:flutter/material.dart';
import 'package:miaged/models/product.dart';
import 'package:miaged/screens/details/components/body.dart';
import 'package:miaged/widgets/app_bar.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(popable: true, title: "Description"),
      body: Body(product: product),
    );
  }

// AppBar buildAppBar(BuildContext context) {
//   return AppBar(
//     title: Text(
//       "Description",
//       style: GoogleFonts.comfortaa(fontSize: 20, fontWeight: FontWeight.w700),
//     ),
//     centerTitle: true,
//     backgroundColor: const Color(colorSchemeBarLight),
//     elevation: 0,
//     leading: IconButton(
//       icon: const Icon(Icons.arrow_back),
//       onPressed: () => Navigator.pop(context),
//     ),
//   );
// }
}
