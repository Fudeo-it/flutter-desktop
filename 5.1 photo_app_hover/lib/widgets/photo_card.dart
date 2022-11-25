import 'package:flutter/material.dart';
import 'package:photo_app/models/photo.dart';

class PhotoCard extends StatefulWidget {
  final Photo photo;
  final VoidCallback? onTap;

  const PhotoCard(
    this.photo, {
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PhotoCardState();
}

class _PhotoCardState extends State<PhotoCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) => Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: widget.onTap,
          onHover: _updateHoverState,
          child: Stack(
            children: [
              AnimatedScale(
                scale: _hovered ? 1.2 : 1.0,
                duration: const Duration(milliseconds: 250),
                child: Image.file(
                  widget.photo.file,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Positioned(
                left: 0,
                bottom: 0,
                right: 0,
                child: Container(
                  color: Colors.black54,
                  child: ListTile(
                    title: Text(
                      widget.photo.name,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  void _updateHoverState(bool hovered) => setState(() => _hovered = hovered);
}
