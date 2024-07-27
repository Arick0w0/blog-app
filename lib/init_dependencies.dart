import 'package:flutter_provider101/core/common/widgets/cubits/app_user/app_user_cubit.dart';
import 'package:flutter_provider101/features/auth/data/datasources/auth_remote_data_sources.dart';
import 'package:flutter_provider101/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_provider101/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_provider101/features/auth/domain/usecases/current_user.dart';
import 'package:flutter_provider101/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter_provider101/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/secrets/app_secrets.dart';
import 'features/auth/domain/usecases/user_login.dart';

final serviceLocator = GetIt.instance;

Future<void> InitDependency() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabase,
    anonKey: AppSecrets.supabaseAnnonKey,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);

  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourcesImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLogin(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}
