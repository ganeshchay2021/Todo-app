// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import 'package:todoapp/Model/notes_model.dart';
import 'package:todoapp/enum/todo_status.dart';
import 'package:todoapp/repository/notes_repository.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesRepository notesRepository;
  NotesBloc({required this.notesRepository}) : super(NotesInitialState()) {
    on<FetchAllNotesEvent>((event, emit) async {
      emit(NotesLoadingState());
      final result =
          await notesRepository.fetchAllNotes(todoStatus: event.todoStatus);
      result.fold((data) => emit(FetchAllNotesState<List<Notes>>(notes: data)),
          (error) => emit(NotesErrorState(errorMsg: error)));
    });

    on<NoteAddEvent>(
      (event, emit) async {
        emit(NotesLoadingState());
        final result = await notesRepository.addNote(
            title: event.title, description: event.description);
        result.fold((data) => emit(FetchAllNotesState<Notes>(notes: data)),
            (error) => emit(NotesErrorState(errorMsg: error)));
      },
      transformer: droppable(),
    );

    on<NoteDeleteEvent>(
      (event, emit) async {
        emit(NotesLoadingState());
        final result = await notesRepository.deleteNotes(noteId: event.noteId);
        result.fold(
          (error) => emit(NotesErrorState(errorMsg: error)),
          (data) => emit(NotesDeleteState()),
        );
      },
      transformer: droppable(),
    );

  on<NoteCompleteEvent>(
      (event, emit) async {
        emit(NotesLoadingState());
        final result =
            await notesRepository.completeNotes(noteId: event.noteId);
        result.fold(
          (error) => emit(NotesErrorState(errorMsg: error)),
          (data) => emit(NotesCompleteState()),
        );
      },
      transformer: droppable(),
    );

    on<NoteUpdatedEvent>(
      (event, emit) async {
        emit(NotesLoadingState());
        final result = await notesRepository.updateNotes(
          noteId: event.noteId,
          title: event.title,
          description: event.description,
        );
        result.fold(
          (error) => emit(NotesErrorState(errorMsg: error)),
          (data) => emit(NotesUpdatedState()),
        );
      },
      transformer: droppable(),
    );
  }
}
