import 'dart:convert';

import 'package:assignment/data/model/movie_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppStorage {
  static final _storage = GetStorage("movies");

  static void setValue(String key, dynamic value) {
    _storage.write(key, value);
  }

  static dynamic getValue(String key) {
    return _storage.read(key);
  }

  static removeKey(String key) {
    _storage.remove(key);
  }

  static void setFavouriteMovies(Movie m) {
    final l = getFavouriteMovies();
    if(l.any((ele)=>ele.imdbId == m.imdbId)){
      l.removeWhere((ele)=>ele.imdbId == m.imdbId);
      removeKey(m.imdbId);
    }else{
      l.add(m);
    }
    var map = {
      'data':List.from(l.map((ele)=>ele.toJson())).toList(),
    };
    _storage.write('favourites', jsonEncode(map));
  }

  static List<Movie> getFavouriteMovies() {
    List<Movie> temp = [];
    final data  = _storage.read('favourites')??'';
    if(data.isNotEmpty){
      final js = jsonDecode(data);
      temp = List.from(js['data'].map((m)=>Movie.fromJson(m)));
    }
    return temp;
  }

  static void clearValue() {
    _storage.erase();
  }
}
