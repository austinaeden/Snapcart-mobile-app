import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../components/product_list_section.dart';
import '../../../models/product.dart';
import '../components/body.dart';

class SimilarProducts extends StatefulWidget {
  const SimilarProducts({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final DetailFirebaseBody widget;

  @override
  State<SimilarProducts> createState() => _SimilarProductsState();
}

class _SimilarProductsState extends State<SimilarProducts> {
  late final Future<List<Product>> _future;

  @override
  void initState() {
    super.initState();
    _future = _fetchProducts();
  }

  Future<List<Product>> _fetchProducts() async {
    final categories = widget.widget.product.categories;
    if (categories.isEmpty) return [];

    final snapshot = await FirebaseFirestore.instance
        .collection('products')
        .where('categories', arrayContains: categories.first)
        .get();

    return snapshot.docs
        .map((e) => Product.fromMap(e.data()))
        .where((p) => p.title != widget.widget.product.title) // exclude current
        .take(8)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: _future,
      builder: (context, snapshot) {
        return ProductListSection(
          title: 'Similar Products',
          products: snapshot.data ?? [],
          isLoading: snapshot.connectionState == ConnectionState.waiting,
          errorMessage: snapshot.hasError ? 'Could not load products' : null,
        );
      },
    );
  }
}
