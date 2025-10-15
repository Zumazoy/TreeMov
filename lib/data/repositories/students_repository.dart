import 'package:flutter/material.dart';
import 'package:treemov/api/services/students_service.dart';

class StudentRepository {
  final StudentsService _studentsService;

  StudentRepository({required StudentsService studentsService})
    : _studentsService = studentsService;

  Future<void> getAllStudents() async {
    try {
      final response = await _studentsService.getAllStudents();
    } catch (e) {
      debugPrint('Ошибка получения токена: $e');
      rethrow;
    }
  }
}
