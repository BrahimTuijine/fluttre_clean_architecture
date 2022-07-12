import 'package:clean_architecture/core/errors/failure.dart';
import 'package:clean_architecture/features/posts/domain/entities/post_entitie.dart';
import 'package:clean_architecture/features/posts/domain/repositories/post_repositories.dart';
import 'package:dartz/dartz.dart';

class AddPostUseCase {
  PostRepository repository;

  AddPostUseCase(this.repository);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.addPost(post);
  }
}
