import 'package:photo_app/models/photo.dart';
import 'package:photo_app/services/photo_service.dart';

class PhotoRepository {
  final PhotoService photoService;

  PhotoRepository({required this.photoService});

  Future<List<Photo>> get photos => photoService.photos;
}
