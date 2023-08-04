// import 'package:bloctesting/application/post/post_bloc.dart';
// import 'package:bloctesting/presentation/core/shimmer/custom_shimmer_post_list.dart';
// import 'package:bloctesting/presentation/profile/detail/widgets/post_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class LikePage extends StatelessWidget {
//   const LikePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final blocPost = context.read<PostBloc>();
//     blocPost.add(PostEvent.getListPost(id: '60d0fe4f5311236168a109ca'));
//     return Padding(
//       padding: const EdgeInsets.all(0),
//       child: BlocBuilder<PostBloc, PostState>(
//         builder: (context, state) {
//           return state.isLoading
//               ? const CustomShimmerPostList()
//               : state.optionFailedOrPost.match(
//                   () => const SizedBox(),
//                   (t) => t.match(
//                     (l) => const SizedBox(),
//                     (r) => ListView.separated(
//                       separatorBuilder: (context, index) => const SizedBox(height: 20),
//                       itemBuilder: (context, index) => PostWidget(
//                         post: r.data[index],
//                       ),
//                       itemCount: state.limit,
//                     ),
//                   ),
//                 );
//         },
//       ),
//     );
//   }
// }
