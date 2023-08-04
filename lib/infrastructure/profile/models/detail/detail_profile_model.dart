import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_profile_model.freezed.dart';
part 'detail_profile_model.g.dart';

@freezed
class DetailProfileModel with _$DetailProfileModel {
  const factory DetailProfileModel({
    required String id,
    required String title,
    required String firstName,
    required String lastName,
    required String picture,
    required String gender,
    required String email,
    required DateTime dateOfBirth,
    required String phone,
    required Location location,
    required DateTime registerDate,
    required DateTime updatedDate,
  }) = _DetailProfileModel;

  factory DetailProfileModel.fromJson(Map<String, dynamic> json) =>
      _$DetailProfileModelFromJson(json);
}

@freezed
class Location with _$Location {
  const factory Location({
    required String street,
    required String city,
    required String state,
    required String country,
    required String timezone,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
}
