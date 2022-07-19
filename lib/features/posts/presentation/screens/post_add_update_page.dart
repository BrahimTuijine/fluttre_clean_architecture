import 'package:clean_architecture/core/widgets/loading_widget.dart';
import 'package:clean_architecture/core/widgets/snack_bar_widget.dart';
import 'package:clean_architecture/features/posts/domain/entities/post_entitie.dart';
import 'package:clean_architecture/features/posts/presentation/bloc/CUD%20posts/delete_add_update_posts_bloc.dart';
import 'package:clean_architecture/features/posts/presentation/screens/posts_page.dart';
import 'package:clean_architecture/features/posts/presentation/widgets/add_update_posts.dart/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostAddUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;
  const PostAddUpdatePage({Key? key, required this.isUpdatePost, this.post})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdatePost ? "Edit post " : "Add poxt"),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child:
            BlocConsumer<DeleteAddUpdatePostsBloc, DeleteAddUpdatePostsState>(
          listener: (context, state) {
            if (state is MessageUpdateDeleteAddState) {
              SnackBarWidget.call(
                backgroundColor: Colors.green,
                context: context,
                message: state.message,
              );
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const PostsPage()),
                  (route) => false);
            } else if (state is ErrorState) {
              SnackBarWidget.call(
                backgroundColor: Colors.red,
                context: context,
                message: state.message,
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingState) {
              return const LoadingWidget();
            }
            return FormWidget(
              isUpdatePost: isUpdatePost,
              post: isUpdatePost ? post : null,
            );
          },
        ),
      )),
    );
  }
}
