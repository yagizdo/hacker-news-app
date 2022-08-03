import 'package:flutter/material.dart';

import '../Widgets/post_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List posts;
  late List listed_posts;

  int start = 0;
  int end = 10;

  bool loading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    initializePosts();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('new data call');
        print('end : $end');
        addNewDatas();
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
        .asyncMap((id) => getPostById(id))
        .toList();
    posts = postResponse;
    listed_posts = posts.sublist(start, end);

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
                  itemCount: listed_posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PostCard(
                      title: listed_posts[index]['title'],
                      url: listed_posts[index]['url'] ?? 'No url',
                      writer: listed_posts[index]['by'],
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
