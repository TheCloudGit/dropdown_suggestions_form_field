import 'package:dropdown_suggestions_form_field/dropdown_suggestions_form_field.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  List<String> _suggestions = List.generate(1000, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Example'),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: SimpleExample(suggestions: _suggestions),
          ),
        ),
      ),
    );
  }
}

class SimpleExample extends StatefulWidget {
  final List<String> suggestions;

  SimpleExample({this.suggestions});

  @override
  _SimpleExampleState createState() => _SimpleExampleState();
}

class _SimpleExampleState extends State<SimpleExample> {
  String _selectedSuggestion = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DropdownSuggestionsFormField<String>(
          decoration: InputDecoration(
              hintText: 'Start typing', labelText: 'Simple suggestion'),
          items: widget.suggestions,
          onSelected: (String suggestion) => setState(() {
            _selectedSuggestion = suggestion;
          }),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              'SELECTED SUGGESTION: ${_selectedSuggestion != null ? _selectedSuggestion : ''}',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ),
      ],
    );
  }
}
