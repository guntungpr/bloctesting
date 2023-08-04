import 'package:bloctesting/presentation/core/shimmer/custom_shimmer_skelton.dart';
import 'package:flutter/material.dart';

class CustomShimmerProfileList extends StatelessWidget {
  const CustomShimmerProfileList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(20, (index) {
        return const Padding(
          padding: EdgeInsets.all(20),
          child: Skelton(
            width: 200,
          ),
        );
      }),
    );
  }
}
