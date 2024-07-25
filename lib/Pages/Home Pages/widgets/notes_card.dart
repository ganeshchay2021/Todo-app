// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import 'package:todoapp/Model/notes_model.dart';
import 'package:todoapp/TextStyle/my_text_style.dart';

class NotesCard extends StatelessWidget {
  final Notes notes;
  final ValueChanged<BuildContext> onDelete;
  final ValueChanged<BuildContext> onComplete;

  const NotesCard({
    super.key,
    required this.notes,
    required this.onDelete,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Slidable(
        startActionPane: ActionPane(motion: const StretchMotion(), children: [
          if (notes.completed == false)
            SlidableAction(
              onPressed: onComplete,
              // label: "Complete",
              // foregroundColor: Colors.white,
              backgroundColor: Colors.green,
              icon: Icons.save,
            ),
          SlidableAction(
            onPressed: onDelete,
            backgroundColor: Colors.red,
            icon: Icons.delete,
          )
        ]),
        child: Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // chip
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          notes.title,
                          style: myTextStyle(
                            fontweight: FontWeight.bold,
                            size: 18,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            color: notes.completed ? Colors.green : Colors.red,
                            shape: BoxShape.circle,
                          ),
                        )
                      ],
                    ),
                    Text(
                      maxLines: 1,
                      notes.description,
                      style: myTextStyle(
                          fontweight: FontWeight.bold,
                          size: 13,
                          color: Colors.grey),
                    ),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    style: myTextStyle(
                      color: Colors.grey,
                      size: 12,
                      fontweight: FontWeight.bold,
                    ),
                    children: [
                      const WidgetSpan(
                        child: Icon(
                          Icons.calendar_month,
                          color: Colors.grey,
                          size: 11,
                        ),
                      ),
                      const WidgetSpan(
                        child: SizedBox(
                          width: 5,
                        ),
                      ),
                      TextSpan(
                        text: DateFormat.yMMMd().format(notes.createdAt),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
