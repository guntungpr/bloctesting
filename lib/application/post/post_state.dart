part of 'post_bloc.dart';

@freezed
class PostState with _$PostState {
  const factory PostState({
    required bool isLoading,
    required int page,
    required Option<Either<FailureNetwork, PostModel>> optionFailedOrPost,
    required IList<PostDetailModel> listPost,
    required IList<PostDetailModel> listPostTemp,
    required IList<PostDetailModel> listPostDb,
    required IList<String> tags,
    required IList<String> listLikedPost,
  }) = _PostState;

  factory PostState.initial() => PostState(
        isLoading: false,
        page: 0,
        optionFailedOrPost: none(),
        listPost: <PostDetailModel>[].toIList(),
        listPostTemp: <PostDetailModel>[].toIList(),
        listPostDb: <PostDetailModel>[].toIList(),
        tags: <String>[].toIList(),
        listLikedPost: <String>[].toIList(),
      );
}
