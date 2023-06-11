import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/repository/profile_repository.dart';

class SettingCubit extends Cubit<DataState> {
  final ProfileRepository repository = ProfileRepository();

  SettingCubit() : super(InitialState());
}