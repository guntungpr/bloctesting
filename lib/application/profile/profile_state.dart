part of 'profile_bloc.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    required bool isLoading,
    required int page,
    required Option<Either<FailureNetwork, ProfileModel>> optionFailedOrProfile,
    required Option<Either<FailureNetwork, DetailProfileModel>>
        optionFailedOrDetailProfile,
    required IList<ProfileDetail> listProfile,
  }) = _ProfileState;

  factory ProfileState.initial() => ProfileState(
        isLoading: false,
        page: 0,
        optionFailedOrProfile: none(),
        optionFailedOrDetailProfile: none(),
        listProfile: <ProfileDetail>[].toIList(),
      );
}
