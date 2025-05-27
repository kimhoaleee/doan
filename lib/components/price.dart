// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

import '../constants.dart';

class Price extends StatelessWidget {
  const Price({Key? key, required this.amount}) : super(key: key);
  final String amount;
  //Nguyễn Lê Phi Hùng - 1050080052
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "\$",
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
        children: [
          TextSpan(text: amount, style: TextStyle(color: Colors.black)),
          TextSpan(
            text: "/kg",
            style: TextStyle(
              color: Colors.black26,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
