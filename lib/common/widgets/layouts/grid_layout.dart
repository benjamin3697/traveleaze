import 'package:flutter/material.dart';
import 'package:traveleaze/utilities/constants/sizes.dart';

class AppGridLayOut extends StatelessWidget {
  const AppGridLayOut({
    super.key, 
    required this.itemCount, 
    this.mainAxisExtent=299,
    required this.itemBuilder,
  });
  final int itemCount;
  final double? mainAxisExtent;
  final Widget? Function(BuildContext,int)itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
    mainAxisSpacing: AppSizes.gridViewSpacing,
    mainAxisExtent: mainAxisExtent,
    crossAxisSpacing: AppSizes.gridViewSpacing,
    ), 
    itemCount: itemCount,
    physics:const NeverScrollableScrollPhysics(),
    itemBuilder: itemBuilder
);
}
}
