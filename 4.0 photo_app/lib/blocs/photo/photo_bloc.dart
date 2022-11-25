import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_app/models/photo.dart';
import 'package:photo_app/repositories/photo_repository.dart';

part 'photo_event.dart';
part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final PhotoRepository photoRepository;

  PhotoBloc({required this.photoRepository}) : super(FetchingPhotoState()) {
    on<SelectPhotoEvent>(_onSelect);
    on<UnselectPhotoEvent>(_onUnselect);
    on<FetchPhotosEvent>(_onFetch);
  }

  void selectPhoto(Photo photo) => add(SelectPhotoEvent(photo));

  void unselectPhoto() => add(UnselectPhotoEvent());

  void fetchPhotos() => add(FetchPhotosEvent());

  FutureOr<void> _onSelect(SelectPhotoEvent event, Emitter<PhotoState> emit) {
    emit(SelectedPhotoState(event.photo));
  }

  FutureOr<void> _onUnselect(
      UnselectPhotoEvent event, Emitter<PhotoState> emit) {
    emit(UnselectedPhotoState());
  }

  FutureOr<void> _onFetch(
      FetchPhotosEvent event, Emitter<PhotoState> emit) async {
    try {
      final photos = await photoRepository.photos;
      emit(photos.isNotEmpty ? FetchedPhotoState(photos) : NoPhotoState());
    } catch (error) {
      emit(ErrorPhotoState(error));
    }
  }
}
