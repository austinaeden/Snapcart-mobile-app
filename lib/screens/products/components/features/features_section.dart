import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../components/section_tile.dart';
import '../../../../utils/size_config.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const CategorySectionTitle(title: 'Feature\'s'),
        SizedBox(height: getProportionateScreenHeight(15)),
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          height: 325,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 160,
                    width: getProportionateScreenWidth(width * .45),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent.withOpacity(.3),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                      ),
                      image: const DecorationImage(
                        image: CachedNetworkImageProvider(
                            'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=400&h=320&fit=crop'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 160,
                    width: getProportionateScreenWidth(width * .45),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.indigoAccent.withOpacity(.3),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(15),
                      ),
                      image: const DecorationImage(
                        image: CachedNetworkImageProvider(
                            'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400&h=320&fit=crop'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 160,
                    width: getProportionateScreenWidth(width * .45),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade900.withOpacity(.3),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                      ),
                      image: const DecorationImage(
                        image: CachedNetworkImageProvider(
                            'https://images.unsplash.com/photo-1460353581641-37baddab0fa2?w=400&h=320&fit=crop'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 160,
                    width: getProportionateScreenWidth(width * .45),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent.withOpacity(.3),
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(15),
                      ),
                      image: const DecorationImage(
                        image: CachedNetworkImageProvider(
                            'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400&h=320&fit=crop'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
