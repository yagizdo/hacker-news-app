part of 'data_bloc.dart';

@immutable
abstract class DataState {}

class DataInitial extends DataState {}

class GetPostState extends DataState {}

class LoadingState extends DataState {}
