# dropdown_suggestions_form_field

The DropdownSuggestionsFormField widget provides a list of suggestions while typing into a TextFormField.
The widget can be used with a default or a custom item builder, separator builder and a filter method.
The TextFormField and the widgets inside such as the Overlay, the CompositedTransformFollower, the Card, etc can be customized too.
When no suggestion are found or the filter method is processing the list of items, the dropdown will show a message that can be customized with a custom message or a custom widget.

## Getting Started

This project is a starting point for a more advanced autocomplete and suggestions widget.

## Filtering

The suggestions can be filtered with a custom filter method. If a custom filter is used there is no need to use the items parameter.

## Dropdown

The dropdown is constructed with an Overlay and a CompositedTransformFollower linked to a CompositedTransformTarget that has a TextFormField as a child.
The dropdown and the widgets inside can be fully customized.

## Dropdown suggestions

The suggestions are displayed inside a ListView.separated widget.
Each item can be fully customized with a ItemBuilder and the separator widgets can be customized too.

A onSelect method is exposed by using a GlobalKey<DropdownSuggestionsFormFieldState> as the widget key.

## TextFormField

The TextFormField can be customized using the same parameters that a simple TextFormField widget has including the onChange method.
There is a delay between the TextFormField onChanges method, for making less request to the filtering method.
The delay between changes can be customized.

A TextEditingController is exposed by using a GlobalKey<DropdownSuggestionsFormFieldState> as the widget key.

## StreamBuilder

A streamBuilder widget is used for showing the suggestion inside a listView.
This streamBuilder allows the widget to return a message when there are no results to show or when the stream is waiting for the results.
The two possible message can be customized by customizing the text inside or by customizing the widget it self.

