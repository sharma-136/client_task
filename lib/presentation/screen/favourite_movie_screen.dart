import 'package:assignment/data/sources/local/app_storage.dart';
import 'package:assignment/presentation/theme/app_theme.dart';
import 'package:assignment/presentation/widget/label.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../binding/movie_detail_binding.dart';
import '../tile/movie_tile.dart';
import 'movie_detail_screen.dart';

class FavouriteMovieScreen extends StatefulWidget {
  const FavouriteMovieScreen({super.key});

  @override
  State<FavouriteMovieScreen> createState() => _FavouriteMovieScreenState();
}

class _FavouriteMovieScreenState extends State<FavouriteMovieScreen> {
  var list = [];

  @override
  void initState() {
    super.initState();
    initialise();
  }

  void initialise() {
    list = AppStorage.getFavouriteMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.black,
          surfaceTintColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: const Label('Watchlist'),
        ),
        if (list.isEmpty)
          Expanded(
            child: Center(
              child: Label(
                'No Data!!',
                style: AppTheme.textStyle(size: 16),
              ),
            ),
          ),
        if (list.isNotEmpty)
          Expanded(
            child: GridView.count(
              padding: EdgeInsets.zero,
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              childAspectRatio: 0.75,
              children: list.map(
                    (e) {
                  return InkWell(
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Remove Movie'),
                            content: const Text('Do you want to remove this movie?'),
                            actions: [
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                              TextButton(
                                child: const Text('Delete'),
                                onPressed: () {
                                  AppStorage.setFavouriteMovies(e);
                                  setState(
                                    () {
                                      initialise();
                                    },
                                  );
                                  Get.back();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    onTap: () {
                      Get.to(() => const MovieDetailScreen(), binding: MovieDetailBinding(), arguments: e.imdbId)?.then((_){
                        setState(() {

                          initialise();
                        });
                      });
                    },
                    child: MovieTile(e),
                  );
                },
              ).toList(),
            ),
          ),
      ],
    );
  }
}
