// ignore_for_file: sort_child_properties_last

import 'package:bloctesting/application/post/post_bloc.dart';
import 'package:bloctesting/infrastructure/profile/models/post/post_model.dart';
import 'package:bloctesting/presentation/core/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key, required this.post});
  final PostDetailModel post;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, right: 10, bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MaterialButton(
              onPressed: () {},
              color: Colors.blue,
              textColor: Colors.white,
              child: const Icon(
                Icons.person,
                size: 24,
              ),
              padding: const EdgeInsets.all(10),
              shape: const CircleBorder(),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${post.owner.firstName} ${post.owner.lastName}'),
                  Text(CommonUtils.dateFormat('dd MMMM yyyy hh:mm:ss', post.publishDate)),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 130,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Image.network(post.image, fit: BoxFit.fill),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => context
                            .read<PostBloc>()
                            .add(PostEvent.tagSelected(tag: post.tags[index])),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            color: Colors.blue,
                            child: Text(
                              post.tags[index],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) => const SizedBox(width: 10),
                      itemCount: post.tags.length,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(post.text),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    post.image.toString(),
                    style: const TextStyle(color: Colors.blue),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${post.likes} Likes',
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                  const SizedBox(height: 5),
                  const Divider(thickness: 2),
                  const SizedBox(height: 5),
                  const Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Like'),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
