part of 'navbar_bloc.dart';

abstract class NavbarState extends Equatable {
  const NavbarState();
  
  @override
  List<Object> get props => [];
}

class NavbarInitial extends NavbarState {}

class Navbarloading extends NavbarState {}

class NavbarLoaded extends NavbarState {
  final int index;

  const NavbarLoaded(this.index);

  @override
  List<Object> get props => [index];
}
