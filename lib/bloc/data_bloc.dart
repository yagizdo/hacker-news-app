import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../Models/post_model.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(DataInitial()) {
    on<DataEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
