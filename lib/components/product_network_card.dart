import 'package:flutter/material.dart';

import '../models/product.dart';
import '../utils/constants.dart';
import '../screens/details/detail_screen.dart';

/// A fixed-size product card (160 wide × 225 tall).
/// Uses only [product]; never expands beyond its fixed width on wide screens.
class ProductNetworkCard extends StatelessWidget {
  const ProductNetworkCard({super.key, required this.product});

  final Product product;

  static const double cardWidth = 160.0;
  static const double cardHeight = 225.0;
  static const double imageHeight = 130.0;

  @override
  Widget build(BuildContext context) {
    final imageUrl = product.images.isNotEmpty
        ? product.images.first
        : 'https://picsum.photos/300?image=1';
    final categoryLabel =
        product.categories.isNotEmpty ? product.categories.first : 'General';

    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => DetailsScreenFirebase(product: product),
        ),
      ),
      child: SizedBox(
        width: cardWidth,
        height: cardHeight,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
            border: Border.all(color: kPrimaryColor.withOpacity(0.13)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Product image ───────────────────────────────
                SizedBox(
                  height: imageHeight,
                  width: double.infinity,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey.shade200,
                      child: const Center(
                        child: Icon(Icons.image_not_supported_outlined,
                            color: Colors.grey, size: 32),
                      ),
                    ),
                    loadingBuilder: (_, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        color: Colors.grey.shade100,
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    },
                  ),
                ),

                // ── Details block ───────────────────────────────
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Category chip
                        Text(
                          categoryLabel,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.3,
                          ),
                        ),

                        // Title (up to 2 lines)
                        Text(
                          product.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            height: 1.3,
                          ),
                        ),

                        // Price + optional rating
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                '₹ ${product.price}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            if (product.rating > 0) ...[
                              const SizedBox(width: 4),
                              _RatingBadge(rating: product.rating),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RatingBadge extends StatelessWidget {
  const _RatingBadge({required this.rating});
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.amber.shade700,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, color: Colors.white, size: 9),
          const SizedBox(width: 2),
          Text(
            rating.toStringAsFixed(1),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
