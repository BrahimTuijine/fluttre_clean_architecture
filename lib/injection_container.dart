import 'package:clean_architecture/core/network/network_info.dart';
import 'package:clean_architecture/features/posts/data/datasources/post_local_data_source.dart';
import 'package:clean_architecture/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:clean_architecture/features/posts/data/repositories/post_repository_impl.dart';
import 'package:clean_architecture/features/posts/domain/repositories/post_repositories.dart';
import 'package:clean_architecture/features/posts/domain/usecases/add_post.dart';
import 'package:clean_architecture/features/posts/domain/usecases/delete_post_usecase.dart';
import 'package:clean_architecture/features/posts/domain/usecases/get_all_posts_usecases.dart';
import 'package:clean_architecture/features/posts/domain/usecases/update_post.dart';
import 'package:clean_architecture/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/posts/presentation/bloc/CUD posts/delete_add_update_posts_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Feauture posts

  //Bloc

  sl.registerFactory(() => PostsBloc(getAllPostsUseCases: sl()));
  sl.registerFactory(
    () => DeleteAddUpdatePostsBloc(
        addPostUseCase: sl(), deletePostUseCase: sl(), updatePostUseCase: sl()),
  );

  //Usecases

  sl.registerLazySingleton(() => AddPostUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetAllPostsUseCases(repository: sl()));

  //Repository

  sl.registerLazySingleton<PostRepository>(() => PostsRepositoryImp(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  //Datasourece

  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImp(client: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImp(sharedPreferences: sl()));

  //! Core

  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));

  //! External

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
