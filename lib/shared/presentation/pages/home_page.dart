import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysupercatapp/features/cats/presentation/blocs/cat_bloc.dart';
import 'package:mysupercatapp/features/cats/presentation/pages/cat_search_page.dart';
import 'package:mysupercatapp/features/cats/presentation/pages/main_page.dart';
import 'package:mysupercatapp/features/favorites/presentation/pages/favorite_list_page.dart';

import '../../../features/cats/presentation/blocs/cat_event.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  final _pages = const [MainPage(),CatSearchPage(), FavoriteListPage()];

  @override
  void initState() {
    super.initState();
    context.read<CatBloc>().add(LoadCats());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Super Cat App')),
      body: SafeArea(child: _pages[_index]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
        ],
      ),
    );
  }
}
