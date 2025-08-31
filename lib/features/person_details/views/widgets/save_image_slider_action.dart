import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popular_people/core/theme/app_colors.dart';
import 'package:popular_people/core/widgets/loading_widget.dart';
import 'package:popular_people/features/person_details/views/widgets/slider_action.dart';

/// StateProvider for loading state of image saving action
final isLoadingSaveImage = StateProvider<bool>((_) => false);

class SaveImageSliderAction extends ConsumerWidget {
  final String imageUrl;

  const SaveImageSliderAction({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(isLoadingSaveImage)
        ? const Padding(
            padding: EdgeInsets.all(10),
            child: LoadingWidget(),
          )
        : SliderAction(
            color: AppColors.secondary,
            icon: const Icon(Icons.download),
            onTap: ref.watch(isLoadingSaveImage)
                ? null
                : () {
                    // ref.read(isLoadingSaveImage.notifier).state = true;
                    // ref.read(mediaServiceProvider).saveNetworkImageToGallery(imageUrl).then((_) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(
                    //       content: Text('Image saved to gallery successfully!'),
                    //       duration: Duration(seconds: 1),
                    //     ),
                    //   );
                    //   ref.read(isLoadingSaveImage.notifier).state = false;
                    // });
                  },
          );
  }
}
