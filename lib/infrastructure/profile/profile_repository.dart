// ignore_for_file: implementation_imports

import 'package:bloctesting/domain/core/failure_network.dart';
import 'package:bloctesting/domain/core/i_network_service.dart';
import 'package:bloctesting/domain/profile/i_profile_repository.dart';
import 'package:bloctesting/infrastructure/db/db_helper.dart';
import 'package:bloctesting/infrastructure/profile/models/detail/detail_profile_model.dart';
import 'package:bloctesting/infrastructure/profile/models/post/post_model.dart';
import 'package:bloctesting/infrastructure/profile/models/profile_model.dart';
import 'package:fpdart/src/either.dart';
import 'package:fpdart/src/unit.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

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
  Future<Either<FailureNetwork, Unit>> addFriends({required String id}) async {
    try {
      await DBHelper().insertFriends(id: id);
      return right(unit);
    } catch (e) {
      return left(const FailureNetwork.failure());
    }
  }

  @override
  Future<Either<FailureNetwork, List<String>>> getAllFriendsDB() async {
    try {
      final data = await DBHelper().selectAllFriends();
      List<String> listFriends = [];
      for (int i = 0; i < data.length; i++) {
        listFriends.add(data[i]['friend_id']);
      }
      return right(listFriends);
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

  @override
  Future<Either<FailureNetwork, Unit>> addPostLiked({
    required PostDetailModel post,
  }) async {
    try {
      final owner = await DBHelper().insertOwner(owner: post.owner);
      final tag = await DBHelper().insertTag(tags: post.tags);
      await DBHelper().insertPost(post: post, tagId: tag, ownerId: owner);
      return right(unit);
    } catch (e) {
      return left(const FailureNetwork.failure());
    }
  }

  @override
  Future<Either<FailureNetwork, List<PostDetailModel>>> getAllListPostDB() async {
    try {
      final data = await DBHelper().selectAllPosts();
      List<PostDetailModel> listPost = [];
      for (int i = 0; i < data.length; i++) {
        DateTime tempDate =
            DateFormat("yyyy-MM-dd hh:mm:ss").parse(data[i]['publishDate']);
        listPost.add(
          PostDetailModel(
            id: data[i]['pots_id'],
            image: data[i]['image'],
            likes: data[i]['likes'],
            tags: data[i]['tag_name'].split(','),
            text: data[i]['text'],
            publishDate: tempDate,
            owner: Owner(
              id: data[i]['owner_id'],
              title: data[i]['title'],
              firstName: data[i]['firstname'],
              lastName: data[i]['lastname'],
              picture: data[i]['picture'],
            ),
          ),
        );
      }
      return right(listPost);
    } catch (e) {
      return left(const FailureNetwork.failure());
    }
  }
}
