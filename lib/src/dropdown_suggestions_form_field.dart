import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

import 'debounce.dart';

/// Function for creating each suggestion item inside the listView
typedef ItemBuilder<T> = Widget Function(
    BuildContext context, int index, AsyncSnapshot<List<T>> snapshot);

/// Function for creating each suggestion item separator inside the listView
typedef SeparatorBuilder = Widget Function(BuildContext context, int index);

/// Function for filtering the list with possible suggestions in relation with
/// the text form field value
typedef Filter = Function(String string);

/// The dropdown suggestion form field widget provides a list of suggestions
/// while typing into a text form field.
/// The widget can be used with a default or a custom item builder,
/// separator builder and a filter method.
/// The text form field and the card widget inside the overlay can be
/// customized too.
/// When no suggestion are found or the filter method is processing the
/// list of items the dropdown will show a message that can be
/// customized with a custom message or a custom widget.
class DropdownSuggestionsFormField<T> extends StatefulWidget {
  /// autocorrect parameter passed to the text form field
  final bool autocorrect;

  /// autovalidate parameter passed to the text form field
  final bool autovalidate;

  /// buildCounter parameter passed to the text form field
  final InputCounterWidgetBuilder buildCounter;

  /// BorderOnForeground for styling the card inside the overlay
  final bool cardBorderOnForeground;

  /// Background color for styling the card inside the overlay
  final Color cardColor;

  /// Elevation for styling the card inside the overlay
  final double cardElevation;

  /// Shape border for styling the card inside the overlay
  final ShapeBorder cardShape;

  /// cursorWidth parameter passed to the text form field
  final double cursorWidth;

  /// cursorColor parameter passed to the text form field
  final Color cursorColor;

  /// cursorRadius parameter passed to the text form field
  final Radius cursorRadius;

  /// decoration parameter passed to the text form field
  final InputDecoration decoration;

  /// enabled parameter passed to the text form field
  final bool enabled;

  /// enableInteractiveSelection parameter passed to the text form field
  final bool enableInteractiveSelection;

  /// enableSuggestions parameter passed to the text form field
  final bool enableSuggestions;

  /// expands parameter passed to the text form field
  final bool expands;

  /// Filter function
  /// If it's null a default filter will be applied
  final Filter filter;

  /// initialValue parameter passed to the text form field
  /// If it's not null the items will be filtered for first time with this value
  final String initialValue;

  /// inputFormatters parameter passed to the text form field
  final List<TextInputFormatter> inputFormatters;

  /// Suggested items builder function
  /// If it's null a default items builder will be used
  final ItemBuilder<T> itemBuilder;

  /// List of items that will be filtered.
  final List<T> items;

  /// keyboardAppearance parameter passed to the text form field
  final Brightness keyboardAppearance;

  /// keyboardType parameter passed to the text form field
  final TextInputType keyboardType;

  /// maxLength parameter passed to the text form field
  final int maxLength;

  /// maxLengthEnforced parameter passed to the text form field
  final bool maxLengthEnforced;

  /// maxLines parameter passed to the text form field
  final int maxLines;

  /// minLines parameter passed to the text form field
  final int minLines;

  /// Delay in milliseconds used for preventing unnecessary calls to the
  /// filter method when the text field changes too quickly
  final int onChangedDebounceDuration;

  /// Overlay offset position.
  /// Relative to the left and bottom sides of the text input
  final Offset offset;

  /// Return the selected suggestion.
  final ValueChanged<T> onSelected;

  /// readOnly parameter passed to the text form field
  final bool readOnly;

  /// scrollPadding parameter passed to the text form field
  final EdgeInsets scrollPadding;

  /// Suggested items separator at the listView
  final SeparatorBuilder separatorBuilder;

  /// showCursor parameter passed to the text form field
  final bool showCursor;

  /// strutStyle parameter passed to the text form field
  final StrutStyle strutStyle;

  /// Max height for the suggestions overlay
  final double suggestionMaxHeight;

  /// Margin for the suggestion overlay
  final EdgeInsets suggestionMargin;

  /// Widget displayed when the are no suggestions
  final Widget suggestionNotMatch;

