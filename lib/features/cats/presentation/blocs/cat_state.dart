import '../../domain/cat.dart';

abstract class CatState {}

class CatInitial extends CatState {}

class CatLoading extends CatState {}

class CatLoaded extends CatState {
  final List<Cat> cats;

  CatLoaded(this.cats);
}

class CatError extends CatState {
  final String message;

  CatError(this.message);
}