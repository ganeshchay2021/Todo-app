import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:todoapp/Model/notes_model.dart';
import 'package:todoapp/enum/todo_status.dart';
import 'package:todoapp/services/database_services.dart';

class NotesRepository {
  final List<Notes> _notes = [];

  List<Notes> get notes => _notes;

  // Dio dio = Dio();

  final databaseServices = DatabaseServices();

  // Future<Either<List<Notes>, String>> fetchAllNotes(
  //     {TodoStatus todoStatus = TodoStatus.All}) async {
  //   try {
  //     final Map<String, dynamic> param = {};
  //     if (todoStatus != TodoStatus.All) {
  //       param["completed"] = todoStatus == TodoStatus.Completed ? true : false;
  //     }

  //     final response = await dio.get(Constant.api, queryParameters: param);
  //     final data = List.from(response.data["data"])
  //         .map((data) => Notes.fromMap(data))
  //         .toList();
  //     _notes.clear();
  //     _notes.addAll(data);
  //     return Left(data);
  //   } on DioException catch (e) {
  //     return Right(e.response?.data["message"] ?? "Unable to Fetch Notes");
  //   } catch (e) {
  //     return Right(e.toString());
  //   }
  // }

  Future<Either<List<Notes>, String>> fetchAllNotes(
      {TodoStatus todoStatus = TodoStatus.All}) async {
    try {
      final result = await databaseServices.getNotes(status: todoStatus);
      _notes.clear();
      _notes.addAll(result);
      return Left(notes);
    } on DioException catch (e) {
      return Right(e.response?.data["message"] ?? "Unable to Fetch Notes");
    } catch (e) {
      return Right(e.toString());
    }
  }

  // Future<Either<Notes, String>> addNote(
  //     {required String title, required String description}) async {
  //   try {
  //     final response = await dio.post(Constant.api,
  //         data: {"title": title, "description": description});
  //     final data = Notes.fromMap(response.data["data"]);
  //     return Left(data);
  //   } on DioException catch (e) {
  //     return Right(e.response?.data["message"] ?? "Unable to add Notes");
  //   } catch (e) {
  //     return Right(e.toString());
  //   }
  // }

  Future<Either<Notes, String>> addNote(
      {required String title, required String description}) async {
    try {
      final response = await databaseServices.addNotes(
          title: title, description: description);
      return Left(response);
    } on DioException catch (e) {
      return Right(e.response?.data["message"] ?? "Unable to add Notes");
    } catch (e) {
      return Right(e.toString());
    }
  }

  // Future<Either<String, void>> deleteNotes({required String noteId}) async {
  //   try {
  //     final _ = await Dio().delete("${Constant.api}/$noteId/");
  //     return const Right(null);
  //   } on DioException catch (e) {
  //     return Left(e.response?.data["message"] ?? "Unable to delete Note");
  //   } catch (e) {
  //     return Left(e.toString());
  //   }
  // }

  Future<Either<String, void>> deleteNotes({required String noteId}) async {
    try {
      final _ = await databaseServices.deleteNotes(notesId: noteId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(e.response?.data["message"] ?? "Unable to delete Note");
    } catch (e) {
      return Left(e.toString());
    }
  }

  // Future<Either<String, void>> completeNotes({required String noteId}) async {
  //   try {
  //     final _ = await Dio().get("${Constant.api}/$noteId/completed");
  //     return const Right(null);
  //   } on DioException catch (e) {
  //     return Left(e.response?.data["message"] ?? "Unable to delete Note");
  //   } catch (e) {
  //     return Left(e.toString());
  //   }
  // }

  Future<Either<String, void>> completeNotes({required String noteId}) async {
    try {
      final _ = await databaseServices.markedAsCompleted(notesId: noteId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(e.response?.data["message"] ?? "Unable to delete Note");
    } catch (e) {
      return Left(e.toString());
    }
  }

  // Future<Either<String, void>> updateNotes({required String title, required String description, required String noteId}) async {
  //   try {
  //     final _ = await Dio().put("${Constant.api}/$noteId/", data: {
  //       "title": title,
  //       "description": description
  //     });
  //     return const Right(null);
  //   } on DioException catch (e) {
  //     return Left(e.response?.data["message"] ?? "Unable to delete Note");
  //   } catch (e) {
  //     return Left(e.toString());
  //   }
  // }

  Future<Either<String, void>> updateNotes(
      {required String title,
      required String description,
      required String noteId}) async {
    try {
      final _ = await databaseServices.updatateNotes(
          notesId: noteId, title: title, description: description);
      return const Right(null);
    } on DioException catch (e) {
      return Left(e.response?.data["message"] ?? "Unable to delete Note");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
