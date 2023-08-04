import 'package:bloc/bloc.dart';
import 'package:bloctesting/domain/core/failure_network.dart';
import 'package:bloctesting/domain/profile/i_profile_repository.dart';
import 'package:bloctesting/infrastructure/profile/models/post/post_model.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'post_event.dart';
part 'post_state.dart';
part 'post_bloc.freezed.dart';

@injectable
class PostBloc extends Bloc<PostEvent, PostState> {
  final IProfileRepository iProfileRepository;
  PostBloc(this.iProfileRepository) : super(PostState.initial()) {
    on<PostEvent>((event, emit) async {
      await event.map(
        started: (e) {
          emit(PostState.initial());
        },
        getAllListPost: (e) async {
          emit(state.copyWith(isLoading: true));
          final failureOrSuccess = await iProfileRepository.getAllListPost(
            page: state.page,
          );
          emit(state.copyWith(
            isLoading: false,
            optionFailedOrPost: optionOf(failureOrSuccess),
            page: failureOrSuccess.match((l) => 0, (r) => r.limit),
            listPost: state.listPost.addAll(failureOrSuccess.match(
              (l) => <PostDetailModel>[].toIList(),
              (r) => r.data.toIList(),
            )),
          ));
        },
        getListPost: (e) async {
          emit(state.copyWith(isLoading: true));
          final failureOrSuccess = await iProfileRepository.getListPost(
            id: e.id,
            page: state.page,
          );
          emit(state.copyWith(
            isLoading: false,
            optionFailedOrPost: optionOf(failureOrSuccess),
            page: failureOrSuccess.match((l) => 0, (r) => r.data.length),
            listPost: state.listPost.addAll(failureOrSuccess.match(
              (l) => <PostDetailModel>[].toIList(),
              (r) => r.data.toIList(),
            )),
          ));
        },
        addLimit: (e) {
          emit(state.copyWith(page: state.page + 1));
        },
        searchData: (e) {
          emit(state.copyWith(listPostTemp: <PostDetailModel>[].toIList()));
          IList<PostDetailModel> tempData = <PostDetailModel>[].toIList();
          if (e.keyword.isNotEmpty) {
            // ignore: avoid_function_literals_in_foreach_calls
            state.listPost.forEach((item) {
              if (item.text.toLowerCase().contains(e.keyword)) {
                tempData = tempData.add(item);
              }
            });
            emit(state.copyWith(listPostTemp: tempData));
          } else {
            emit(state.copyWith(listPostTemp: <PostDetailModel>[].toIList()));
          }
        },
        likeChanged: (e) {
          emit(state.copyWith(page: state.page + 20));
        },
        addFriendChanged: (e) {
          emit(state.copyWith(page: state.page + 20));
        },
        tagSelected: (e) {
          if (state.tags.contains(e.tag)) {
            emit(state.copyWith(tags: state.tags.remove(e.tag)));
          } else {
            emit(state.copyWith(tags: state.tags.add(e.tag)));
          }
          emit(state.copyWith(listPostTemp: <PostDetailModel>[].toIList()));
          IList<PostDetailModel> tempData = <PostDetailModel>[].toIList();
          if (state.tags.isNotEmpty) {
            // ignore: avoid_function_literals_in_foreach_calls
            state.listPost.forEach((item) {
              if (item.tags
                  .where((element) => state.tags.contains(element))
                  .toList()
                  .isNotEmpty) {
                tempData = tempData.add(item);
              }
            });
            emit(state.copyWith(listPostTemp: tempData));
          } else {
            emit(state.copyWith(listPostTemp: <PostDetailModel>[].toIList()));
          }
        },
      );
    });
  }
}
