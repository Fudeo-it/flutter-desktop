import 'package:flutter/material.dart';
import 'package:photo_app/models/photo.dart';

class DetailPage extends StatelessWidget {
  final Photo photo;

  const DetailPage(
    this.photo, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(photo.name)),
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: Image.file(
            photo.file,
            fit: BoxFit.fitWidth,
          ),
        ),
      );
}
