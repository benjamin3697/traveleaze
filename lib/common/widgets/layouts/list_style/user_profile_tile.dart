import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:traveleaze/utilities/constants/image_strings.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({
    super.key,
     required this.onPressed,
  });
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipOval(
        child: SizedBox(
          width: 50,
          height: 50,
          child: Image.asset(
            AppImages.kyoga,
            fit: BoxFit.cover, // Ensures the image fills the circle
          ),
        ),
      ),
      title: Text(
        'Mucunguzi Benamin',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      subtitle: Text(
        'benaminmucunguzi@gmail.com',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: IconButton(onPressed: onPressed, icon: const Icon(Iconsax.edit,)),
);
}
}
