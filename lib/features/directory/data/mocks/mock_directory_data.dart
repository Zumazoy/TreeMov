import 'package:treemov/features/directory/domain/entities/group_entity.dart';
import 'package:treemov/features/directory/domain/entities/parent_contact_entity.dart';
import 'package:treemov/features/directory/domain/entities/student_entity.dart';
import 'package:treemov/features/directory/domain/entities/subject_entity.dart';
import 'package:treemov/features/directory/domain/entities/teacher_entity.dart';

class MockDirectoryData {
  // Предметы
  static final physics = SubjectEntity(id: '1', name: 'Физика');
  static final math = SubjectEntity(id: '2', name: 'Математика');

  // Учителя
  static final classTeacher = TeacherEntity(
    id: '1',
    fullName: 'Степанова Ольга Петровна',
  );

  // Группы по разным предметам
  static final groups = [
    GroupEntity(id: '1', name: '130', subjectId: '1', studentCount: 15),
    GroupEntity(id: '2', name: '120', subjectId: '1', studentCount: 15),
    GroupEntity(id: '3', name: '130', subjectId: '1', studentCount: 15),
    GroupEntity(id: '4', name: '120', subjectId: '1', studentCount: 15),
    GroupEntity(id: '5', name: '130', subjectId: '2', studentCount: 15),
    GroupEntity(id: '6', name: '120', subjectId: '2', studentCount: 15),
    GroupEntity(id: '7', name: '130', subjectId: '2', studentCount: 15),
    GroupEntity(id: '8', name: '120', subjectId: '2', studentCount: 15),
  ];

  // Список учеников для отображения в директории
  static final students = [
    StudentEntity(
      id: '1',
      fullName: 'Журавлев Антон',
      currentGroupId: '2',
      email: 'anton@email.com',
      groupJoinDate: DateTime(2024, 1, 15),
      birthDate: DateTime(2010, 3, 20),
      phone: '+7 (900) 111-11-11',
      otherGroupIds: [],
      classTeacherId: '1',
      parentContacts: [],
    ),
    StudentEntity(
      id: '2',
      fullName: 'Иванов Иван',
      currentGroupId: '2',
      email: 'ivan@email.com',
      groupJoinDate: DateTime(2024, 2, 10),
      birthDate: DateTime(2011, 5, 15),
      phone: '+7 (900) 222-22-22',
      otherGroupIds: [],
      classTeacherId: '1',
      parentContacts: [],
    ),
    StudentEntity(
      id: '3',
      fullName: 'Кошмаров Дмитрий',
      currentGroupId: '2',
      email: 'jurawlyowa.di@yandex.ru',
      groupJoinDate: DateTime(2025, 7, 28),
      birthDate: DateTime(2015, 9, 23),
      phone: '+7 (953) 749-85-39',
      otherGroupIds: ['1', '3'],
      classTeacherId: '1',
      parentContacts: [
        ParentContactEntity(
          id: '1',
          fullName: 'Сонова Надежда Викторовна',
          relationship: 'Мама',
          phone: '+7 (953) 749-85-39',
        ),
      ],
    ),
    StudentEntity(
      id: '4',
      fullName: 'Журавлева Диана',
      currentGroupId: '2',
      email: 'diana@email.com',
      groupJoinDate: DateTime(2024, 3, 5),
      birthDate: DateTime(2012, 7, 12),
      phone: '+7 (900) 333-33-33',
      otherGroupIds: [],
      classTeacherId: '1',
      parentContacts: [],
    ),
  ];
}
