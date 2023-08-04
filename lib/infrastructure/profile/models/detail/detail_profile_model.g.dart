// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DetailProfileModel _$$_DetailProfileModelFromJson(
        Map<String, dynamic> json) =>
    _$_DetailProfileModel(
      id: json['id'] as String,
      title: json['title'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      picture: json['picture'] as String,
      gender: json['gender'] as String,
      email: json['email'] as String,
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      phone: json['phone'] as String,
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      registerDate: DateTime.parse(json['registerDate'] as String),
      updatedDate: DateTime.parse(json['updatedDate'] as String),
    );

Map<String, dynamic> _$$_DetailProfileModelToJson(
        _$_DetailProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'picture': instance.picture,
      'gender': instance.gender,
      'email': instance.email,
      'dateOfBirth': instance.dateOfBirth.toIso8601String(),
      'phone': instance.phone,
      'location': instance.location,
      'registerDate': instance.registerDate.toIso8601String(),
      'updatedDate': instance.updatedDate.toIso8601String(),
    };

_$_Location _$$_LocationFromJson(Map<String, dynamic> json) => _$_Location(
      street: json['street'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      country: json['country'] as String,
      timezone: json['timezone'] as String,
    );

Map<String, dynamic> _$$_LocationToJson(_$_Location instance) =>
    <String, dynamic>{
      'street': instance.street,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'timezone': instance.timezone,
    };
