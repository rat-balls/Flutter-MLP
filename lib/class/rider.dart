class Rider {
  final String id;
  final String name;
  final int age;
  final String horseName;

  Rider({
    required this.id,
    required this.name,
    required this.age,
    required this.horseName,
  });

  factory Rider.fromJson(Map<String, dynamic> json) {
    return Rider(
      id: json['_id'],
      name: json['name'],
      age: json['age'],
      horseName: json['horseName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'age': age,
      'horseName': horseName,
    };
  }
}
