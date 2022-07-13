// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:clean_architecture/core/constants/app_const.dart';
import 'package:clean_architecture/core/errors/failure.dart';
import 'package:clean_architecture/features/posts/domain/entities/post_entitie.dart';
import 'package:clean_architecture/features/posts/domain/usecases/add_post.dart';
import 'package:clean_architecture/features/posts/domain/usecases/delete_post_usecase.dart';
import 'package:clean_architecture/features/posts/domain/usecases/update_post.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'delete_add_update_posts_event.dart';
part 'delete_add_update_posts_state.dart';

class DeleteAddUpdatePostsBloc
    extends Bloc<DeleteAddUpdatePostsEvent, DeleteAddUpdatePostsState> {
  final AddPostUseCase addPostUseCase;
  final DeletePostUseCase deletePostUseCase;
  final UpdatePostUseCase updatePostUseCase;

  DeleteAddUpdatePostsBloc(
      {required this.addPostUseCase,
      required this.deletePostUseCase,
      required this.updatePostUseCase})
      : super(DeleteAddUpdatePostsInitial()) {
    on<DeleteAddUpdatePostsEvent>((event, emit) async {
      if (event is AddPostsEvent) {
        emit(LoadingState());
        final response = await addPostUseCase(event.post);
        emit(_eitherDoneMessageOrErrorState(
            response, AppConst.addSuccessMessage));
      } else if (event is UpdatePostsEvent) {
        emit(LoadingState());
        final response = await updatePostUseCase(event.post);

        emit(_eitherDoneMessageOrErrorState(
            response, AppConst.updateSuccessMessage));
      } else if (event is DeletePostsEvent) {
        emit(LoadingState());
        final response = await deletePostUseCase(event.postId);

        emit(_eitherDoneMessageOrErrorState(
            response, AppConst.deleteSuccessMessage));
      }
    });
  }

  DeleteAddUpdatePostsState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
        (failure) => ErrorState(message: _mapFailureToMessage(failure)),
        (_) => MessageUpdateDeleteAddState(message: message));
  }

  String _mapFailureToMessage(failure) {
    switch (failure.runtimeType) {
      case OfflineFailure:
        return AppConst.offLineFailureMessage;
      case ServerFailure:
        return AppConst.serverFailureMessage;

      default:
        return "Unexpected error please try again later ";
    }
  }
}
