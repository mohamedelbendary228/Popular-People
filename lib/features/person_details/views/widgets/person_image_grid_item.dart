import 'package:flutter/material.dart';
import 'package:popular_people/core/widgets/app_cached_network_image.dart';
import 'package:popular_people/features/person_details/models/person_images.dart';

/// Widget of a person images section grid item
class PersonImagesGridItem extends StatelessWidget {
  final PersonImage personImage;
  final VoidCallback? onTap;

  const PersonImagesGridItem(
    this.personImage, {
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: personImage.thumbnail == null
          ? const ColoredBox(color: Colors.white)
          : AppCachedNetworkImage(
              imageUrl: personImage.thumbnail!,
              fit: BoxFit.cover,
            ),
    );
  }
}
