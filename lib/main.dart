import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysupercatapp/features/cats/data/remote/cat_service.dart';
import 'package:mysupercatapp/shared/presentation/pages/home_page.dart';

import 'features/cats/presentation/blocs/cat_bloc.dart';
import 'features/favorites/presentation/blocs/favorite_bloc.dart';
import 'features/favorites/presentation/blocs/favorite_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FavoriteBloc()..add(LoadFavorites())),
        BlocProvider(create: (context) => CatBloc(CatService())),
      ],
      child: MaterialApp(
        title: 'My Super Cat App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}