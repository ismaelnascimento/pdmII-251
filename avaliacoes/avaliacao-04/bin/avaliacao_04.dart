// Dart command line app to interact with SQLite database (TB_ALUNO table)

import 'dart:io';
import 'package:sqlite3/sqlite3.dart';

void main() {
  // Open/create SQLite database file (students.db)
  final db = sqlite3.open('students.db');

  // Create TB_ALUNO table if it doesn't exist
  db.execute('''
    CREATE TABLE IF NOT EXISTS TB_ALUNO (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL CHECK(length(nome) <= 50)
    );
  ''');

  print('SQLite TB_ALUNO management');
  print('--------------------------');

  bool running = true;

  while (running) {
    print('\nChoose an option:');
    print('1. Add aluno');
    print('2. List alunos');
    print('0. Exit');

    stdout.write('Option: ');
    String? option = stdin.readLineSync();

    switch (option) {
      case '1':
        addAluno(db);
        break;
      case '2':
        listAlunos(db);
        break;
      case '0':
        running = false;
        break;
      default:
        print('Invalid option. Try again.');
    }
  }

  db.dispose();
  print('Program exited. Goodbye!');
}

void addAluno(Database db) {
  stdout.write('Enter aluno nome (max 50 chars): ');
  String? nome = stdin.readLineSync();

  if (nome == null || nome.trim().isEmpty) {
    print('Nome cannot be empty.');
    return;
  }

  if (nome.length > 50) {
    print('Nome too long. Max 50 characters allowed.');
    return;
  }

  final stmt = db.prepare('INSERT INTO TB_ALUNO (nome) VALUES (?)');
  try {
    stmt.execute([nome.trim()]);
    print('Aluno added successfully!');
  } catch (e) {
    print('Failed to add aluno: $e');
  } finally {
    stmt.dispose();
  }
}

void listAlunos(Database db) {
  final ResultSet result = db.select('SELECT id, nome FROM TB_ALUNO ORDER BY id;');

  if (result.isEmpty) {
    print('No alunos found.');
    return;
  }

  print('\nList of alunos:');
  print('ID   | Nome');
  print('----------------------------');

  for (final row in result) {
    // row is a Map with keys id and nome
    print('${row['id'].toString().padRight(5)}| ${row['nome']}');
  }
}
