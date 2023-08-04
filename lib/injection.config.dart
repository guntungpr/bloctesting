// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:bloctesting/application/home/home_bloc.dart' as _i3;
import 'package:bloctesting/application/post/post_bloc.dart' as _i9;
import 'package:bloctesting/application/profile/profile_bloc.dart' as _i10;
import 'package:bloctesting/domain/core/i_network_service.dart' as _i5;
import 'package:bloctesting/domain/profile/i_profile_repository.dart' as _i7;
import 'package:bloctesting/infrastructure/core/network_service.dart' as _i6;
import 'package:bloctesting/infrastructure/core/register_module.dart' as _i11;
import 'package:bloctesting/infrastructure/profile/profile_repository.dart'
    as _i8;
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.factory<_i3.HomeBloc>(() => _i3.HomeBloc());
    gh.factory<String>(
      () => registerModule.baseUrl,
      instanceName: 'baseUrl',
    );
    gh.lazySingleton<_i4.Dio>(
        () => registerModule.dio(gh<String>(instanceName: 'baseUrl')));
    gh.lazySingleton<_i5.INetworkService>(
        () => _i6.NetworkService(gh<_i4.Dio>()));
    gh.lazySingleton<_i7.IProfileRepository>(
        () => _i8.ProfileRepository(gh<_i5.INetworkService>()));
    gh.factory<_i9.PostBloc>(() => _i9.PostBloc(gh<_i7.IProfileRepository>()));
    gh.factory<_i10.ProfileBloc>(
        () => _i10.ProfileBloc(gh<_i7.IProfileRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i11.RegisterModule {}
