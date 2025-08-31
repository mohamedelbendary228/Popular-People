import 'package:flutter/material.dart';
import 'package:popular_people/core/constants/ui_contants.dart';
import 'package:popular_people/core/enums/gender.dart';
import 'package:popular_people/core/widgets/app_cached_network_image.dart';

class PersonCover extends StatelessWidget {
  final String? coverUrl;
  final Gender gender;
  final double height;

  const PersonCover(
    this.coverUrl, {
    super.key,
    this.gender = Gender.unknown,
    this.height = UIConstants.personListItemHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: coverUrl == null
          ? Image.asset(
              'assets/images/placeholder-${gender.name}.png',
              fit: BoxFit.cover,
            )
          : AppCachedNetworkImage(
              imageUrl: coverUrl!,
            ),
    );
  }
}