  /// Message displayed when the are no suggestions
  final String suggestionNotMatchMessage;

  /// Widget displayed when the stream is waiting for the suggestions
  final Widget suggestionWaiting;

  /// Check if a waiting suggestions widget has to be displayed while
  /// the stream is waiting for the suggestions
  final bool suggestionWaitingIsActive;

  /// Message displayed when the stream is waiting for the suggestions
  final String suggestionWaitingMessage;

  /// textAlign parameter passed to the text form field
  final TextAlign textAlign;

  /// textAlignVertical parameter passed to the text form field
  final TextAlignVertical textAlignVertical;

  /// textCapitalization parameter passed to the text form field
  final TextCapitalization textCapitalization;

  /// textDirection parameter passed to the text form field
  final TextDirection textDirection;

  /// textInputAction parameter passed to the text form field
  final TextInputAction textInputAction;

  /// textStyle parameter passed to the text form field
  final TextStyle textStyle;

  /// toolbarOptions parameter passed to the text form field
  final ToolbarOptions toolbarOptions;

  /// Callback that is called after the text form field changes
  final ValueChanged<String> onChanged;

  /// onEditingComplete parameter passed to the text form field
  final VoidCallback onEditingComplete;

  /// onFieldSubmitted parameter passed to the text form field
  final ValueChanged<String> onFieldSubmitted;

  /// onSaved parameter passed to the text form field
  final FormFieldSetter<String> onSaved;

  /// onTap parameter passed to the text form field
  final GestureTapCallback onTap;

  /// validator parameter passed to the text form field
  final FormFieldValidator<String> validator;

  DropdownSuggestionsFormField({
    key,
    this.autocorrect: true,
    this.autovalidate: false,
    this.buildCounter,
    this.cardColor: Colors.white,
    this.cardBorderOnForeground: true,
    this.cardElevation: 1.0,
    this.cardShape,
    this.cursorWidth: 2.0,
    this.cursorColor,
    this.cursorRadius,
    this.decoration,
    this.enabled: true,
    this.enableInteractiveSelection: true,
    this.enableSuggestions: true,
    this.expands: false,
    this.filter,
    this.initialValue,
    this.inputFormatters,
    this.itemBuilder,
    this.items,
    this.keyboardAppearance,
    this.keyboardType,
    this.maxLength,
    this.maxLengthEnforced: true,
    this.maxLines: 1,
    this.minLines,
    this.onChangedDebounceDuration: 200,
    this.offset: const Offset(0.0, 2.0),
    this.onSelected,
    this.readOnly: false,
    this.scrollPadding: const EdgeInsets.all(20.0),
    this.separatorBuilder,
    this.showCursor,
    this.strutStyle,
    this.suggestionNotMatch,
    this.suggestionNotMatchMessage: 'No matching suggestions',
    this.suggestionMaxHeight: 250.0,
    this.suggestionMargin: const EdgeInsets.all(0.0),
    this.suggestionWaiting,
    this.suggestionWaitingIsActive: true,
    this.suggestionWaitingMessage: 'Waiting for suggestions',
    this.textAlign: TextAlign.start,
    this.textAlignVertical,
    this.textCapitalization: TextCapitalization.none,
    this.textDirection,
    this.textInputAction,
    this.textStyle,
    this.toolbarOptions,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.onTap,
    this.validator,
  }) : super(key: key);

  @override
  DropdownSuggestionsFormFieldState<T> createState() =>
      DropdownSuggestionsFormFieldState<T>();
}

