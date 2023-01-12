part of 'navbar_bloc.dart';

abstract class NavbarEvent extends Equatable {
  const NavbarEvent();

  @override
  List<Object> get props => [];
}

class NavbarChanged extends NavbarEvent {
  final int index;

  const NavbarChanged(this.index);

  @override
  List<Object> get props => [index];
}
