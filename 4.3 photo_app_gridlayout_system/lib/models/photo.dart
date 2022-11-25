import 'dart:io';

import 'package:equatable/equatable.dart';

class Photo extends Equatable {
  final String name;
  final File file;

  const Photo({
    required this.name,
    required this.file,
  });

  factory Photo.fromSystemEntity(FileSystemEntity entity) {
    final name = entity.uri.pathSegments.last;
    final file = entity as File;

    return Photo(name: name, file: file);
  }

  @override
  List<Object?> get props => [file];
}
