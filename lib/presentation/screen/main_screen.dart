import 'package:assignment/presentation/binding/search_binding.dart';
import 'package:assignment/presentation/controller/main_controller.dart';
import 'package:assignment/presentation/screen/home_page.dart';
import 'package:assignment/presentation/screen/favourite_movie_screen.dart';
import 'package:assignment/presentation/screen/search_screen.dart';
import 'package:assignment/presentation/theme/app_theme.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) {
        return Scaffold(
            backgroundColor: Colors.black,
            floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
            floatingActionButton: Visibility(
              visible: controller.isLoading == false && controller.pageIndex.value != 1,
              child: FloatingActionButton(
                elevation: 0.0,
                backgroundColor: Colors.white10,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                onPressed: () {
                  Get.to(() => const SearchScreen(), binding: SearchBinding());
                },
                child: const Icon(Icons.search, color: Colors.white),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: controller.pageIndex.value,
              elevation: 0.0,
              backgroundColor: Colors.black,
              unselectedFontSize: 10,
              selectedFontSize: 11,
              selectedLabelStyle: AppTheme.textStyle(color: Colors.white, size: 11, weight: FontWeight.w500),
              unselectedLabelStyle: AppTheme.textStyle(color: Colors.grey, size: 10),
              onTap: (index) {
                controller.pageIndex(index);
                controller.update();
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.movie_creation_outlined),
                  activeIcon: Icon(Icons.movie_creation_rounded),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark_border),
                  activeIcon: Icon(Icons.bookmark_outlined),
                  label: "Watchlist",
                )
              ],
            ),
            body: controller.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : [const HomePage(), const FavouriteMovieScreen()][controller.pageIndex.value]);
      },
    );
  }
}
