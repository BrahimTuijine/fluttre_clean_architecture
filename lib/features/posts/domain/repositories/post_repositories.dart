import 'package:clean_architecture/core/errors/failure.dart';
import 'package:clean_architecture/features/posts/domain/entities/post_entitie.dart';
import 'package:dartz/dartz.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getAllPosts();
  Future<Either<Failure, Unit >> deletePost(int id);
  Future<Either<Failure, Unit>> updatePost(Post post);
  Future<Either<Failure,  Unit >> addPost(Post post);
}
