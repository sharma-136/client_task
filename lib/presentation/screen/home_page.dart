import 'package:assignment/presentation/controller/main_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../binding/movie_detail_binding.dart';
import '../theme/app_theme.dart';
import '../tile/movie_tile.dart';
import '../widget/label.dart';
import 'movie_detail_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          child: CustomScrollView(
            controller: controller.scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 450.0,
                    autoPlay: true,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      controller.currentIndex(index);
                    },
                  ),
                  items: controller.seriesList.take(5).map((series) {
                    return InkWell(
                      onTap: () {
                        Get.to(() => const MovieDetailScreen(), binding: MovieDetailBinding(), arguments: series.imdbId);
                      },
                      child: Container(
                        color: Colors.black,
                        width: double.maxFinite,
                        child: Stack(
                          children: [
                            Positioned.fill(
                                child: CachedNetworkImage(
                              imageUrl: series.poster,
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
                            )),
                            Positioned.fill(
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.black12, Colors.black12, Colors.black26, Colors.black87, Colors.black87],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 20,
                              bottom: 20,
                              right: 20,
                              child: Label(
                                series.title,
                                style: AppTheme.textStyle(color: Colors.white, weight: FontWeight.w500, size: 16),
                                maxLine: 2,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20, top: 10),
                  height: 4,
                  child: Center(
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [0, 1, 2, 3, 4].map((ele) {
                        return Obx(() => Container(
                              margin: const EdgeInsets.only(right: 2),
                              width: 10,
                              height: 2,
                              decoration: BoxDecoration(color: ele == controller.currentIndex.value ? Colors.white : Colors.grey, borderRadius: BorderRadius.circular(2)),
                            ));
                      }).toList(),
                    ),
                  ),
                ),
              ),
              SliverGrid.count(
                crossAxisCount: 2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                childAspectRatio: 0.75,
                children: controller.movieList
                    .map((e) => InkWell(
                        onTap: () {
                          Get.to(() => const MovieDetailScreen(), binding: MovieDetailBinding(), arguments: e.imdbId);
                        },
                        child: MovieTile(e)))
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
