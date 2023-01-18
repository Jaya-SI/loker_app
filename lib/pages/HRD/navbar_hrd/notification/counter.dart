import 'package:bloc/bloc.dart';

class CounterPage extends Cubit<int> {
  CounterPage({this.init = 0}) : super(init);

  int init;

  void nextPage() => emit(state + 1);
  void backPage() => emit(state - 1);
}

class CounterInterview extends Cubit<int> {
  CounterInterview({this.init = 0}) : super(init);

  int init;

  void nextPage() => emit(state + 1);
  void backPage() => emit(state - 1);
}
