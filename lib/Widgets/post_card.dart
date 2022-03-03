import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  PostCard(
      {Key? key, required this.url, required this.writer, required this.title})
      : super(key: key);

  String title;
  String url;
  String writer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1,
      child: Row(
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title : $title',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text('By : $writer'),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  url,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
