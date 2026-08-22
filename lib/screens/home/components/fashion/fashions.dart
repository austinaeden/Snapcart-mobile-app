import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../components/product_list_section.dart';
import '../../../../models/product.dart';

class Fashionable extends StatefulWidget {
  const Fashionable({super.key});

  @override
  State<Fashionable> createState() => _FashionableState();
}

class _FashionableState extends State<Fashionable> {
  late final Future<List<Product>> _future;

  @override
  void initState() {
    super.initState();
    _future = _fetchProducts();
  }

  Future<List<Product>> _fetchProducts() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('products')
        .where('categories', arrayContains: 'Fashion')
        .get();
    return snapshot.docs
        .map((e) => Product.fromMap(e.data()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: _future,
      builder: (context, snapshot) {
        return ProductListSection(
          title: 'Fashion Collection',
          products: snapshot.data ?? [],
          isLoading: snapshot.connectionState == ConnectionState.waiting,
          errorMessage: snapshot.hasError ? 'Could not load products' : null,
        );
      },
    );
  }
}
