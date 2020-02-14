# dropdown_suggestions_form_field_example

The DropdownSuggestionsForm field widget provides a list of suggestions while typing into a textFormField.

## Main

At the example you can find a widget that call the two widgets, each one are examples of the DropdownSuggestionsFormField widget.
One widget example is a simple DropdownSuggestionsFormField and the other one is a more advance implementation that let you see how much this widget can be customized.

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

## Simple example

The simple example expose the minimum parameter that this widget needs.

DropdownSuggestionsFormField<String>(
  decoration: InputDecoration(
      hintText: 'Start typing', labelText: 'Simple suggestion'),
  items: widget.suggestions,
  onSelected: (String suggestion) => setState(() {
    _selectedSuggestion = suggestion;
  }),
),

## Advance example

The advance example show many of the customization that this widget support. For more customization is recommended to check inspect the widget code in more detail.

DropdownSuggestionsFormField<String>(
  autocorrect: true,
  autovalidate: true,
  buildCounter: (BuildContext context, {
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