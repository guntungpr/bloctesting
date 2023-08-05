import 'package:bloctesting/application/home/home_bloc.dart';
import 'package:bloctesting/application/post/post_bloc.dart';
import 'package:bloctesting/application/profile/profile_bloc.dart';
import 'package:bloctesting/infrastructure/db/db_helper.dart';
import 'package:bloctesting/injection.dart';
import 'package:bloctesting/presentation/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

void main() async {
  await configureInjection(Environment.dev);
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper().initDb();
  runApp(const MyApp());
}

final _appRouter = getIt<AppRouter>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<HomeBloc>(),
          ),
          BlocProvider(
            create: (context) => getIt<ProfileBloc>()
              ..add(const ProfileEvent.getAllFriends())
              ..add(
                const ProfileEvent.getListProfile(),
              ),
          ),
          BlocProvider(
            create: (context) => getIt<PostBloc>(),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerDelegate: _appRouter.delegate(),
          routeInformationParser: _appRouter.defaultRouteParser(),
        ),
      ),
    );
  }
}
