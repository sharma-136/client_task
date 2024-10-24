import 'package:flutter/material.dart';

class SearchbarWidget extends StatefulWidget {
  final TextEditingController controller;
  const SearchbarWidget(this.controller,{super.key});

  @override
  State<SearchbarWidget> createState() => _SearchbarWidgetState();
}

class _SearchbarWidgetState extends State<SearchbarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(

      ),
      child: TextField(

      ),
    );
  }
}
