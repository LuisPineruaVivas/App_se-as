import 'dart:convert';

Student userStudentFromJson(String str) => Student.fromJson(json.decode(str));

String userStudentToJson(Student data) => json.encode(data.toJson());

class Student {
  String id;
  final String nombre;
  final String correo;
  final String contrasena;
  bool isProfessor = false;
  bool acceptCalls = false;

  Student({
    this.id = '',
    required this.nombre,
    required this.correo,
    required this.contrasena,
    required this.isProfessor,
    required this.acceptCalls,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["id"],
        nombre: json["nombre"],
        correo: json["correo"],
        contrasena: json["contrasena"],
        isProfessor: json["isProfessor"],
        acceptCalls: json["acceptCalls"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "correo": correo,
        "contrasena": contrasena,
        "isProfessor": isProfessor,
        "acceptCalls": acceptCalls
      };
}
