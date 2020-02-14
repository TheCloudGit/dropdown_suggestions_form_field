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
            child: AdvanceExample(suggestions: _suggestions),
          ),
        ),
      ),
    );
  }
}

class AdvanceExample extends StatefulWidget {
  List<String> suggestions;

  AdvanceExample({this.suggestions});

  @override
  _AdvanceExampleState createState() => _AdvanceExampleState();
}

class _AdvanceExampleState extends State<AdvanceExample> {
  String _selectedSuggestion = '';

  final GlobalKey<DropdownSuggestionsFormFieldState> _dropDownSuggestionKey =
      GlobalKey<DropdownSuggestionsFormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DropdownSuggestionsFormField<String>(
          autocorrect: true,
          autovalidate: true,
          buildCounter: (
              BuildContext context, {
                int currentLength,
                int maxLength,
                bool isFocused,
              }) {
            return Text(
              '$currentLength of $maxLength characters',
              semanticsLabel: 'character count',
            );
          },
          onChanged: (String s) => print('Value changed $s'),
          decoration: InputDecoration(
              hintText: 'Start typing', labelText: 'Suggestion'),
          filter: (String string) {
            return widget.suggestions.where((element) {
              return (element).toLowerCase().contains(string.toLowerCase());
            }).toList();
          },
          initialValue: 'Item 1',
          itemBuilder: (BuildContext context, int index,
              AsyncSnapshot<List<String>> snapshot) {
            String suggestion = snapshot.data.elementAt(index);
            return GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                constraints:
                BoxConstraints(minHeight: kMinInteractiveDimension),
                alignment: AlignmentDirectional.centerStart,
                child: Text('${suggestion}'),
              ),
              onTap: () =>
                  _dropDownSuggestionKey.currentState.onSelect(suggestion),
            );
          },
          key: _dropDownSuggestionKey,
          maxLength: 10,
          offset: Offset(0.0, -20.0),
          onSelected: (String suggestion) =>
              setState(() => _selectedSuggestion = suggestion),
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: Colors.blueAccent,
            );
          },
          suggestionWaitingMessage: 'Waiting for results',
          suggestionNotMatchMessage: 'No matching results',
          validator: (String v) {
            if (v.isEmpty) {
              return 'Error: Add some text';
            }
            return null;
          },
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
