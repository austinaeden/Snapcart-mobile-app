import 'package:flutter/material.dart';

import '../../../../components/section_tile.dart';
import '../../../../utils/size_config.dart';
import '../../../showMore/show_more_screen.dart';

class Grocery extends StatelessWidget {
  const Grocery({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: 'Grocery',
          press: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const ShowMore(
                  keyword: 'Grocery',
                ),
              ),
            );
          },
        ),
        SizedBox(height: getProportionateScreenHeight(5)),
        const Text('This is an upcoming feature ...'),
        SizedBox(height: getProportionateScreenHeight(20)),
        Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
            image: DecorationImage(
              image: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQn7cBIcXOH_VWgK-BQAo-v_wu8vb752FX0zQ4xufrBbxVXCCDd7M6VHuw&s=10'),
              fit: BoxFit.cover,
            ),
          ),
          height: 230,
        ),
        SizedBox(height: getProportionateScreenHeight(8)),
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          height: 320,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: getProportionateScreenHeight(150),
                    width: getProportionateScreenWidth(width * .43),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent.withOpacity(.3),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                      image: const DecorationImage(
                        image: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlh_LhSr0mP_1nXVNVBvHgvLWa_tB2FftQupbxfVIiSNQd1N62WmZ8-Zw&s=10'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: getProportionateScreenHeight(150),
                    width: getProportionateScreenWidth(width * .43),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.indigoAccent.withOpacity(.3),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                      image: const DecorationImage(
                        image: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFoyo5ASeQqZ_Y3yDzgd3s2u3F6fI3DgxQl1z85IaIwCbMerGl-c_S6LI&s=10'),
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
                    height: getProportionateScreenHeight(150),
                    width: getProportionateScreenWidth(width * .43),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade900.withOpacity(.3),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(5),
                      ),
                      image: const DecorationImage(
                        image: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqOVTeeNExs4p4sA0FY6p4WvlwUoKSHdZndy6K6JEhkyFx9q0vz-QiiRA&s=10'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: getProportionateScreenHeight(150),
                    width: getProportionateScreenWidth(width * .43),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent.withOpacity(.3),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(15),
                      ),
                      image: const DecorationImage(
                        image: NetworkImage(
                            'https://cdn.shopify.com/s/files/1/2303/2711/files/Fashion_Photography_for_E-Commerce_How_to_Capture_Your_Model_and_Clothing_in_the_Best_Light_2.jpg?v=1684706557'),
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
