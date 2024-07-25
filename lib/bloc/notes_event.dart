// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notes_bloc.dart';

sealed class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class FetchAllNotesEvent extends NotesEvent {
  final TodoStatus todoStatus;
  const FetchAllNotesEvent({
    required this.todoStatus,
  });
}

class NoteAddEvent extends NotesEvent {
  final String title;
  final String description;
  const NoteAddEvent({
    required this.title,
    required this.description,
  });
}

class NoteDeleteEvent extends NotesEvent {
  final String noteId;
  const NoteDeleteEvent({required this.noteId});
}

class NoteCompleteEvent extends NotesEvent {
  final String noteId;

  const NoteCompleteEvent({required this.noteId});
}

class NoteUpdatedEvent extends NotesEvent {
  final String title;
  final String description;
  final String noteId;
  const NoteUpdatedEvent({
    required this.title,
    required this.noteId,
    required this.description,
  });
}
