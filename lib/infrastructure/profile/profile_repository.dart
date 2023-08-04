// ignore_for_file: implementation_imports

import 'package:bloctesting/domain/core/failure_network.dart';
import 'package:bloctesting/domain/core/i_network_service.dart';
import 'package:bloctesting/domain/profile/i_profile_repository.dart';
import 'package:bloctesting/infrastructure/profile/models/detail/detail_profile_model.dart';
import 'package:bloctesting/infrastructure/profile/models/post/post_model.dart';
import 'package:bloctesting/infrastructure/profile/models/profile_model.dart';
import 'package:fpdart/src/either.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IProfileRepository)
class ProfileRepository implements IProfileRepository {
  ProfileRepository(this._network);
  final INetworkService _network;

  @override
  Future<Either<FailureNetwork, ProfileModel>> getListProfile({
    required int page,
  }) async {
    try {
      final response = await _network.dioResponse(
        isGet: true,
        path: 'user?page=$page',
        parameter: {},
      );
      final data = ProfileModel.fromJson(response.data);
      return right(data);
    } catch (e) {
      return left(const FailureNetwork.failure());
    }
  }

  @override
  Future<Either<FailureNetwork, DetailProfileModel>> getDetailProfile({
    required String id,
  }) async {
    try {
      final response = await _network.dioResponse(
        isGet: true,
        path: 'user/$id',
        parameter: {},
      );
      final data = DetailProfileModel.fromJson(response.data);
      return right(data);
    } catch (e) {
      return left(const FailureNetwork.failure());
    }
  }

  @override
  Future<Either<FailureNetwork, PostModel>> getListPost({
    required String id,
    required int page,
  }) async {
    try {
      final response = await _network.dioResponse(
        isGet: true,
        path: 'user/$id/post?limit=$page',
        parameter: {},
      );
      final data = PostModel.fromJson(response.data);
      return right(data);
    } catch (e) {
      return left(const FailureNetwork.failure());
    }
  }

  @override
  Future<Either<FailureNetwork, PostModel>> getAllListPost({required int page}) async {
    try {
      final response = await _network.dioResponse(
        isGet: true,
        path: 'post?page$page',
        parameter: {},
      );
      final data = PostModel.fromJson(response.data);
      return right(data);
    } catch (e) {
      return left(const FailureNetwork.failure());
    }
  }
}
