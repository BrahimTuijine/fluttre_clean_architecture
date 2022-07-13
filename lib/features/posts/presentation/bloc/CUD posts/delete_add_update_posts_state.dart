part of 'delete_add_update_posts_bloc.dart';

abstract class DeleteAddUpdatePostsState extends Equatable {
  const DeleteAddUpdatePostsState();

  @override
  List<Object> get props => [];
}

class DeleteAddUpdatePostsInitial extends DeleteAddUpdatePostsState {}

class LoadingState extends DeleteAddUpdatePostsState {}

class ErrorState extends DeleteAddUpdatePostsState {
  final String message;

  const ErrorState({required this.message});

  @override
  List<Object> get props => [];
}

class MessageUpdateDeleteAddState extends DeleteAddUpdatePostsState {
  final String message;

  const MessageUpdateDeleteAddState({required this.message});

  @override
  List<Object> get props => [];
}
