import 'package:flutter/material.dart';
import 'package:photo_app/models/photo.dart';

class PhotoCard extends StatelessWidget {
  final Photo photo;
  final VoidCallback? onTap;

  const PhotoCard(
    this.photo, {
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: onTap,
          child: Stack(
            children: [
              Image.file(
                photo.file,
                fit: BoxFit.fitWidth,
              ),
              Positioned(
                left: 0,
                bottom: 0,
                right: 0,
                child: Container(
                  color: Colors.black54,
                  child: ListTile(
                    title: Text(
                      photo.name,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
