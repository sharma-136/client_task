import 'package:assignment/presentation/controller/movie_detail_controller.dart';
import 'package:get/get.dart';

class MovieDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MovieDetailController>(() => MovieDetailController());
  }
}