/// The state is not private
/// The widget state can be used with a GlobalKey and access to the onSelected
/// method and the text form field controller.
class DropdownSuggestionsFormFieldState<T>
    extends State<DropdownSuggestionsFormField<T>> {
  /// Debounce used for preventing unnecessary calls to the filter method when
  /// the text field changes too quickly.
  Debounce _onChangedDebounce;

  /// Stream controller for emit and receive a filtered list with suggestions.
  BehaviorSubject<List<T>> _streamController = BehaviorSubject<List<T>>();

  /// Focus node for listen if the text field has focus or not.
  /// When the text field get focused the overlay will be created and inserted,
  /// when it's loss focus the overlay will be removed.
  FocusNode _focusNode;

  /// Public text form field controller.
  TextEditingController controller;

  /// Layer link for linking the CompositedTransformFollower
  /// with the CompositedTransformTarget.
  LayerLink _layerLink;

  /// Overlay used for showing the list with suggestions
  OverlayEntry _overlayEntry;

  @override
  void initState() {
    super.initState();

    /// Initialize the text editing controller with a initial value.
    controller = TextEditingController(
        text: widget.initialValue != null ? widget.initialValue : '');
    _layerLink = LayerLink();
    _onChangedDebounce =
        Debounce(milliseconds: widget.onChangedDebounceDuration);
    _focusNode = FocusNode()
      ..addListener(() {
        if (_focusNode.hasFocus) {
          /// Show the overlay when the text form field get focused
          _overlayEntry = overlayEntry();
          Overlay.of(context).insert(_overlayEntry);

          /// Filter the list base on the text form field value
          _sink(controller.text);
        } else {
          /// Hide the overlay when the text form field loss focus
          _overlayEntry.remove();
        }
      });
  }

  @override
  dispose() {
    super.dispose();
    controller.dispose();
    _focusNode.dispose();
    _streamController.close();
  }

  OverlayEntry overlayEntry() {
    /// Get the widget size for setting the overlay width and offset position
    RenderBox _box = context.findRenderObject();
    Size size = _box.size;

    return OverlayEntry(builder: (BuildContext context) {
      return Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          showWhenUnlinked: false,
          link: _layerLink,
          offset: Offset(widget.offset.dx, size.height + widget.offset.dy),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: widget.suggestionMaxHeight),
            child: Card(
              color: widget.cardColor,
              borderOnForeground: widget.cardBorderOnForeground,
              elevation: widget.cardElevation,
              margin: widget.suggestionMargin,
              shape: widget.cardShape,
              child: StreamBuilder(
                stream: _streamController.stream,
                builder:
                    (BuildContext context, AsyncSnapshot<List<T>> snapshot) {
                  if (snapshot.hasData &&
                      controller.text.isNotEmpty &&
                      snapshot.data.length > 0) {
                    return _listView(snapshot);
                  }
                  if (snapshot.connectionState == ConnectionState.waiting &&
                      controller.text.isNotEmpty) {
                    if (widget.items != null || widget.filter != null) {
                      return _suggestionWaiting();
                    }
                  }
                  if ((snapshot.connectionState == ConnectionState.active ||
                      snapshot.connectionState == ConnectionState.done) &&
                      controller.text.isNotEmpty) {
                    if (widget.items != null || widget.filter != null) {
                      return _suggestionNotMatch();
                    }
                  }
                  return _suggestionEmptyWidget();
                },
              ),
            ),
          ),
        ),
      );
    });
  }

  /// Widget for displaying a waiting message
  Widget _suggestionWaiting() {
    return widget.suggestionWaitingIsActive == false
        ? _suggestionEmptyWidget()
        : (widget.suggestionWaiting != null
        ? widget.suggestionWaiting
        : Container(
        padding: EdgeInsets.all(10.0),
        child: Text(widget.suggestionWaitingMessage)));
  }

  /// Widget for displaying no match message
  Widget _suggestionNotMatch() {
    return widget.suggestionNotMatch != null
        ? widget.suggestionNotMatch
        : Container(
        padding: EdgeInsets.all(10.0),
        child: Text(widget.suggestionNotMatchMessage));
  }

  /// Widget used inside the listView when the stream has an error, has
  /// empty data or is waiting for suggestions and the parameter
  /// suggestionWaitingIsActive is set to false
  Widget _suggestionEmptyWidget() {
    return SizedBox(
      height: 0.0,
    );
  }

  /// Create a list view builder with a item builder for showing the suggestions.
  /// A default item builder will be used if the itemBuilder argument is null.
  /// A default separator builder will be used if the separatorBuilder argument
  /// is null.
  ListView _listView(AsyncSnapshot<List<T>> snapshot) {
    return ListView.separated(
      padding: EdgeInsets.all(0.0),
      addRepaintBoundaries: false,
      shrinkWrap: true,
      itemBuilder: widget.itemBuilder != null
          ? (BuildContext context, int index) =>
          widget.itemBuilder(context, index, snapshot)
          : (BuildContext context, int index) =>
          itemBuilder(context, index, snapshot),
      separatorBuilder: widget.separatorBuilder != null
          ? (BuildContext context, int index) =>
          widget.separatorBuilder(context, index)
          : (BuildContext context, int index) =>
          separatorBuilder(context, index),
      itemCount: snapshot.data.length,
    );
  }

  /// Default Item builder used if the itemBuilder parameter is null
  Widget itemBuilder(
      BuildContext context, int index, AsyncSnapshot<List<T>> snapshot) {
    T suggestion = snapshot.data.elementAt(index);
    return ListTile(
      onTap: () => onSelect(suggestion),
      title: Text('${suggestion}'),
    );
  }

  /// Default separator builder used if the separatorBuilder parameter is null
  Widget separatorBuilder(BuildContext context, int index) {
    return Divider();
  }

  /// Public callback for reporting that a suggestion has been selected.
  /// When a custom itemBuilder is used, this method can be called using a
  /// GlobalKey<DropdownSuggestionFormFieldState> as key for this widget
  void onSelect(T suggestion) {
    controller.text = suggestion as String;
    _focusNode.unfocus();
    widget.onSelected(suggestion);
  }

  /// Listen for text changes at the text form field.
  /// Call onSelected with a null value.
  /// Call the sink method after a period of time.
  /// Execute a the custom onChanged method if one is passed to the widget.
  void _onChanged(String string) async {
    widget.onSelected(null);
    _onChangedDebounce.run(() {
      _sink(string);
    });
    if (widget.onChanged != null) {
      widget.onChanged(string);
    }
  }

  /// Add a filtered list to the stream controller so the streamBuilder can
  /// rebuild the listView items with the filtered suggestions.
  void _sink(String string) {
    _streamController.sink
        .add(widget.filter != null ? widget.filter(string) : _filter(string));
  }

  /// Return a filtered list with the suggestions
  List<T> _filter(String string) {
    if (widget.items != null) {
      return widget.items.where((element) {
        return (element as String)
            .toLowerCase()
            .startsWith(string.toLowerCase());
      }).toList();
    }
    return [];
  }

  /// Dismiss the overlay when the back button is pressed
  Future<bool> _onWillPop() async {
    if (_focusNode.hasFocus && _overlayEntry != null) {
      _focusNode.unfocus();
      return false;
    }
    return true;
  }

  TextFormField textFormField() {
    return TextFormField(
      autocorrect: widget.autocorrect,
      autovalidate: widget.autovalidate,
      buildCounter: widget.buildCounter,
      controller: controller,
      cursorColor: widget.cursorColor,
      cursorRadius: widget.cursorRadius,
      cursorWidth: widget.cursorWidth,
      decoration: widget.decoration,
      enabled: widget.enabled,
      enableSuggestions: widget.enableSuggestions,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      expands: widget.expands,
      focusNode: _focusNode,
      inputFormatters: widget.inputFormatters,
      keyboardAppearance: widget.keyboardAppearance,
      keyboardType: widget.keyboardType,
      maxLength: widget.maxLength,
      maxLengthEnforced: widget.maxLengthEnforced,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      readOnly: widget.readOnly,
      scrollPadding: widget.scrollPadding,
      showCursor: widget.showCursor,
      strutStyle: widget.strutStyle,
      style: widget.textStyle,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      textCapitalization: widget.textCapitalization,
      textDirection: widget.textDirection,
      textInputAction: widget.textInputAction,
      toolbarOptions: widget.toolbarOptions,
      onChanged: (String string) => _onChanged(string),
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,
      onTap: widget.onTap,
      validator: widget.validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: CompositedTransformTarget(
        link: _layerLink,
        child: textFormField(),
      ),
      onWillPop: _onWillPop,
    );
  }
}
