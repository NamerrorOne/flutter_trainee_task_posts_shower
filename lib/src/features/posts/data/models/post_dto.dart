import "package:json_annotation/json_annotation.dart";
import "package:trainee_task/src/features/posts/domain/models/post.dart";

part 'post_dto.g.dart';

@JsonSerializable()
class PostDto {
  final int userId;
  final int id;
  final String title;
  final String body;

  PostDto({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory PostDto.fromJson(Map<String, dynamic> json) =>
      _$PostDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PostDtoToJson(this);
}

extension PostDtoX on PostDto {
  Post toDomain() {
    return Post(id: id, title: title, body: body);
  }
}
