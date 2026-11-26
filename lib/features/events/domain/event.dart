
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
    final id = json['id']?.toString() ?? '';
    final name = json['name']?.toString().trim() ?? '';

    if (id.isEmpty || name.isEmpty) {
      throw const FormatException(
        'ID atau nama event tidak valid.',
      );
    }

    return Event(
      id: id,
      name: name,
      location: json['location']?.toString() ?? '',
      date: json['date']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
    );
  }
}
