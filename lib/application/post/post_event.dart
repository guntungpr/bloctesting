part of 'post_bloc.dart';

@freezed
class PostEvent with _$PostEvent {
  const factory PostEvent.started() = _Started;
  const factory PostEvent.getAllListPost() = _GetAllListPost;
  const factory PostEvent.getAllListPostSQLite() = _GetAllListPostSQLite;
  const factory PostEvent.getListPost({required String id}) = _GetListPost;
  const factory PostEvent.addLimit() = _AddLimit;
  const factory PostEvent.searchData({required String keyword}) = _SearchData;
  const factory PostEvent.likeChanged({required PostDetailModel post}) = _LikeChanged;
  const factory PostEvent.tagSelected({required String tag}) = _TagSelected;
}
