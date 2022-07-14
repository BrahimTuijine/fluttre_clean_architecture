import 'package:clean_architecture/core/errors/failure.dart';
import 'package:clean_architecture/features/posts/domain/entities/post_entitie.dart';
import 'package:clean_architecture/features/posts/domain/repositories/post_repositories.dart';
import 'package:dartz/dartz.dart';

class GetAllPostsUseCases {
  final PostRepository repository;

  GetAllPostsUseCases({required this.repository});

  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getAllPosts();
  }
}
