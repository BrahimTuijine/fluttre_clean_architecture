import 'dart:convert';

import 'package:clean_architecture/core/constants/app_const.dart';
import 'package:clean_architecture/core/errors/exceptions.dart';
import 'package:clean_architecture/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> delatePost(int id);
  Future<Unit> updatePost(PostModel post);
  Future<Unit> addPost(PostModel post);
}

class PostRemoteDataSourceImp implements PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImp({required this.client});

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(Uri.parse("${AppConst.baseUrl}/posts"),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      final List decodedJson = json.decode(response.body);
      final List<PostModel> postModel = decodedJson
          .map<PostModel>((post) => PostModel.fromJson(post))
          .toList();
      return postModel;
    }
  }

  @override
  Future<Unit> addPost(PostModel post) async {
    final Map<String, String> body = {"title": post.title, "body": post.body};

    final response = await client.post(Uri.parse("${AppConst.baseUrl}/posts"),
        headers: {'Content-Type': "application/json"}, body: body);
    return checkServer(response);
  }

  @override
  Future<Unit> delatePost(int id) async {
    final response =
        await client.delete(Uri.parse("${AppConst.baseUrl}/posts/$id"));
    return checkServer(response);
  }

  @override
  Future<Unit> updatePost(PostModel post) async {
    final String postId = post.id.toString();
    Map<String, String> body = {"title": post.title, "body": post.body};

    final response =
        await client.patch(Uri.parse("${AppConst.baseUrl}/posts/$postId") , body: body);

    return checkServer(response);
  }

  Future<Unit> checkServer(response) {
    final List<int> codeList = [200, 201];
    if (codeList.contains(response.statusCode)) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
