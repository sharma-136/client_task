import 'package:assignment/data/model/movie_model.dart';
import 'package:assignment/presentation/theme/app_theme.dart';
import 'package:assignment/presentation/theme/color.dart';
import 'package:assignment/presentation/widget/label.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/utils.dart';

class MovieTile extends StatelessWidget {
  final Movie item;

  const MovieTile(Movie this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: CachedNetworkImage(imageUrl: item.poster,
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
            )
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black12, Colors.black12,Colors.black87],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        Positioned(
          left: 6,
          bottom: 6,
          right: 6,
          child: Label(
            item.title,
            style: AppTheme.textStyle(color: Colors.white, weight: FontWeight.w600, size: 12),
            maxLine: 1,
            textAlign: TextAlign.center,
          ),
        ),
        Positioned(
          left: 0,
          top: 10,
          child: Container(
            height: 20,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.horizontal(
                right: Radius.circular(10)
              )
            ),
            child: Label(
              item.type.capitalize??'',
              style: AppTheme.textStyle(size: 12,weight: FontWeight.w500,color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
