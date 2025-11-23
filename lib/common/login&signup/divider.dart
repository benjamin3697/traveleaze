import 'package:flutter/material.dart';
import 'package:traveleaze/utilities/constants/colors.dart';

class LoginDivider extends StatelessWidget {
  const LoginDivider({
    super.key,
    required this.dividerText, required TextStyle style
  });
final String dividerText;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Divider(
            color: AppColors.darkGrey,
            thickness: 0.5,
            indent: 60,
            endIndent: 5,
          ), 
        ),
        Text(dividerText, style: Theme.of(context).textTheme.labelMedium,),
    
        Flexible(
          child: Divider(
            color: AppColors.darkGrey,
            thickness: 0.5,
            indent: 5,
            endIndent: 60,
          ),
          
          
        )
    
      ],
    );
  }
}