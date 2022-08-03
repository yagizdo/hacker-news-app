import 'package:bloc/bloc.dart';
import 'package:hackernews_read_app/core/services/client_service.dart';
import 'package:meta/meta.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final ClientService clientService = ClientService();
  List posts = [];
  List<int> postIDs = [];
  DataBloc() : super(DataInitial()) {
    on<DataEvent>((event, emit) {});
    on<GetPostEvent>((event, emit) async {
      emit(LoadingState(true));
      postIDs = await clientService.getPostIDs();
      var postResponse = await Stream.fromIterable(postIDs)
          .asyncMap((id) => clientService.getPostById(id))
          .toList();
      posts = postResponse;
      emit(LoadingState(false));
      emit(GetPostState(posts));
    });
  }
}
