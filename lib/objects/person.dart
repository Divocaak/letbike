class Person {
  final String id;
  final String email;
  final String name;

  Person(this.id, this.email, this.name);

  factory Person.fromJson(Map<String, dynamic> json) =>
      Person(json["id"], json["name"], json["mail"]);
}
