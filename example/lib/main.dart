import 'package:flutter/material.dart';

import 'advance_example.dart';
import 'simple_example.dart';

void main() => runApp(App());

class App extends StatelessWidget {
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
            child: DropdownSuggestionsFormFieldExample(),
          ),
        ),
      ),
    );
  }
}

class DropdownSuggestionsFormFieldExample extends StatefulWidget {
  @override
  _DropdownSuggestionsFormFieldExampleState createState() =>
      _DropdownSuggestionsFormFieldExampleState();
}

class _DropdownSuggestionsFormFieldExampleState
    extends State<DropdownSuggestionsFormFieldExample> {
  List<String> _suggestions = List.generate(1000, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SimpleExample(suggestions: _suggestions),
        AdvanceExample(suggestions: _suggestions),
      ],
    );
  }
}
