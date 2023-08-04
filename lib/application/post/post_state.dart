part of 'post_bloc.dart';

@freezed
class PostState with _$PostState {
  const factory PostState({
    required bool isLoading,
    required int page,
    required Option<Either<FailureNetwork, PostModel>> optionFailedOrPost,
    required IList<PostDetailModel> listPost,
    required IList<PostDetailModel> listPostTemp,
    required IList<String> tags,
  }) = _PostState;

  factory PostState.initial() => PostState(
        isLoading: false,
        page: 0,
        optionFailedOrPost: none(),
        listPost: <PostDetailModel>[].toIList(),
        listPostTemp: <PostDetailModel>[].toIList(),
        tags: <String>[].toIList(),
      );
}
