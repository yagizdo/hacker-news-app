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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
