import 'package:equatable/equatable.dart';

abstract class DataState extends Equatable {}

class InitialState extends DataState {
  @override
  List<Object> get props => [];
}

class LoadingState extends DataState {
  @override
  List<Object> get props => [];
}

class SuccessState<T> extends DataState {
  final T data;

  SuccessState(this.data);

  @override
  List<T> get props => [data];
}

class LoadingPaginationState<T> extends DataState {
  final T oldData;
  final bool isFirstFetch;

  LoadingPaginationState(this.oldData, {this.isFirstFetch = false});

  @override
  List<Object> get props => [];
}

class ErrorState extends DataState {
  final String message;

  ErrorState(this.message);

  @override
  List<Object> get props => [];
}