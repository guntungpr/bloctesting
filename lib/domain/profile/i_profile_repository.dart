import 'package:bloctesting/domain/core/failure_network.dart';
import 'package:bloctesting/infrastructure/profile/models/detail/detail_profile_model.dart';
import 'package:bloctesting/infrastructure/profile/models/post/post_model.dart';
import 'package:bloctesting/infrastructure/profile/models/profile_model.dart';
import 'package:fpdart/fpdart.dart';

abstract class IProfileRepository {
  Future<Either<FailureNetwork, ProfileModel>> getListProfile({required int page});
  Future<Either<FailureNetwork, DetailProfileModel>> getDetailProfile({
    required String id,
  });
  Future<Either<FailureNetwork, PostModel>> getListPost({
    required String id,
    required int page,
  });
  Future<Either<FailureNetwork, PostModel>> getAllListPost({
    required int page,
  });
}
