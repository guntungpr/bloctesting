import 'package:bloctesting/application/post/post_bloc.dart';
import 'package:bloctesting/presentation/core/shimmer/custom_shimmer_post_list.dart';
import 'package:bloctesting/presentation/profile/detail/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final blocPost = context.read<PostBloc>();
    blocPost
      ..add(const PostEvent.started())
      ..add(const PostEvent.getAllListPost());
    final controller = ScrollController();
    final key = PageStorageKey(blocPost.state.listPostTemp.isNotEmpty
        ? blocPost.state.listPostTemp.length
        : blocPost.state.listPost.length);

    Future refreshData() async {
      blocPost.add(const PostEvent.started());
      blocPost.add(const PostEvent.getAllListPost());
    }

    Future loadMore() async {
      blocPost.add(const PostEvent.addLimit());
      blocPost.add(const PostEvent.getAllListPost());
    }

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        loadMore();
      }
    });
    return Padding(
      padding: const EdgeInsets.all(20),
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          return state.isLoading
              ? const CustomShimmerPostList()
              : state.optionFailedOrPost.match(
                  () => const SizedBox(),
                  (t) => t.match(
                    (l) => const SizedBox(),
                    (r) => Column(
                      children: [
                        SizedBox(
                          height: 40,
                          child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    color: Colors.blue,
                                    child: Text(
                                      state.tags[index],
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.blueGrey,
                                    ),
                                    onPressed: () => blocPost.add(
                                        PostEvent.tagSelected(tag: state.tags[index])),
                                  ),
                                ),
                              ],
                            ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 10),
                            itemCount: state.tags.length,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: ListView.separated(
                            key: key,
                            controller: controller,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 20),
                            itemBuilder: (context, index) => PostWidget(
                                post: state.listPostTemp.isNotEmpty
                                    ? state.listPostTemp[index]
                                    : state.listPost[index]),
                            itemCount: state.listPostTemp.isNotEmpty
                                ? state.listPostTemp.length
                                : state.listPost.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
