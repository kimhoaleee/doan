// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:test_4/components/fav_btn.dart';
import 'package:test_4/components/price.dart';
import 'package:test_4/constants.dart';
import 'package:test_4/models/Product.dart';
import 'package:flutter/material.dart';

import 'components/cart_counter.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    Key? key,
    required this.product,
    required this.onProductAdd,
  }) : super(key: key);

  final Product product;
  final VoidCallback onProductAdd;

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String _cartTag = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                widget.onProductAdd();
                setState(() {
                  _cartTag = '_cartTag';
                });
                Navigator.pop(context);
              },
              child: const Text("Add to Cart"),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1.37,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      color: const Color(0xFFF8F8F8),
                      child: Hero(
                        tag: widget.product.title! + _cartTag,
                        child: Image.asset(widget.product.image!),
                      ),
                    ),
                    const Positioned(bottom: -20, child: CartCounter()),
                  ],
                ),
              ),
              const SizedBox(height: defaultPadding * 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.product.title!,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Price(amount: "20.00"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Text(
                  "Cabbage (comprising several cultivars of Brassica oleracea) is a leafy green, red (purple), or white (pale green) biennial plant grown as an annual vegetable crop for its dense-leaved heads. It is descended from the wild cabbage (B. oleracea var. oleracea), and belongs to the cole crops or brassicas, meaning it is closely related to broccoli and cauliflower (var. botrytis); Brussels sprouts (var. gemmifera); and Savoy cabbage (var. sabauda).",
                  style: const TextStyle(color: Color(0xFFBDBDBD), height: 1.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: const BackButton(color: Colors.black),
      backgroundColor: const Color(0xFFF8F8F8),
      elevation: 0,
      centerTitle: true,
      title: const Text("Fruits", style: TextStyle(color: Colors.black)),
      actions: const [FavBtn(radius: 20), SizedBox(width: defaultPadding)],
    );
  }
}
