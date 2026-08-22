import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../components/product_list_section.dart';
import '../../../../components/product_network_card.dart';
import '../../../../models/product.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/size_config.dart';
import '../../../loading/shimmer_box.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int _curr = 0;

  final List<dynamic> _iconData = [
    FontAwesomeIcons.basketShopping,
    FontAwesomeIcons.baseball,
    FontAwesomeIcons.shoePrints,
    FontAwesomeIcons.shirt,
  ];

  final List<String> _categoryText = [
    'Fashion',
    'Sports',
    'Footwear',
    'tshirts',
  ];

  // Cache futures so switching tabs doesn't refetch unnecessarily.
  final Map<String, Future<List<Product>>> _futureCache = {};

  Future<List<Product>> _fetchProducts(String category) {
    return _futureCache.putIfAbsent(category, () async {
      final snapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('categories', arrayContains: category)
          .get();
      return snapshot.docs
          .map((e) => Product.fromMap(e.data()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: getProportionateScreenWidth(15),
        bottom: getProportionateScreenWidth(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Section title ─────────────────────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
            ),
            child: const Text(
              'Categories',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenWidth(12)),

          // ── Category tab chips ────────────────────────────────────
          SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
              ),
              itemCount: _categoryText.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (_, index) => _CategoryChip(
                iconData: _iconData[index],
                label: _categoryText[index],
                isSelected: _curr == index,
                onTap: () => setState(() => _curr = index),
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenWidth(14)),

          // ── Horizontal product list (same style as other sections) ───────
          FutureBuilder<List<Product>>(
            future: _fetchProducts(_categoryText[_curr]),
            builder: (context, snapshot) {
              return ProductListSection(
                title: '',          // title already shown above
                products: snapshot.data ?? [],
                isLoading: snapshot.connectionState == ConnectionState.waiting,
                errorMessage: snapshot.hasError ? 'Could not load products' : null,
              );
            },
          ),
        ],
      ),
    );
  }
}

// ─── Category chip ────────────────────────────────────────────────────────────

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.iconData,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final dynamic iconData;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? kPrimaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: kPrimaryColor, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              iconData,
              size: 13,
              color: isSelected ? Colors.white : kPrimaryColor,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : kPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
