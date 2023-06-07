import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/core/inject/inject.dart';

import './src/features/todo/presentation/cubit/todo_cubit.dart';
import './src/splash/presentation/pages/splash_page.dart';
import 'src/features/users/presentation/cubit/users_cubit.dart';
import 'src/providers/injector/dependencies_injector.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    Inject.initialize();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => DependenciesInjector.get<TodoCubit>(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => DependenciesInjector.get<UsersCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Tech O\'Clock - Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.blue[900],
            secondary: Colors.black,
            background: Colors.white,
          ),
          useMaterial3: true,
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
        ),
        themeMode: themeMode,
        home: const SplashPage(),
      ),
    );
  }
}
