import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_app/blocs/photo/photo_bloc.dart';
import 'package:photo_app/models/photo.dart';
import 'package:photo_app/pages/detail_page.dart';
import 'package:photo_app/widgets/exception_widget.dart';
import 'package:photo_app/widgets/loading_widget.dart';
import 'package:photo_app/widgets/photo_card.dart';
import 'package:photo_app/widgets/responsive_builder.dart';

class PhotosPage extends StatelessWidget {
  const PhotosPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => PhotoBloc(
          photoRepository: context.read(),
        )..fetchPhotos(),
        child: Scaffold(
            appBar: AppBar(title: const Text('Photo')),
            body: ResponsiveBuilder(
              builder: (context, deviceType) {
                final masterDetail = deviceType > DeviceType.phone;

                return Row(
                  children: [
                    _master(context, masterDetail: masterDetail),
                    if (masterDetail) _detail(context),
                  ],
                );
              },
            )),
      );

  Widget _master(
    BuildContext context, {
    bool masterDetail = false,
  }) =>
      Expanded(
        child: BlocConsumer<PhotoBloc, PhotoState>(
            listenWhen: (_, curr) =>
                curr is SelectedPhotoState || curr is UnselectedPhotoState,
            listener: (context, state) async {
              if (state is SelectedPhotoState && !masterDetail) {
                final photoBloc = context.read<PhotoBloc>();

                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(state.photo),
                  ),
                );

                photoBloc.unselectPhoto();
              }
            },
            buildWhen: (_, curr) =>
                curr is! SelectedPhotoState && curr is! UnselectedPhotoState,
            builder: (context, state) {
              if (state is ErrorPhotoState) {
                return const ExceptionWidget(
                  title: 'Uh Oh!',
                  subtitle: 'An error has occurred',
                );
              } else if (state is NoPhotoState) {
                return const ExceptionWidget(
                  title: 'Ops!',
                  subtitle: 'No photos found',
                );
              } else if (state is FetchedPhotoState) {
                return _listView(
                  context,
                  photos: state.photos,
                );
              }

              return const LoadingWidget();
            }),
      );

  Widget _detail(BuildContext context) => BlocBuilder<PhotoBloc, PhotoState>(
        buildWhen: (_, curr) =>
            curr is SelectedPhotoState || curr is UnselectedPhotoState,
        builder: (context, state) {
          if (state is SelectedPhotoState) {
            return Expanded(
                flex: 2,
                child: DetailPage(
                  state.photo,
                  masterDetail: true,
                ));
          }

          return const SizedBox();
        },
      );

  Widget _listView(
    BuildContext context, {
    required List<Photo> photos,
  }) =>
      ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final photo = photos[index];

          return PhotoCard(
            photo,
            onTap: () => context.read<PhotoBloc>().selectPhoto(photo),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 24),
        itemCount: photos.length,
      );
}
