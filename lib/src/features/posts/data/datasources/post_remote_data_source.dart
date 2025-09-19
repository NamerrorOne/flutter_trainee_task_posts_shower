import 'package:dio/dio.dart';
import "../models/post_dto.dart";

abstract interface class IPostRemoteDataSource {
  Future<List<PostDto>> getPosts();
}

class PostRemoteDataSourceImpl implements IPostRemoteDataSource {
  final Dio dio;

  PostRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<PostDto>> getPosts() async {
    try {
      final response = await dio.get("https://dummyjson.com/posts");
      final posts = (response.data['posts'] as List)
          .map((postJson) => PostDto.fromJson(postJson))
          .toList();
      return posts;
    } on DioException catch (e) {
      throw Exception('Failed to load posts: $e');
    }
  }
}
