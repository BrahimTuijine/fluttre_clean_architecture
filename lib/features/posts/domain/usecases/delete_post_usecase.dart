import 'package:clean_architecture/core/errors/failure.dart';
import 'package:clean_architecture/features/posts/domain/repositories/post_repositories.dart';
import 'package:dartz/dartz.dart';

class DeletePostUseCase {
  PostRepository repository;

  DeletePostUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(int postID) async {
    return await repository.deletePost(postID);
  }
}
