part of 'data_bloc.dart';

@immutable
abstract class DataState {}

class DataInitial extends DataState {}

class GetPostState extends DataState {
  final List<PostModel> posts;

  GetPostState(this.posts);
}

class LoadingState extends DataState {
  final bool isLoading;

  LoadingState(this.isLoading);
}
