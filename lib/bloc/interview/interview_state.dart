part of 'interview_bloc.dart';

abstract class InterviewState extends Equatable {
  const InterviewState();

  @override
  List<Object> get props => [];
}

class InterviewInitial extends InterviewState {}

class InterviewLoading extends InterviewState {}

class InterviewLoaded extends InterviewState {
  final DataInterviewModel interview;

  InterviewLoaded({required this.interview});

  @override
  List<Object> get props => [interview];
}

class InterviewError extends InterviewState {
  final String message;

  InterviewError({required this.message});

  @override
  List<Object> get props => [message];
}
