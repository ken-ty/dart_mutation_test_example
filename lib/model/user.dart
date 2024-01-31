class User {
  String name;
  int age;

  User({required this.name, required this.age});

  @override
  String toString() {
    return "User: $name, $age";
  }
}
