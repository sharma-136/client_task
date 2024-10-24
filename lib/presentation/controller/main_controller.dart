import 'package:assignment/data/model/movie_model.dart';
import 'package:assignment/data/repository/movie_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MainController extends GetxController with StateMixin<dynamic> {
  final scrollController = ScrollController();

  final repository = MovieRepository();

  var isLoading = true;
  var movieList = <Movie>[].obs;
  var seriesList = <Movie>[].obs;
  var currentIndex = 0.obs;
  var pageIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    Future.wait([movie(), series()]).then((_) {
      isLoading = false;
      update();
    });
  }


  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future series() async {
    Map<String, dynamic> q = {
      's': 'series',
    };
    await repository.movies(q).then((value) {
      seriesList.addAll(List<Movie>.from(value['Search'].map((e) => Movie.fromJson(e))));
      update();
    }, onError: (e) {
      isLoading = true;
      update();
    });
  }

  Future movie() async {
    Map<String, dynamic> q = {
      's': 'movies',
    };
    await repository.movies(q).then((value) {
      movieList.addAll(List<Movie>.from(value['Search'].map((e) => Movie.fromJson(e))));
      update();
    }, onError: (e) {
      isLoading = true;
      Get.snackbar('Error', e);
      update();
    });
  }
}
