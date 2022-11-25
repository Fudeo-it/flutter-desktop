part of 'photo_bloc.dart';

abstract class PhotoEvent extends Equatable {
  const PhotoEvent();

  @override
  List<Object?> get props => [];
}

class SelectPhotoEvent extends PhotoEvent {
  final Photo photo;

  const SelectPhotoEvent(this.photo);

  @override
  List<Object?> get props => [photo];
}

class UnselectPhotoEvent extends PhotoEvent {}

class FetchPhotosEvent extends PhotoEvent {}
