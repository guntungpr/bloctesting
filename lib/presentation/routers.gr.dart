// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'routers.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    DetailProfileRoute.name: (routeData) {
      final args = routeData.argsAs<DetailProfileRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: DetailProfilePage(
          key: args.key,
          detail: args.detail,
        ),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          HomeRoute.name,
          path: '/',
        ),
        RouteConfig(
          DetailProfileRoute.name,
          path: '/detailProfile',
        ),
      ];
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [DetailProfilePage]
class DetailProfileRoute extends PageRouteInfo<DetailProfileRouteArgs> {
  DetailProfileRoute({
    Key? key,
    required DetailProfileModel detail,
  }) : super(
          DetailProfileRoute.name,
          path: '/detailProfile',
          args: DetailProfileRouteArgs(
            key: key,
            detail: detail,
          ),
        );

  static const String name = 'DetailProfileRoute';
}

class DetailProfileRouteArgs {
  const DetailProfileRouteArgs({
    this.key,
    required this.detail,
  });

  final Key? key;

  final DetailProfileModel detail;

  @override
  String toString() {
    return 'DetailProfileRouteArgs{key: $key, detail: $detail}';
  }
}
