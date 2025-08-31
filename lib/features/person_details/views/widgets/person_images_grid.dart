import 'package:flutter/material.dart';
import 'package:popular_people/features/person_details/models/person_images.dart';
import 'package:popular_people/features/person_details/views/pages/person_image_slider_page.dart';
import 'package:popular_people/features/person_details/views/widgets/person_image_grid_item.dart';

class PersonImagesGrid extends StatelessWidget {
  final List<PersonImage> images;

  const PersonImagesGrid(
    this.images, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (images.length / 3).ceil() * ((MediaQuery.of(context).size.width - 10 * 4) / 3),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: images.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        padding: const EdgeInsetsDirectional.only(start: 30, end: 17),
        itemBuilder: (context, index) => ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: PersonImagesGridItem(
            images[index],
            onTap: () {
              Navigator.of(context).push<PersonImagesSliderPage>(
                MaterialPageRoute<PersonImagesSliderPage>(
                  builder: (context) => PersonImagesSliderPage(
                    images: images,
                    initialImageIndex: index,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
