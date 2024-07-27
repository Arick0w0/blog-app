import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_provider101/core/common/widgets/cubits/app_user/app_user_cubit.dart';
import 'package:flutter_provider101/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_provider101/features/auth/presentation/pages/login.dart';
import 'package:flutter_provider101/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter_provider101/init_dependencies.dart';

import 'core/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InitDependency();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AppUserCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightThemeMode, // ธีมสำหรับ Light Mode
      darkTheme: AppTheme.darkThemeMode,
      // theme: AppTheme.lightThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLogged) {
          if (isLogged) {
            return const BlogPage();
          }
          return const LoginPage();
        },
      ),
    );
  }
}
