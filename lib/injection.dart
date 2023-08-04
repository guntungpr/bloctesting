import 'package:bloctesting/injection.config.dart';
import 'package:bloctesting/presentation/routers.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
Future<void> configureInjection(String env) async {
  getIt.registerSingleton<AppRouter>(AppRouter());
  getIt.init(environment: env);
}
