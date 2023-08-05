import 'package:bloctesting/presentation/core/shimmer/custom_shimmer_skelton.dart';
import 'package:flutter/material.dart';

class CustomShimmerPostList extends StatelessWidget {
  const CustomShimmerPostList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      shrinkWrap: true,
      itemBuilder: (context, index) => const Skelton(height: 400),
      itemCount: 2,
    );
  }
}
