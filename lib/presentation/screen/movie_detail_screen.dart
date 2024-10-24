import 'package:assignment/data/model/detail_model.dart';
import 'package:assignment/presentation/controller/movie_detail_controller.dart';
import 'package:assignment/presentation/theme/color.dart';
import 'package:assignment/presentation/widget/label.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../theme/app_theme.dart';

class MovieDetailScreen extends StatelessWidget {
  final Details? movie;

  const MovieDetailScreen({super.key, this.movie});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MovieDetailController>(
      builder: (controller) {
        if (controller.details == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl: controller.details!.poster,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                        placeholder: (context, url) {
                          return const Center(
                            child: Opacity(
                              opacity: 0.5,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                        errorWidget: (context, url, error) {
                          return const Icon(Icons.image, size: 100, color: Colors.black12);
                        },
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.black12, Colors.black12, Colors.black87], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                      ),
                    ),
                    Positioned(
                      top: kToolbarHeight - 20,
                      left: 10,
                      child: Container(
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.withOpacity(0.3)),
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 6,
                      left: 6,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Label(
                            controller.details!.title,
                            style: AppTheme.textStyle(color: Colors.white, weight: FontWeight.w500, size: 16),
                            maxLine: 2,
                            textAlign: TextAlign.center,
                          ),
                          RatingBar.builder(
                            itemSize: 10,
                            initialRating: (double.parse(controller.details!.imdbRating) / 2).roundToDouble(),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Label(controller.details!.year).paddingOnly(right: 5),
                              Container(
                                height: 5,
                                width: 5,
                                decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                              ).paddingOnly(right: 5),
                              Label(controller.details!.runtime).paddingOnly(right: 5),
                              Container(
                                height: 5,
                                width: 5,
                                decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                              ).paddingOnly(right: 5),
                              Label(controller.details!.language).paddingOnly(right: 5),
                            ],
                          ),
                          FractionallySizedBox(
                            widthFactor: 0.5,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: primary),
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                    ),
                                    Label(
                                      'Watch',
                                      style: AppTheme.textStyle(color: Colors.white, weight: FontWeight.w500),
                                    ),
                                  ],
                                )),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: controller.genre.map((e) {
                                return Label(
                                  e.trim(),
                                  style: AppTheme.textStyle(weight: FontWeight.w500, color: Colors.white),
                                );
                              }).toList()),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Label(
                  controller.details!.plot,
                  textAlign: TextAlign.center,
                  style: AppTheme.textStyle(size: 12),
                ).paddingOnly(left: 10, right: 10),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Obx(
                        () => InkWell(
                          onTap: controller.onFavourite,
                          child: Visibility(
                            visible: controller.isFavourite.isTrue,
                            replacement: columnWidget(const Icon(Icons.bookmark_add_outlined), 'WatchList'),
                            child: columnWidget(const Icon(Icons.bookmark), 'Added'),
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: InkWell(onTap: () {}, child: columnWidget(const Icon(Icons.share), 'share'))),
                    Expanded(child: InkWell(onTap: () {}, child: columnWidget(const Icon(Icons.download_outlined), 'download'))),
                  ],
                ),
                const SizedBox(height: 20),
                rowWidget('Actor', controller.details!.actors),
                const SizedBox(height: 10),
                rowWidget('Director', controller.details!.director),
                const SizedBox(height: 10),
                rowWidget('Writer', controller.details!.writer),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget rowWidget(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Label(
              label,
              style: AppTheme.textStyle(color: Colors.white, weight: FontWeight.normal, size: 12),
              textAlign: TextAlign.start,
            ),
          ),
          const Label(':'),
          const SizedBox(width: 20),
          Expanded(
            flex: 7,
            child: Label(
              value,
              textAlign: TextAlign.start,
              style: AppTheme.textStyle(size: 11),
            ),
          )
        ],
      ),
    );
  }

  Widget columnWidget(Icon icon, String text) {
    return Column(
      children: [
        icon,
        Label(
          text,
          style: AppTheme.textStyle(size: 10),
        )
      ],
    );
  }
}
