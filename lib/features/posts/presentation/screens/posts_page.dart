import 'package:clean_architecture/core/widgets/loading_widget.dart';
import 'package:clean_architecture/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:clean_architecture/features/posts/presentation/widgets/message_display_widget.dart';
import 'package:clean_architecture/features/posts/presentation/widgets/posts_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text('PostsPage'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocBuilder<PostsBloc, PostsState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return const LoadingWidget();
              } else if (state is LoadedPostState) {
                return RefreshIndicator(
                    onRefresh: () async {
                      BlocProvider.of<PostsBloc>(context)
                          .add(RefreshPostEvent());
                    },
                    child: PostsListWidget(posts: state.posts));
              } else if (state is ErrorPostsState) {
                return MessageDisplayWidget(message: state.message);
              }
              return const LoadingWidget();
            },
          ),
        ));
  }
}
