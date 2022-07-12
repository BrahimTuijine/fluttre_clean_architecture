import 'dart:convert';

import 'package:clean_architecture/core/errors/exceptions.dart';
import 'package:clean_architecture/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePosts(List<PostModel> postModels);
}

class PostLocalDataSourceImp implements PostLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostLocalDataSourceImp({required this.sharedPreferences});

  @override
  Future<Unit> cachePosts(List<PostModel> postModels) {
    List postModelToJson = postModels
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();
    sharedPreferences.setString("CACHED_POSTS", json.encode(postModelToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = sharedPreferences.getString("CACHED_POSTS");
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<PostModel> cachedList = decodeJsonData
          .map<PostModel>((post) => PostModel.fromJson(post))
          .toList();
      return Future.value(cachedList);
    } else {
      throw EmptyCacheException;
    }
  }
}
