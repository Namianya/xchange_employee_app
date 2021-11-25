import 'dart:convert';

class Mymodel {
  String name;
  int age;
  
  Mymodel({
    required this.name,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
    };
  }

  factory Mymodel.fromMap(Map<String, dynamic> map) {
    return Mymodel(
      name: map['name'],
      age: map['age'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Mymodel.fromJson(String source) =>
      Mymodel.fromMap(json.decode(source));
}
