// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'package:todoapp/Model/notes_model.dart';
import 'package:todoapp/Pages/Add%20Notes%20Page/widget/btn.dart';
import 'package:todoapp/Pages/App%20Bar/my_app_bar.dart';
import 'package:todoapp/Pages/App%20Bar/text_field.dart';
import 'package:todoapp/bloc/notes_bloc.dart';

class UpdateNotesScreen extends StatefulWidget {
  final Notes notes;

  const UpdateNotesScreen({
    super.key,
    required this.notes,
  });

  @override
  State<UpdateNotesScreen> createState() => _UpdateNotesScreenState();
}

class _UpdateNotesScreenState extends State<UpdateNotesScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.notes.title);
    descriptionController =
        TextEditingController(text: widget.notes.description);
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: myAppBar(showBtn: true, pageTitle: "Update Notes"),
        body: BlocListener<NotesBloc, NotesState>(
          listener: (context, state) {
            if (state is NotesLoadingState) {
              setState(() {
                isLoading = true;
              });
            } else {
              setState(() {
                isLoading = false;
              });
            }
            if (state is NotesUpdatedState) {
              showToast(
                'Note Updated Successfully',
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
              Navigator.of(context).pop(true);
            } else if (state is NotesErrorState) {
              showToast(
                'Error in Updating Notes',
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
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                MyTextField(
                  controller: titleController,
                  textTitle: "Note Title",
                  maxLine: 1,
                ),
                const SizedBox(
                  height: 25,
                ),
                MyTextField(
                  controller: descriptionController,
                  textTitle: "Note Description",
                  maxLine: null,
                ),
                const Spacer(),
                Btn(
                  btnTitle: "Update",
                  onPressed: () {
                    if (titleController.text.isEmpty ||
                        descriptionController.text.isEmpty) {
                      showToast(
                        'Some field are empty',
                        backgroundColor: Colors.red,
                        textStyle: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        context: context,
                        animation: StyledToastAnimation.scale,
                        reverseAnimation: StyledToastAnimation.fade,
                        position: StyledToastPosition.center,
                        animDuration: const Duration(seconds: 1),
                        duration: const Duration(seconds: 4),
                        curve: Curves.elasticOut,
                        reverseCurve: Curves.linear,
                      );
                    } else {
                      context.read<NotesBloc>().add(NoteUpdatedEvent(
                          noteId: widget.notes.id,
                          title: titleController.text,
                          description: descriptionController.text));
                      titleController.clear();
                      descriptionController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
