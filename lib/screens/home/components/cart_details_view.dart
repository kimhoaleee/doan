// ignore_for_file: use_super_parameters

import 'package:test_4/constants.dart';
import 'package:test_4/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'cart_detailsview_card.dart';

class CartDetailsView extends StatelessWidget {
  const CartDetailsView({Key? key, required this.controller}) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Cart", style: Theme.of(context).textTheme.titleLarge),
          ...List.generate(
            controller.cart.length,
            (index) => CartDetailsViewCard(productItem: controller.cart[index]),
          ),
          SizedBox(height: defaultPadding),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: () {}, child: Text("Next - \$30")),
          ),
        ],
      ),
    );
  }
}
