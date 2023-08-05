import 'package:bloctesting/application/post/post_bloc.dart';
import 'package:bloctesting/application/profile/profile_bloc.dart';
import 'package:bloctesting/infrastructure/profile/models/detail/detail_profile_model.dart';
import 'package:bloctesting/presentation/core/shimmer/custom_shimmer_post_list.dart';
import 'package:bloctesting/presentation/core/utils/common_utils.dart';
import 'package:bloctesting/presentation/profile/detail/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailProfilePage extends StatelessWidget {
  const DetailProfilePage({super.key, required this.detail});
  final DetailProfileModel detail;

  @override
  Widget build(BuildContext context) {
    final TextEditingController text = TextEditingController();
    final blocPost = context.read<PostBloc>();
    final controller = ScrollController();
    final key = PageStorageKey(blocPost.state.listPostTemp.isNotEmpty
        ? blocPost.state.listPostTemp.length
        : blocPost.state.listPost);
    blocPost
      ..add(const PostEvent.started())
      ..add(PostEvent.getListPost(id: detail.id))
      ..add(const PostEvent.getAllListPostSQLite());

    Future refreshData() async {
      blocPost.add(const PostEvent.started());
      blocPost.add(PostEvent.getListPost(id: detail.id));
    }

    Future loadMore() async {
      blocPost.add(const PostEvent.addLimit());
      blocPost.add(PostEvent.getListPost(id: detail.id));
    }

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        loadMore();
      }
    });

    return RefreshIndicator(
      onRefresh: () => refreshData(),
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: TextField(
                controller: text,
                onSubmitted: (value) =>
                    blocPost.add(PostEvent.searchData(keyword: text.text)),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      text.clear();
                      blocPost.add(const PostEvent.searchData(keyword: ''));
                    },
                  ),
                  hintText: 'Search... in ${detail.firstName}`s post',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, stateProfile) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width / 10),
                        IconButton(
                            onPressed: () => context
                                .read<ProfileBloc>()
                                .add(ProfileEvent.addFriendChanged(id: detail.id)),
                            icon: Icon(
                              context
                                      .read<ProfileBloc>()
                                      .state
                                      .listFriends
                                      .contains(detail.id)
                                  ? Icons.person_remove
                                  : Icons.person_add_outlined,
                              size: 50,
                              color: context
                                      .read<ProfileBloc>()
                                      .state
                                      .listFriends
                                      .contains(detail.id)
                                  ? Colors.green
                                  : Colors.blue,
                            )),
                        const SizedBox(width: 20),
                        Column(
                          children: [
                            Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(detail.picture),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              '${detail.firstName} ${detail.lastName}',
                              style: const TextStyle(fontSize: 25, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text(
                          'Gender : ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(detail.gender)
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text(
                          'Date Of Birth : ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(CommonUtils.dateFormat('dd-MMM-yyyy', detail.dateOfBirth))
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text(
                          'Join From : ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(CommonUtils.dateFormat('dd-MMM-yyyy', detail.registerDate))
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text(
                          'Email : ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(detail.email)
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Address : ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Text(
                              '${detail.location.street}, ${detail.location.city}, ${detail.location.country}'),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Divider(thickness: 2),
                    const SizedBox(height: 20),
                    BlocConsumer<PostBloc, PostState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return state.isLoading
                            ? const CustomShimmerPostList()
                            : ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 20),
                                shrinkWrap: true,
                                controller: controller,
                                key: key,
                                itemBuilder: (context, index) => PostWidget(
                                  post: state.listPostTemp.isNotEmpty
                                      ? state.listPostTemp[index]
                                      : state.listPost[index],
                                  isLikedPost: state.listLikedPost.contains(
                                    (state.listPostTemp.isNotEmpty
                                        ? state.listPostTemp[index].id
                                        : state.listPost[index].id),
                                  ),
                                ),
                                itemCount: state.listPostTemp.isNotEmpty
                                    ? state.listPostTemp.length
                                    : state.listPost.length,
                              );
                        // state.optionFailedOrPost.match(
                        //     () => const SizedBox(),
                        //     (t) => t.match(
                        //       (l) => const SizedBox(),
                        //       (r) => ListView.separated(
                        //         separatorBuilder: (context, index) =>
                        //             const SizedBox(height: 20),
                        //         shrinkWrap: true,
                        //         controller: controller,
                        //         key: key,
                        //         itemBuilder: (context, index) => PostWidget(
                        //           post: r.data[index],
                        //         ),
                        //         itemCount: state.limit,
                        //       ),
                        //     ),
                        //   );
                      },
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
