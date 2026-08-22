import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../components/product_list_section.dart';
import '../../../../models/product.dart';

class Sports extends StatefulWidget {
  const Sports({super.key});

  @override
  State<Sports> createState() => _SportsState();
}

class _SportsState extends State<Sports> {
  late final Future<List<Product>> _future;

  @override
  void initState() {
    super.initState();
    _future = _fetchProducts();
  }

  Future<List<Product>> _fetchProducts() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('products')
        .where('categories', arrayContains: 'Sports')
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
          title: 'Sports Collection',
          products: snapshot.data ?? [],
          isLoading: snapshot.connectionState == ConnectionState.waiting,
          errorMessage: snapshot.hasError ? 'Could not load products' : null,
        );
      },
    );
  }
}
