import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_app/blocs/photo/photo_bloc.dart';
import 'package:photo_app/models/photo.dart';
import 'package:photo_app/pages/detail_page.dart';
import 'package:photo_app/widgets/exception_widget.dart';
import 'package:photo_app/widgets/grid_builder.dart';
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
                return GridBuilder(
                  extraSmall: (context) => CustomListView(state.photos),
                  small: (context) => CustomGridView(
                    state.photos,
                    width: 750,
                  ),
                  medium: (context) => CustomGridView(
                    state.photos,
                    width: 1150,
                    itemsPerRow: 3,
                  ),
                  large: (context) => CustomGridView(
                    state.photos,
                    width: 1550,
                    itemsPerRow: 4,
                  ),
                  extraLarge: (context) => CustomGridView(
                    state.photos,
                    itemsPerRow: 5,
                  ),
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
}

class CustomListView extends StatelessWidget {
  final List<Photo> photos;

  const CustomListView(this.photos, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView.separated(
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

class CustomGridView extends StatelessWidget {
  final List<Photo> photos;
  final int itemsPerRow;
  final double width;

  const CustomGridView(
    this.photos, {
    Key? key,
    this.itemsPerRow = 2,
    this.width = 1950,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: width,
          child: GridView.count(
            crossAxisCount: itemsPerRow,
            childAspectRatio: 5 / 3,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            children: photos
                .map((photo) => PhotoCard(
                      photo,
                      onTap: () => context.read<PhotoBloc>().selectPhoto(photo),
                    ))
                .toList(growable: false),
          ),
        ),
      );
}
