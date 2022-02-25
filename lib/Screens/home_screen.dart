import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hackernews_read_app/Models/post_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Dio? dio;
  var postIDList = <int>[];
  bool isIDLoading = false;
  bool isPostsLoading = false;
  PostModel? posts;

  @override
  void initState() {
    super.initState();
    BaseOptions options = BaseOptions();
    options.baseUrl = 'https://hacker-news.firebaseio.com/';
    dio = Dio(options);
    getPostID();
    getPosts();
  }

  // Get Post ID's
  Future<List> getPostID() async {
    setState(() {
      isIDLoading = true;
    });
    Response? result = await dio?.get('v0/topstories.json?print=pretty');
    if (result?.statusCode == 200) {
      (result?.data as List).forEach((value) {
        postIDList.add(value);
      });
    }
    setState(() {
      isIDLoading = false;
    });

    return postIDList;
  }

  Future<void> getPosts() async {
    setState(() {
      isPostsLoading = true;
    });
    final response = await dio?.get('v0/item/30438250.json?print=pretty');
    if (response?.statusCode == 200) {
      posts = PostModel.fromJson(response?.data);
    }
    setState(() {
      isPostsLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
