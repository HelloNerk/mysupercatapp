import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysupercatapp/features/cats/presentation/widgets/cat_list.dart';

import '../blocs/cat_bloc.dart';
import '../blocs/cat_state.dart';

class CatSearchPage extends StatelessWidget {
  const CatSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatBloc, CatState>(
      builder: (context, state) {
        if (state is CatLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CatLoaded) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(child: CatList(items: state.cats)),
              ],
            ),
          );
        } else if (state is CatError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('Press the button to load cats'));
        }
      },
    );
  }
}