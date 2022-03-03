import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../Widgets/post_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Dio? dio;

  late List posts;
  var postIDList = <int>[];

  bool loading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    BaseOptions options = BaseOptions();
    options.baseUrl = 'https://hacker-news.firebaseio.com/';
    dio = Dio(options);
    initializePosts();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('new data call');
        debugPrint('Test : ${posts.sublist(5, 10)}');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void initializePosts() async {
    setState(() {
      loading = true;
    });

    List postIDs = await getPostIDs();

    var postResponse = await Stream.fromIterable(postIDs)
        .take(30)
        .asyncMap((id) => getPostById(id))
        .toList();

    posts = postResponse;

    setState(() {
      loading = false;
    });
  }

  // Get Post ID's
  Future getPostIDs() async {
    Response result = await dio!.get('v0/topstories.json');

    if (result.statusCode == 200) {
      return result.data;
    } else {
      print('Error : ${result.headers}');
    }

    return postIDList;
  }

  Future getPostById(int postID) async {
    setState(() {
      loading = true;
    });

    final response = await dio!.get('v0/item/$postID.json');

    if (response.statusCode == 200) {
      return response.data;
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HackerNews'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
          child: !loading
              ? ListView.separated(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(8),
                  itemCount: posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PostCard(
                      title: posts[index]['title'],
                      url: posts[index]['url'] ?? 'No url',
                      writer: posts[index]['by'],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                    color: Colors.orange,
                  ),
                )
              : Container(
                  alignment: Alignment.center,
                  color: Colors.orange,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                  ))),
    );
  }
}
