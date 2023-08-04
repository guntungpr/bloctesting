import 'package:auto_route/auto_route.dart';
import 'package:bloctesting/infrastructure/profile/models/detail/detail_profile_model.dart';
import 'package:bloctesting/presentation/home/home_page.dart';
import 'package:bloctesting/presentation/profile/detail/detail_profile_page.dart';
import 'package:flutter/material.dart';

part 'routers.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: '/', page: HomePage),
    AutoRoute(path: '/detailProfile', page: DetailProfilePage),
  ],
)
class AppRouter extends _$AppRouter {}
