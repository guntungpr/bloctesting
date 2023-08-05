import 'package:bloctesting/application/post/post_bloc.dart';
import 'package:bloctesting/presentation/core/shimmer/custom_shimmer_post_list.dart';
import 'package:bloctesting/presentation/profile/detail/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LikePage extends StatelessWidget {
  const LikePage({super.key});

  @override
  Widget build(BuildContext context) {
    final blocPost = context.read<PostBloc>();
    blocPost.add(const PostEvent.getAllListPostSQLite());
    Future refreshData() async {
      blocPost.add(const PostEvent.started());
      blocPost.add(const PostEvent.getAllListPostSQLite());
    }

    return RefreshIndicator(
      onRefresh: refreshData,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            return state.isLoading
                ? const CustomShimmerPostList()
                : state.listPostDb.isEmpty
                    ? const Center(child: Text('No Data'))
                    : Padding(
                        padding: const EdgeInsets.all(20),
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 20),
                          itemBuilder: (context, index) => PostWidget(
                            post: state.listPostDb[index],
                            isLikedPost:
                                state.listLikedPost.contains(state.listPostDb[index].id),
                          ),
                          itemCount: state.listPostDb.length,
                        ),
                      );
          },
        ),
      ),
    );
  }
}
