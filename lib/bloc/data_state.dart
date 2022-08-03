part of 'data_bloc.dart';

@immutable
abstract class DataState {}

class DataInitial extends DataState {}

class GetPostState extends DataState {
  final List posts;

  GetPostState(this.posts);
}

class LoadingState extends DataState {
  bool isLoading;

  LoadingState(this.isLoading);
}
