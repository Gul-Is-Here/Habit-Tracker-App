import 'dart:convert';

class Habit {
  final String id;
  final String name;
  final String frequency;
  final String icon;
  final List<String> completedDates;
  final DateTime createdAt;

  Habit({
    required this.id,
    required this.name,
    required this.frequency,
    required this.icon,
    required this.completedDates,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'frequency': frequency,
    'icon': icon,
    'completedDates': completedDates,
    'createdAt': createdAt.toIso8601String(),
  };

  factory Habit.fromJson(Map<String, dynamic> json) => Habit(
    id: json['id'],
    name: json['name'],
    frequency: json['frequency'],
    icon: json['icon'],
    completedDates: List<String>.from(json['completedDates']),
    createdAt: DateTime.parse(json['createdAt']),
  );
}