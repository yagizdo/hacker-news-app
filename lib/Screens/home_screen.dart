import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    BaseOptions options = BaseOptions();
    options.baseUrl = 'https://hacker-news.firebaseio.com/';
    dio = Dio(options);
    getPostID();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
