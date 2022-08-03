import 'package:dio/dio.dart';
import 'package:hackernews_read_app/Models/post_model.dart';
import 'package:hackernews_read_app/core/network_client.dart';
import 'package:hackernews_read_app/core/services/i_client_service.dart';

class ClientService extends NetworkClient implements IClientService {
  // Get post ids on API
  @override
  Future getPostIDs() async {
    var postIDList = <int>[];

    Response result = await dio.get('v0/topstories.json');

    if (result.statusCode == 200) {
      return result.data;
    } else {
      print('Error : ${result.headers}');
    }

    return postIDList;
  }

  @override
  Future<List<PostModel>> getPostById(int postID) async {
    List<PostModel> posts = [];
    final response = await dio.get('v0/item/$postID.json');

    if (response.statusCode == 200) {
      var parsedList = response.data;
      posts = parsedList.map<PostModel>((post) => PostModel.fromJson(post));
      return posts;
    }

    return posts;
  }
}
