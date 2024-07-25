// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:todoapp/Model/notes_model.dart';
import 'package:todoapp/Pages/Add%20Notes%20Page/Ui/add_notes_screen.dart';
import 'package:todoapp/Pages/App%20Bar/my_app_bar.dart';
import 'package:todoapp/Pages/Home%20Pages/widgets/add_button.dart';
import 'package:todoapp/Pages/Home%20Pages/widgets/notes_card.dart';
import 'package:todoapp/Pages/Updaete%20Page/ui/update_page.dart';
import 'package:todoapp/TextStyle/my_text_style.dart';
import 'package:todoapp/bloc/notes_bloc.dart';
import 'package:todoapp/enum/todo_status.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TodoStatus selectedStatus = TodoStatus.All;
  @override
  void initState() {
    super.initState();
    context
        .read<NotesBloc>()
        .add(FetchAllNotesEvent(todoStatus: selectedStatus));
  }

  _navigateToAddNotesScreen() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const AddNotesScreen()),
    );
    if (result == true) {
      context
          .read<NotesBloc>()
          .add(FetchAllNotesEvent(todoStatus: selectedStatus));
    }
  }

  Future<void> _navigateToUpdateNotesScreen(Notes note) async {
 final result= await Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => UpdateNotesScreen(
        notes: note,
      ),
    ),
  );
    if (result == true) {
      context
          .read<NotesBloc>()
          .add(FetchAllNotesEvent(todoStatus: selectedStatus));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: myAppBar(pageTitle: "My Notes"),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: AddButton(
        onPressed:  _navigateToAddNotesScreen
      ),
      body: BlocListener<NotesBloc, NotesState>(
        listener: (context, state) {
          if (state is NotesDeleteState) {
            showToast(
              'Notes Deleted Successfully',
              backgroundColor: Colors.red,
              textStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              context: context,
              animation: StyledToastAnimation.scale,
              reverseAnimation: StyledToastAnimation.fade,
              position: StyledToastPosition.center,
              animDuration: const Duration(seconds: 1),
              duration: const Duration(seconds: 2),
              curve: Curves.elasticOut,
              reverseCurve: Curves.linear,
            );
            context
                .read<NotesBloc>()
                .add(FetchAllNotesEvent(todoStatus: selectedStatus));
          } else if (state is NotesErrorState) {
            showToast(
              state.errorMsg,
              backgroundColor: Colors.red,
              textStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              context: context,
              animation: StyledToastAnimation.scale,
              reverseAnimation: StyledToastAnimation.fade,
              position: StyledToastPosition.center,
              animDuration: const Duration(seconds: 1),
              duration: const Duration(seconds: 2),
              curve: Curves.elasticOut,
              reverseCurve: Curves.linear,
            );
          }
        },
        child: BlocListener<NotesBloc, NotesState>(
          listener: (context, state) {
            if (state is NotesCompleteState) {
              showToast(
                'Notes Completed Successfully',
                backgroundColor: Colors.green,
                textStyle: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
                context: context,
                animation: StyledToastAnimation.scale,
                reverseAnimation: StyledToastAnimation.fade,
                position: StyledToastPosition.center,
                animDuration: const Duration(seconds: 1),
                duration: const Duration(seconds: 2),
                curve: Curves.elasticOut,
                reverseCurve: Curves.linear,
              );
              context
                  .read<NotesBloc>()
                  .add(FetchAllNotesEvent(todoStatus: selectedStatus));
            } else if (state is NotesErrorState) {
              showToast(
                'Unable to Complete',
                backgroundColor: Colors.red,
                textStyle: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
                context: context,
                animation: StyledToastAnimation.scale,
                reverseAnimation: StyledToastAnimation.fade,
                position: StyledToastPosition.center,
                animDuration: const Duration(seconds: 1),
                duration: const Duration(seconds: 2),
                curve: Curves.elasticOut,
                reverseCurve: Curves.linear,
              );
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: TodoStatus.values
                        .map(
                          (e) => GestureDetector(
                            onTap: () {
                              setState(
                                () {
                                  selectedStatus = e;
                                  context
                                      .read<NotesBloc>()
                                      .add(FetchAllNotesEvent(todoStatus: e));
                                },
                              );
                            },
                            child: BlocSelector<NotesBloc, NotesState, String>(
                              selector: (state) {
                                if (state is FetchAllNotesState<List<Notes>> &&
                                    e == selectedStatus) {
                                  return " (${state.notes.length})";
                                } else {
                                  return "";
                                }
                              },
                              builder: (context, state) {
                                return Container(
                                  margin:
                                      const EdgeInsets.only(left: 8, bottom: 5),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.indigo),
                                    color: selectedStatus == e
                                        ? Colors.indigo
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    e.name + state,
                                    style: myTextStyle(
                                      fontweight: selectedStatus == e
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: selectedStatus == e
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<NotesBloc, NotesState>(
                    builder: (context, state) {
                      if (state is FetchAllNotesState<List<Notes>>) {
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: state.notes.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                _navigateToUpdateNotesScreen(
                                    state.notes[index]);
                              },
                              child: NotesCard(
                                onComplete: (value) {
                                  context.read<NotesBloc>().add(
                                        NoteCompleteEvent(
                                            noteId: state.notes[index].id),
                                      );
                                },
                                onDelete: (value) async {
                                  context.read<NotesBloc>().add(
                                        NoteDeleteEvent(
                                            noteId: state.notes[index].id),
                                      );
                                },
                                notes: state.notes[index],
                              ),
                            );
                          },
                        );
                      } else if (state is NotesErrorState) {
                        return Center(
                          child: Text(state.errorMsg),
                        );
                      } else if (state is NotesLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
