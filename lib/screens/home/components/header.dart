// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

import '../../../constants.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: headerHeight,
      color: Colors.white,
      padding: const EdgeInsets.all(defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Good Morning!",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                "Lê Thị Kim Hoa ",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(color: Colors.black54),
              ),
            ],
          ),
          CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage("assets/images/profile.png"),
          ),
        ],
      ),
    );
  }
}
