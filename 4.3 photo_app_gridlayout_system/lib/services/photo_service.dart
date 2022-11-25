import 'dart:io';

import 'package:mime/mime.dart';
import 'package:photo_app/models/photo.dart';

class PhotoService {
  static const _supportedMimeTypes = ['image/png', 'image/jpeg'];

  Future<List<Photo>> get photos async {
    final folder = Directory('/home/angeloavv/Immagini/photo_app');

    return await folder
        .list()
        .where((entity) =>
            entity is File &&
            _supportedMimeTypes.contains(lookupMimeType(entity.path)))
        .map((entity) => Photo.fromSystemEntity(entity))
        .toList();
  }
}
