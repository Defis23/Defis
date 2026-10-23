
class Event {
  final String id;
  final String name;
  final String location;
  final String date;
  final String description;

  const Event({
    required this.id,
    required this.name,
    required this.location,
    required this.date,
    required this.description,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['name'];
    final location = json['location'];
    final date = json['date'];
    final description = json['description'];

    if (id == null ||
        name is! String ||
        name.trim().isEmpty ||
        location is! String ||
        location.trim().isEmpty ||
        date is! String ||
        date.trim().isEmpty ||
        description is! String ||
        description.trim().isEmpty) {
      throw const FormatException('Data event tidak valid.');
    }

    return Event(
      id: id.toString(),
      name: name,
      location: location,
      date: date,
      description: description,
    );
  }
}
