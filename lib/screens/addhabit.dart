import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/habit_controller.dart';
import '../widgets/frequency_chip.dart';

class AddHabitScreen extends StatefulWidget {
  @override
  _AddHabitScreenState createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final HabitController habitController = Get.find();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String _selectedFrequency = 'Daily';
  String _selectedIcon = '🏃‍♂️';

  final List<String> frequencies = ['Daily', 'Weekly', 'Monthly'];
  final List<String> icons = ['🏃‍♂️', '📚', '💧', '🍎', '🧘‍♂️', '✍️', '🎯'];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Habit', style: GoogleFonts.poppins()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Habit Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a habit name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Text('Frequency', style: GoogleFonts.poppins(fontSize: 16)),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: frequencies
                      .map((frequency) => FrequencyChip(
                    label: frequency,
                    isSelected: _selectedFrequency == frequency,
                    onSelected: () {
                      setState(() {
                        _selectedFrequency = frequency;
                      });
                    },
                  ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 20),
              Text('Select Icon', style: GoogleFonts.poppins(fontSize: 16)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: icons
                    .map((icon) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIcon = icon;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _selectedIcon == icon
                          ? Get.theme.primaryColor.withOpacity(0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: _selectedIcon == icon
                            ? Get.theme.primaryColor
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: Text(
                      icon,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ))
                    .toList(),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      habitController.addHabit(
                        name: _nameController.text,
                        frequency: _selectedFrequency,
                        icon: _selectedIcon,
                      );
                      Get.back();
                    }
                  },
                  child: Text('Save Habit', style: GoogleFonts.poppins()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}