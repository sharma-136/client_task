import 'package:assignment/presentation/theme/app_theme.dart';
import 'package:assignment/presentation/widget/label.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../binding/movie_detail_binding.dart';
import '../controller/search_controller.dart';
import '../tile/movie_tile.dart';
import 'movie_detail_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchsController>(
      builder: (controller) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: kToolbarHeight),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, width: 0.5),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: Colors.grey),
                      ),
                      Expanded(
                        child: TextField(
                          style: AppTheme.textStyle(size: 13, color: Colors.white, weight: FontWeight.w500),
                          decoration: InputDecoration(
                            hintText: 'Movie name or Date(2018)',
                            border: InputBorder.none,
                            hintStyle: AppTheme.textStyle(
                              size: 13,
                              color: Colors.grey,
                            ),
                          ),
                          onChanged: (value) {
                            controller.searchData(value);
                          },
                          controller: controller.searchController,
                        ),
                      ),
                      IconButton(
                        onPressed: controller.searchController.text.isEmpty
                            ? null
                            : () {
                                controller.searchController.clear();
                                controller.update();
                              },
                        icon: controller.searchController.text.isNotEmpty ? const Icon(Icons.clear) : const Icon(Icons.search),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Label(
                  "Enter minimum 4 character to search movies or series",
                  style: AppTheme.textStyle(
                    size: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                controller.isLoading
                    ? const Expanded(
                        child: Center(
                        child: CircularProgressIndicator(),
                      ))
                    : controller.noData
                        ? Expanded(
                            child: Center(
                                child: Label(
                            'No Data!!',
                            style: AppTheme.textStyle(size: 16),
                          )))
                        : Expanded(
                            child: GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 4,
                              mainAxisSpacing: 4,
                              childAspectRatio: 0.75,
                              children: controller.movieList
                                  .map(
                                    (e) => InkWell(
                                      onTap: () {
                                        Get.to(() => const MovieDetailScreen(), binding: MovieDetailBinding(), arguments: e.imdbId);
                                      },
                                      child: MovieTile(e),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
              ],
            ),
          ),
        );
      },
    );
  }
}
