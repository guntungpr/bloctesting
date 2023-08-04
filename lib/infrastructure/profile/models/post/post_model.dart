import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

@freezed
class PostModel with _$PostModel {
  const factory PostModel({
    required List<PostDetailModel> data,
    required int total,
    required int page,
    required int limit,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);
}

@freezed
class PostDetailModel with _$PostDetailModel {
  const factory PostDetailModel({
    required String id,
    required String image,
    required int likes,
    required List<String> tags,
    required String text,
    required DateTime publishDate,
    required Owner owner,
  }) = _PostDetailModel;

  factory PostDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PostDetailModelFromJson(json);
}

@freezed
class Owner with _$Owner {
  const factory Owner({
    required String id,
    required String title,
    required String firstName,
    required String lastName,
    required String picture,
  }) = _Owner;

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);
}
