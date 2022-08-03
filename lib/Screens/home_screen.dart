import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackernews_read_app/Widgets/post_card.dart';

import '../Models/post_model.dart';
import '../bloc/data_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('HackerNews'),
          backgroundColor: Colors.orange,
        ),
        body: BlocBuilder<DataBloc, DataState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetPostState) {
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  PostModel post = state.posts[index];
                  return PostCard(
                      url: post.url ?? 'No Url',
                      writer: post.by ?? 'No Writer',
                      title: post.title ?? 'No Title');
                },
              );
            }

            return const Center(
              child: Text('No avaible Posts'),
            );
          },
        ));
  }
}
