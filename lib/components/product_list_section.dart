import 'package:flutter/material.dart';

import '../models/product.dart';
import '../utils/size_config.dart';
import 'product_network_card.dart';
import 'section_tile.dart';

/// A plug-and-play section widget that:
/// - Shows [title] as a section header (no "See More" button)
/// - Displays [products] in a horizontal ListView of fixed-size [ProductNetworkCard]s
/// - Replaces the old fixed-height horizontal scrollers across Popular, Fashion, Sports, etc.
class ProductListSection extends StatelessWidget {
  const ProductListSection({
    super.key,
    required this.title,
    required this.products,
    this.isLoading = false,
    this.errorMessage,
  });

  final String title;
  final List<Product> products;
  final bool isLoading;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Section header ────────────────────────────────────────────
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(12)),

        // ── Content ───────────────────────────────────────────────────
        SizedBox(
          height: ProductNetworkCard.cardHeight,
          child: _buildContent(),
        ),
        SizedBox(height: getProportionateScreenHeight(20)),
      ],
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: 4,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, __) => _ShimmerCard(),
      );
    }

    if (errorMessage != null) {
      return Center(child: Text(errorMessage!));
    }

    if (products.isEmpty) {
      return const Center(child: Text('No products found.'));
    }

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: products.length,
      separatorBuilder: (_, __) => const SizedBox(width: 12),
      itemBuilder: (_, index) => ProductNetworkCard(product: products[index]),
    );
  }
}

/// Minimal shimmer placeholder that matches the card size.
class _ShimmerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ProductNetworkCard.cardWidth,
      height: ProductNetworkCard.cardHeight,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }
}
