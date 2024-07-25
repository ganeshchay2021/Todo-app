part of 'notes_bloc.dart';

sealed class NotesState {}

final class NotesInitialState extends NotesState {}

final class NotesLoadingState extends NotesState {}

final class FetchAllNotesState<Type> extends NotesState {
  Type notes;

  FetchAllNotesState({required this.notes});
}

final class NotesErrorState extends NotesState {
  final String errorMsg;

  NotesErrorState({required this.errorMsg});
}

final class NotesDeleteState extends NotesState {}

final class NotesCompleteState extends NotesState {}

final class NotesUpdatedState extends NotesState {}


