import 'package:flutter_bloc/flutter_bloc.dart';

class DarkThemeCubit extends Cubit<bool> {
  DarkThemeCubit() : super(true);

  void toggle() => emit(!state);
}
