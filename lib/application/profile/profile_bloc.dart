import 'package:bloc/bloc.dart';
import 'package:bloctesting/domain/core/failure_network.dart';
import 'package:bloctesting/domain/profile/i_profile_repository.dart';
import 'package:bloctesting/infrastructure/profile/models/detail/detail_profile_model.dart';
import 'package:bloctesting/infrastructure/profile/models/profile_model.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'profile_event.dart';
part 'profile_state.dart';
part 'profile_bloc.freezed.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final IProfileRepository iProfileRepository;
  ProfileBloc(this.iProfileRepository) : super(ProfileState.initial()) {
    on<ProfileEvent>((event, emit) async {
      await event.map(
        started: (e) {
          emit(ProfileState.initial());
        },
        getListProfile: (e) async {
          emit(state.copyWith(isLoading: true));
          final failureOrSuccess = await iProfileRepository.getListProfile(
            page: state.page,
          );
          emit(state.copyWith(
            isLoading: false,
            optionFailedOrProfile: optionOf(failureOrSuccess),
            page: failureOrSuccess.match((l) => 0, (r) => r.page),
            listProfile: state.listProfile
                .addAll(failureOrSuccess.match((l) => [], (r) => r.data)),
          ));
        },
        addLimit: (e) {
          emit(state.copyWith(page: state.page + 1));
        },
        getDetailProfile: (e) async {
          emit(state.copyWith(isLoading: true));
          final failureOrSuccess = await iProfileRepository.getDetailProfile(id: e.id);
          emit(state.copyWith(
            isLoading: false,
            optionFailedOrDetailProfile: optionOf(failureOrSuccess),
          ));
          emit(state.copyWith(optionFailedOrDetailProfile: none()));
        },
        addFriendChanged: (e) async {
          if (state.listFriends.contains(e.id)) {
            emit(state.copyWith(listFriends: state.listFriends.remove(e.id)));
          } else {
            emit(state.copyWith(listFriends: state.listFriends.add(e.id)));
          }
          await iProfileRepository.addFriends(id: e.id);
        },
        getAllFriends: (e) async {
          emit(state.copyWith(isLoading: true));
          final failureOrSuccess = await iProfileRepository.getAllFriendsDB();
          List<String> friends = [];
          failureOrSuccess.match(
            (l) => [],
            (r) {
              for (int i = 0; i < r.length; i++) {
                friends.add(r[i]);
              }
              return friends;
            },
          );
          emit(state.copyWith(
            isLoading: false,
            listFriends: state.listFriends.addAll(friends).toIList(),
          ));
        },
      );
    });
  }
}
