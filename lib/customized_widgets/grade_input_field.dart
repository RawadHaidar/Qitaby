import 'package:flutter/material.dart';

class GradeInputField extends StatefulWidget {
  final String currentLanguage;
  final TextEditingController gradeController;

  const GradeInputField({
    Key? key,
    required this.currentLanguage,
    required this.gradeController,
  }) : super(key: key);

  @override
  _GradeInputFieldState createState() => _GradeInputFieldState();
}

class _GradeInputFieldState extends State<GradeInputField> {
  late List<String> _suggestions;

  @override
  void initState() {
    super.initState();
    _updateSuggestions();
  }

  void _updateSuggestions() {
    setState(() {
      _suggestions = [
        'KG1 / PS',
        'KG2 / MS',
        'KG3 / GS',
        'Grade 1 / EB1',
        'Grade 2 / EB2',
        'Grade 3 / EB3',
        'Grade 4 / EB4',
        'Grade 5 / EB5',
        'Grade 6 / EB6',
        'Grade 7 / EB7',
        'Grade 8 / EB8',
        'Grade 9 / EB9',
        'Grade 10 / Seconde',
        'Grade 11 / Première',
        'Grade 12 / Terminale'
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        final filter = textEditingValue.text.toLowerCase();
        return _suggestions
            .where((suggestion) => suggestion.toLowerCase().contains(filter));
      },
      onSelected: (String selectedValue) {
        widget.gradeController.text = selectedValue;
      },
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: widget.currentLanguage == 'en' ? 'Class' : 'Classe',
            border: OutlineInputBorder(),
          ),
          onSubmitted: (value) {
            // Check if the entered value is one of the suggestions
            if (!_suggestions.contains(value)) {
              controller
                  .clear(); // Clear the field if input doesn't match any suggestion
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please select a valid grade')),
              );
            } else {
              widget.gradeController.text = value; // Accept the valid value
            }
          },
        );
      },
    );
  }
}
