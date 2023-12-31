part of 'profile_bloc.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.started() = _Started;
  const factory ProfileEvent.getListProfile() = _GetListProfile;
  const factory ProfileEvent.addLimit() = _AddLimit;
  const factory ProfileEvent.getDetailProfile({required String id}) = _GetDetailProfile;
  const factory ProfileEvent.addFriendChanged({required String id}) = _AddFriendChanged;
  const factory ProfileEvent.getAllFriends() = _GetAllFriends;
}
