// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:clean_architecture/core/constants/app_const.dart';
import 'package:clean_architecture/core/errors/failure.dart';
import 'package:clean_architecture/features/posts/domain/entities/post_entitie.dart';
import 'package:clean_architecture/features/posts/domain/usecases/get_all_posts_usecases.dart';
import 'package:equatable/equatable.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCases getAllPostsUseCases;
  PostsBloc({required this.getAllPostsUseCases}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent || event is RefreshPostEvent) {
        emit(LoadingState());

        final posts = await getAllPostsUseCases(); 

        posts.fold((failure) {
          emit(ErrorPostsState(message: _mapFailureToMessage(failure)));
        }, (posts) {
          emit(LoadedPostState(posts: posts));
        });
      } else if (event is RefreshPostEvent) {}
    });
  }

  String _mapFailureToMessage(failure) {
    switch (failure.runtimeType) {
      case OfflineFailure:
        return AppConst.offLineFailureMessage;
      case EmptyCacheFailure:
        return AppConst.empltyCacheFailureMessage;
      case ServerFailure:
        return AppConst.serverFailureMessage;

      default:
        return "Unexpected error please try again later ";
    }
  }
}
