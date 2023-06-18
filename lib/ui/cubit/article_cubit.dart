import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investkuy/data/data_state.dart';
import 'package:investkuy/data/model/article_model.dart';
import 'package:investkuy/data/repository/article_repository.dart';

class ArticleCubit extends Cubit<DataState> {
  final ArticleRepository repository = ArticleRepository();

  ArticleCubit() : super(InitialState()) {
    getAllArticle();
  }

  void resetState() async {
    emit(InitialState());
  }

  void getAllArticle() async {
    try {
      emit(LoadingState());
      final data = await repository.getAll();
      emit(SuccessState<List<ArticleModel>>(data));
    } on DioException catch (e) {
      emit(ErrorState(e.response!.data['message'].toString()));
      rethrow;
    }
  }

  void getLimitArticle() async {
    try {
      emit(LoadingState());
      final data = await repository.getLimit();
      emit(SuccessState<List<ArticleModel>>(data));
    } on DioException catch (e) {
      emit(ErrorState(e.response!.data['message'].toString()));
      rethrow;
    }
  }
}
