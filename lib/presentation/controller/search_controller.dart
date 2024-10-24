import 'dart:async';

import 'package:assignment/data/repository/movie_repository.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../data/model/movie_model.dart';

class SearchsController extends GetxController with StateMixin<dynamic> {
  final searchController = TextEditingController();
  final repository = MovieRepository();
  var movieList = <Movie>[].obs;
  bool isLoading = false;
  var searchString = '';
  Timer? timer;
  bool noData =  false;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    timer?.cancel();
    searchController.dispose();
    super.onClose();
  }

  void searchData(String key) {

    movieList.clear();
    isLoading =true;
    if(key.trim().length<4){
      return;
    }
    timer?.cancel();
    timer = Timer(const Duration(milliseconds: 1200), () {
      searchString = key;
      movieData();
      update();
    });
  }

  Future movieData() async {
    Map<String, dynamic> q = {
      's': searchString,
    };
    await repository.movies(q).then((value) {
      isLoading =false;
      if(value['Response'] == 'True'){
        movieList.addAll(List<Movie>.from(value['Search'].map((e) => Movie.fromJson(e))));
        noData =false;
        update();
      }else{

      noData = true;
      update();
      }

    }, onError: (e) {
      Get.snackbar('error', e);
      update();
    });
  }
}
