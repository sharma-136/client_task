import 'package:assignment/data/model/detail_model.dart';
import 'package:assignment/data/model/movie_model.dart';
import 'package:assignment/data/repository/movie_repository.dart';
import 'package:assignment/data/sources/local/app_storage.dart';
import 'package:get/get.dart';

class MovieDetailController extends GetxController with StateMixin<dynamic> {
  final repository = MovieRepository();
  var imdb = '';
  var genre =[];
  Details? details;

  var isFavourite = false.obs;

  @override
  void onInit() {
    super.onInit();
    imdb = Get.arguments;
    var f = AppStorage.getValue(imdb)??false;
    isFavourite(f);
    detail();
  }



  void onFavourite() {
    var hasValue = AppStorage.getValue(imdb);
    if(hasValue==null){
      AppStorage.setValue(imdb,true);
    }else{
      AppStorage.removeKey(imdb);
    }
    isFavourite.toggle();
    var m = Movie.fromJson(details!.toMovie());
    AppStorage.setFavouriteMovies(m);
    update();

    Future.delayed(const Duration(seconds: 2),(){
      AppStorage.getFavouriteMovies().forEach((f){

      });
    });
  }

  Future detail() async {
    Map<String, dynamic> q = {
      'i': imdb,
    };
    await repository.movies(q).then((value) {
      details = Details.fromJson(value);
      genre = details!.genre.split(',');

      update();
    }, onError: (e) {
      Get.snackbar('error', e);
      update();
    });
  }
}
