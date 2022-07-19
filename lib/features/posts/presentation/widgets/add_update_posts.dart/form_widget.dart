import 'package:clean_architecture/features/posts/domain/entities/post_entitie.dart';
import 'package:clean_architecture/features/posts/presentation/bloc/CUD%20posts/delete_add_update_posts_bloc.dart';
import 'package:clean_architecture/features/posts/presentation/widgets/add_update_posts.dart/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdatePost;
  final Post? post;
  const FormWidget({Key? key, required this.isUpdatePost, this.post})
      : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _bodyEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isUpdatePost) {
      _titleEditingController.text = widget.post!.title;
      _bodyEditingController.text = widget.post!.body;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _bodyEditingController.dispose();
    _titleEditingController.dispose();
  }

  void validFormThenUpdateOrAddPost() {
    final isValid = _formKey.currentState!.validate();
    final post = Post(
        id: widget.isUpdatePost ? widget.post!.id : null,
        title: _titleEditingController.text,
        body: _bodyEditingController.text);
    if (isValid) {
      if (widget.isUpdatePost) {
        BlocProvider.of<DeleteAddUpdatePostsBloc>(context)
            .add(UpdatePostsEvent(post: post));
      } else {
        BlocProvider.of<DeleteAddUpdatePostsBloc>(context)
            .add(AddPostsEvent(post: post));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MyTextForm(
                myController: _titleEditingController,
                hint: "title",
                valTitle: "Title can't be empty",
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextForm(
                minline: 6,
                maxline: 6,
                myController: _bodyEditingController,
                hint: "body",
                valTitle: "body can't be empty",
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                onPressed: validFormThenUpdateOrAddPost,
                icon: Icon(widget.isUpdatePost ? Icons.edit : Icons.add),
                label: widget.isUpdatePost
                    ? const Text('Update')
                    : const Text('Add'),
              ),
            ],
          ),
        ));
  }
}
