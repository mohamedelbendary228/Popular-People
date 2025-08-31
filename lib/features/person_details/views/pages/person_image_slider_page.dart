import 'package:flutter/material.dart';
import 'package:popular_people/core/widgets/app_cached_network_image.dart';
import 'package:popular_people/features/person_details/models/person_images.dart';
import 'package:popular_people/features/person_details/views/widgets/save_image_slider_action.dart';
import 'package:popular_people/features/person_details/views/widgets/slider_action.dart';

class PersonImagesSliderPage extends StatefulWidget {
  final int initialImageIndex;
  final List<PersonImage> images;

  const PersonImagesSliderPage({
    super.key,
    this.initialImageIndex = 0,
    required this.images,
  });

  @override
  State<PersonImagesSliderPage> createState() => PersonImagesSliderPageState();
}

class PersonImagesSliderPageState extends State<PersonImagesSliderPage> {
  late final PageController pageController;

  bool isLoadingImageSave = false;

  @override
  void initState() {
    pageController = PageController(initialPage: widget.initialImageIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: pageController,
              itemCount: widget.images.length,
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: [
                    Positioned.fill(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: widget.images[index].imageUrl == null
                            ? Container()
                            : AppCachedNetworkImage(
                                imageUrl: widget.images[index].imageUrl!,
                                fit: BoxFit.fitWidth,
                                isLoaderShimmer: false,
                                alignment: Alignment.topCenter,
                              ),
                      ),
                    ),
                    if (widget.images[index].imageUrl != null)
                      PositionedDirectional(
                        top: 20,
                        end: 17,
                        child: SaveImageSliderAction(
                          imageUrl: widget.images[index].imageUrl!,
                        ),
                      ),
                  ],
                );
              },
            ),
            PositionedDirectional(
              bottom: 30,
              start: 20,
              child: SliderAction(
                icon: const Icon(Icons.arrow_back),
                onTap: () {
                  pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
            PositionedDirectional(
              bottom: 30,
              end: 20,
              child: SliderAction(
                icon: const Icon(Icons.arrow_forward),
                onTap: () {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
