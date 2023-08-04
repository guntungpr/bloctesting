// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:auto_route/auto_route.dart';
import 'package:bloctesting/application/profile/profile_bloc.dart';
import 'package:bloctesting/presentation/core/shimmer/custom_shimmer_profile_list.dart';
import 'package:bloctesting/presentation/profile/widgets/profile_card.dart';
import 'package:bloctesting/presentation/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileBloc>();
    final controller = ScrollController();
    final key = PageStorageKey(bloc.state.listProfile.length);

    Future refreshData() async {
      bloc.add(const ProfileEvent.started());
      bloc.add(const ProfileEvent.getListProfile());
    }

    Future loadMore() async {
      bloc.add(const ProfileEvent.addLimit());
      bloc.add(const ProfileEvent.getListProfile());
    }

    controller.addListener(() {
      int max = bloc.state.optionFailedOrProfile.match(
        () => 1,
        (t) => t.match(
          (l) => 1,
          (r) => r.data.length,
        ),
      );
      if (controller.position.maxScrollExtent == controller.offset && max != 0) {
        loadMore();
      }
    });

    return RefreshIndicator(
      onRefresh: () => refreshData(),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listenWhen: (p, c) =>
            p.optionFailedOrDetailProfile != c.optionFailedOrDetailProfile,
        listener: (context, state) {
          state.optionFailedOrDetailProfile.match(
            () => null,
            (t) => t.match(
              (l) => null,
              (r) => context.router.push(DetailProfileRoute(detail: r)),
            ),
          );
        },
        builder: (context, state) {
          return state.isLoading
              ? const CustomShimmerProfileList()
              : GridView.count(
                  key: key,
                  controller: controller,
                  crossAxisCount: 2,
                  children: List.generate(state.listProfile.length, (index) {
                    return state.optionFailedOrProfile.match(
                      () => const CustomShimmerProfileList(),
                      (t) => t.match(
                        (l) => const SizedBox(),
                        (r) => GestureDetector(
                          onTap: () => bloc.add(ProfileEvent.getDetailProfile(
                              id: state.listProfile[index].id)),
                          child: ProfileCard(detail: state.listProfile[index]),
                        ),
                      ),
                    );
                  }),
                );
        },
      ),
    );
  }
}
