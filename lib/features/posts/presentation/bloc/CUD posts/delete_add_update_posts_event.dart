part of 'delete_add_update_posts_bloc.dart';

abstract class DeleteAddUpdatePostsEvent extends Equatable {
  const DeleteAddUpdatePostsEvent();

  @override
  List<Object> get props => [];
}

class AddPostsEvent extends DeleteAddUpdatePostsEvent {
  final Post post;

  const AddPostsEvent({required this.post});

  @override
  List<Object> get props => [post];
}

class UpdatePostsEvent extends DeleteAddUpdatePostsEvent {
  final Post post;

  const UpdatePostsEvent({required this.post});

  @override
  List<Object> get props => [post];
}

class DeletePostsEvent extends DeleteAddUpdatePostsEvent {
  final int postId;

  const DeletePostsEvent({required this.postId});

  @override
  List<Object> get props => [postId];
}
