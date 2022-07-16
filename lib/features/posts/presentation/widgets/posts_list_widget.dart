import 'package:clean_architecture/features/posts/domain/entities/post_entitie.dart';
import 'package:flutter/material.dart';

class PostsListWidget extends StatelessWidget {
  final List<Post> posts;
  const PostsListWidget({Key? key, required this.posts}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, int index) {
          return const Divider( thickness: 1,);
        },
        itemBuilder: (context, int index) {
          return ListTile(
            onTap: () {},
            isThreeLine: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            leading: Text(posts[index].id.toString()),
            title: Text(
              posts[index].title.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: Text(posts[index].body.toString()),
          );
        },
        itemCount: posts.length);
  }
}
