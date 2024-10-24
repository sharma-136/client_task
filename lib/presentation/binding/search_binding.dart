import 'package:assignment/presentation/controller/search_controller.dart';
import 'package:get/get.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchsController>(() => SearchsController());
  }
}
