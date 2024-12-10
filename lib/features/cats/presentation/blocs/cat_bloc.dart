import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resource.dart';
import '../../data/remote/cat_service.dart';
import '../../domain/cat.dart';
import 'cat_event.dart';
import 'cat_state.dart';

class CatBloc extends Bloc<CatEvent, CatState> {
  final CatService catService;

  CatBloc(this.catService) : super(CatInitial()) {
    on<LoadCats>((event, emit) async {
      emit(CatLoading());
      try {
        final result = await catService.getCats();
        if (result is Success<List<Cat>>) {
          emit(CatLoaded(result.data!));
        } else {
          emit(CatError('Failed to load cats'));
        }
      } catch (e) {
        emit(CatError(e.toString()));
      }
    });
  }

}