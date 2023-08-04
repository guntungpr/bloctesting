import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
class ProfileModel with _$ProfileModel {
  const factory ProfileModel({
    required List<ProfileDetail> data,
    required int total,
    required int page,
    required int limit,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
}

@freezed
class ProfileDetail with _$ProfileDetail {
  const factory ProfileDetail({
    required String id,
    required String title,
    required String firstName,
    required String lastName,
    required String picture,
  }) = _ProfileDetail;

  factory ProfileDetail.fromJson(Map<String, dynamic> json) =>
      _$ProfileDetailFromJson(json);
}
