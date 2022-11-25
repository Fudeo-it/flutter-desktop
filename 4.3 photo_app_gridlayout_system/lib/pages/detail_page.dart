import 'package:flutter/material.dart';
import 'package:photo_app/models/photo.dart';

class DetailPage extends StatelessWidget {
  final Photo photo;
  final bool masterDetail;

  const DetailPage(
    this.photo, {
    this.masterDetail = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: !masterDetail ? AppBar(title: Text(photo.name)) : null,
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: Image.file(
            photo.file,
            fit: BoxFit.fitWidth,
          ),
        ),
      );
}
