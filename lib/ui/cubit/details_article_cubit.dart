import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/model/article_model.dart';
import 'package:investkuy/data/repository/article_repository.dart';

class DetailsArticleCubit extends Cubit<DataState> {
  final ArticleRepository repository = ArticleRepository();

  DetailsArticleCubit() : super(InitialState()) {}

  void resetState() async {
    emit(InitialState());
  }

  void getDetailsArticle(int id) async {
    try {
      emit(LoadingState());
      final data = await repository.getDetails(id);
      emit(SuccessState<ArticleModel>(data));
    } on DioException catch (e) {
      emit(ErrorState(e.response!.data['message'].toString()));
      rethrow;
    }
  }
}
