part of 'photo_bloc.dart';

abstract class PhotoState extends Equatable {
  const PhotoState();

  @override
  List<Object> get props => [];
}

class FetchingPhotoState extends PhotoState {}

class FetchedPhotoState extends PhotoState {
  final List<Photo> photos;

  const FetchedPhotoState(this.photos);

  @override
  List<Object> get props => [photos];
}

class NoPhotoState extends PhotoState {}

class ErrorPhotoState extends PhotoState {
  final dynamic error;

  const ErrorPhotoState(this.error);

  @override
  List<Object> get props => [error];
}

class SelectedPhotoState extends PhotoState {
  final Photo photo;

  const SelectedPhotoState(this.photo);

  @override
  List<Object> get props => [photo];
}

class UnselectedPhotoState extends PhotoState {}
