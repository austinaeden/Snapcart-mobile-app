import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/product.dart';
import '../../utils/constants.dart';
import '../../utils/size_config.dart';
import '../home/components/categories/categories.dart';
import '../loading/shimmer_box.dart';

class CategoryProductsView extends StatelessWidget {
  final String categoryName;

  const CategoryProductsView({
    Key? key,
    required this.categoryName,
  }) : super(key: key);

  Future<List<Product>> fetchProductsFromFirestore() async {
    final List<Product> products = [];
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('products')
        .where('categories', arrayContains: categoryName)
        .get();
        
    for (var element in snapshot.docs) {
      products.add(Product.fromMap(element.data() as Map<String, dynamic>));
    }
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          categoryName,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<List<Product>>(
        future: fetchProductsFromFirestore(),
        builder: (context, snapshot) {
          final List<Product> products = snapshot.data ?? [];

          if (snapshot.connectionState == ConnectionState.waiting) {
            return GridView.builder(
              padding: EdgeInsets.all(getProportionateScreenWidth(20)),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 8,
              itemBuilder: (context, index) {
                return ShimmerBox(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                );
              },
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }

          if (products.isEmpty) {
            return const Center(
              child: Text('No products found in this category.'),
            );
          }

          return GridView.builder(
            padding: EdgeInsets.all(getProportionateScreenWidth(20)),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 0.75,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return CategoryGridItem(
                product: products[index],
                image: products[index].images.isNotEmpty ? products[index].images.first : '',
                category: products[index].categories.isNotEmpty ? products[index].categories.first : '',
              );
            },
          );
        },
      ),
    );
  }
}
