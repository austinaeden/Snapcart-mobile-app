import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '/models/models.dart' as models;

import '../../../providers/providers.dart';
import '../../../utils/size_config.dart';
import '../../loading/shimmer_box.dart';
import 'cart_card.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final uid = authProvider.user.uid;

    return Padding(
      padding: EdgeInsets.only(
        left: getProportionateScreenWidth(20),
        right: getProportionateScreenWidth(20),
        top: getProportionateScreenHeight(20),
        bottom: getProportionateScreenHeight(20),
      ),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('cartItems')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.separated(
              itemCount: 5,
              separatorBuilder: (_, __) =>
                  SizedBox(height: getProportionateScreenHeight(15)),
              itemBuilder: (_, __) => Center(
                child: SizedBox(
                  height: getProportionateScreenHeight(120),
                  width: MediaQuery.of(context).size.width * .9,
                  child: ShimmerBox(
                    child: SizedBox(
                      height: getProportionateScreenHeight(100),
                      width: getProportionateScreenWidth(100),
                    ),
                  ),
                ),
              ),
            );
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          final docs = snapshot.data?.docs ?? [];

          if (docs.isEmpty) {
            return const Center(child: Text('Your cart is empty'));
          }

          // Deduplicate by product id
          final seen = <String>{};
          final uniqueDocs = <QueryDocumentSnapshot>[];
          for (final doc in docs) {
            final id = (doc.data() as Map<String, dynamic>)['id']?.toString() ?? doc.id;
            if (seen.add(id)) {
              uniqueDocs.add(doc);
            }
          }

          return ListView.separated(
            itemCount: uniqueDocs.length,
            separatorBuilder: (_, __) =>
                SizedBox(height: getProportionateScreenHeight(15)),
            itemBuilder: (context, index) {
              final data = uniqueDocs[index].data() as Map<String, dynamic>;
              final cartItem = models.Product.fromMap(data);
              final quantity = (data['quantity'] as num?)?.toInt() ?? 1;
              final docRef = uniqueDocs[index].reference;

              return Dismissible(
                key: Key(docRef.id),
                direction: DismissDirection.endToStart,
                onDismissed: (_) async {
                  await docRef.delete();
                  cartProvider.cartItems.removeWhere((p) => p.id == cartItem.id);
                  cartProvider.getCartItems(uid);
                  Get.snackbar(
                    'Removed',
                    '${cartItem.title} removed from cart',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.redAccent,
                    colorText: Colors.white,
                  );
                },
                background: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFE6E6),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Row(
                    children: [
                      const Spacer(),
                      SvgPicture.asset("assets/icons/Trash.svg"),
                    ],
                  ),
                ),
                child: CartCard(
                  quantity: quantity,
                  cart: cartItem,
                  onDecrease: () async {
                    if (quantity > 1) {
                      await docRef.update({'quantity': quantity - 1});
                      cartProvider.getCartItems(uid);
                    }
                  },
                  onIncrease: () async {
                    await docRef.update({'quantity': quantity + 1});
                    cartProvider.getCartItems(uid);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
