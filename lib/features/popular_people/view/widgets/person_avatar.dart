import 'package:flutter/material.dart';
import 'package:popular_people/core/enums/gender.dart';
import 'package:popular_people/core/widgets/app_cached_network_image.dart';

class PersonAvatar extends StatelessWidget {
  final String? avatarUrl;
  final Gender gender;

  const PersonAvatar({
    this.avatarUrl,
    this.gender = Gender.unknown,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: avatarUrl == null
          ? Image.asset(
              'assets/images/placeholder-${gender.name}.png',
              fit: BoxFit.cover,
              height: 90,
            )
          : AppCachedNetworkImage(
              imageUrl: avatarUrl!,
              height: 90,
            ),
    );
  }
}
