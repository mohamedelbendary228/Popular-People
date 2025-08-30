import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:popular_people/core/widgets/error_widget.dart';
import 'package:popular_people/core/widgets/loading_widget.dart';
import 'package:popular_people/core/widgets/shimmer.dart';

class AppCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final LoadingErrorWidgetBuilder? customErrorWidgetBuilder;
  final Widget? customErrorWidget;
  final Widget? loadingWidget;
  final bool loading;
  final double? height;
  final double? width;
  final BoxFit fit;
  final Alignment alignment;
  final Color? color;
  final BlendMode? colorBlendMode;
  final bool isLoaderShimmer;

  const AppCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.customErrorWidgetBuilder,
    this.loading = false,
    this.customErrorWidget,
    this.loadingWidget,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.color,
    this.colorBlendMode,
    this.isLoaderShimmer = true,
  });

  @override
  Widget build(BuildContext context) {
    final memCacheHeight = height != null ? (height! * 2).ceil() : null;
    final memCacheWidth = width != null ? (width! * 2).ceil() : null;
    return RepaintBoundary(
      child: CachedNetworkImage(
        placeholder: loading
            ? null
            : (_, __) => Center(
                  child: loadingWidget ??
                      (isLoaderShimmer
                          ? Shimmer(
                              height: height,
                              width: width,
                            )
                          : const LoadingWidget()),
                ),
        memCacheHeight: memCacheHeight,
        memCacheWidth: memCacheWidth,
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        color: color,
        colorBlendMode: colorBlendMode,
        alignment: alignment,
        errorWidget: customErrorWidgetBuilder ??
            (BuildContext context, String url, dynamic error) {
              return customErrorWidget ?? const ErrorView();
            }, // coverage:ignore-end
      ),
    );
  }
}
