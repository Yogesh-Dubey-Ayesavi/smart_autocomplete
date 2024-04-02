part of 'smart_autocomplete.dart';

typedef GetSuggestionsCallback<T> = Future<List<T>> Function(String searchKey);
typedef GetAutocompletionCallback<T> = Future<T?> Function(String searchKey);

class SmartAutoCompleteWidget<T> extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final UndoHistoryController? undoController;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool readOnly;
  final bool? showCursor;
  final bool autofocus;
  final MaterialStatesController? statesController;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool enableSuggestions;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final void Function(String, Map<String, dynamic>)? onAppPrivateCommand;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final double cursorWidth;
  final double? cursorHeight;
  final Widget Function(
          BuildContext context, EditableTextState editableTextState)?
      contextMenuBuilder;
  final Radius? cursorRadius;
  final bool? cursorOpacityAnimates;
  final Color? cursorColor;
  final Color? cursorErrorColor;
  final BoxHeightStyle selectionHeightStyle;
  final BoxWidthStyle selectionWidthStyle;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final DragStartBehavior dragStartBehavior;
  final bool? enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final VoidCallback? onTap;
  final bool onTapAlwaysCalled;
  final void Function(PointerDownEvent)? onTapOutside;
  final MouseCursor? mouseCursor;
  final Widget? Function(BuildContext,
      {required int currentLength,
      required bool isFocused,
      required int? maxLength})? buildCounter;
  final ScrollController? scrollController;
  final ScrollPhysics? scrollPhysics;
  final Iterable<String>? autofillHints;
  final ContentInsertionConfiguration? contentInsertionConfiguration;
  final Clip clipBehavior;
  final String? restorationId;
  final bool scribbleEnabled;
  final bool enableIMEPersonalizedLearning;
  final bool canRequestFocus;
  final SpellCheckConfiguration? spellCheckConfiguration;
  final TextMagnifierConfiguration? magnifierConfiguration;

  /// A builder function used to construct a widget to display while data for
  /// suggestions is being fetched asynchronously.
  ///
  /// Example:
  /// ```dart
  /// loadingWidgetBuilder: () {
  ///   return Center(
  ///     child: CircularProgressIndicator(),
  ///   );
  /// },
  /// ```
  ///
  /// If not provided, a default circular progress indicator is displayed.
  final Widget Function()? loadingWidgetBuilder;

  /// A builder function used to construct a widget to display when an error occurs while
  /// fetching data for suggestions.
  ///
  /// Example:
  /// ```dart
  /// errorBuilder: (context, error) {
  ///   return Text('An error occurred: $error');
  /// },
  /// ```
  ///
  /// If not provided, a default error message is displayed.
  final Widget Function(BuildContext context, Object error)? errorBuilder;

  /// A builder function used to construct widgets based on the list of suggestions
  /// obtained from the [getSuggestions].
  /// This function is called when the suggestions has successfully fetched
  /// based on the user input. It allows users to customize the rendering
  /// of the suggestion list based on the provided data.
  /// Example:
  /// ```dart
  /// suggestionsBuilder: (context, suggestions) {
  ///   return ListView.builder(
  ///     itemCount: suggestions.length,
  ///     itemBuilder: (context, index) {
  ///       return ListTile(
  ///         title: Text(suggestions[index]),
  ///         onTap: () {
  ///           // Handle selection logic
  ///         },
  ///       );
  ///     },
  ///   );
  /// },
  /// ```
  ///
  /// Users can define any widget structure to display suggestions, such as a list view
  /// or a grid view, with custom tap handlers for selection.
  final Widget Function(BuildContext context, List<T> data) suggestionsBuilder;

  /// A callback function used to fetch suggestions based on a provided keyword or query.
  /// from the textfield
  /// This callback is invoked when the suggestionBuilder widget needs to obtain suggestions
  /// based on the user input. Users should implement the logic to fetch and return
  /// a list of suggestions relevant to the provided keyword or query.
  ///
  /// Example:
  /// ```dart
  /// getSuggestions: (String keyword) async {
  ///  //Implement logic to fetch suggestions from a data source
  ///   return ['apple','apricot','avocado'];
  /// },
  /// ```
  /// ![suggestions](graphics/suggestions.png)
  final GetSuggestionsCallback<T> getSuggestions;

  /// A callback function used to fetch autocompletion for a given input text.
  /// This callback is invoked when the user writes something inside the textfield.
  ///
  /// Example:
  /// ```dart
  /// getAutocompletion: (String inputText)async {
  ///   // Suppose User has written inside textfield 'W'
  ///   // then you can give recommendation like
  ///   return 'What is Ram Mandir?'
  /// },
  /// ```
  /// - `Null` is returned when there is no match
  /// - `String` is returned when there is a match
  /// ![autocompletion](graphics/autocomplete.png)
  final GetAutocompletionCallback<String> getAutocompletion;

  const SmartAutoCompleteWidget({
    super.key,
    this.controller,
    this.focusNode,
    this.undoController,
    this.decoration,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.readOnly = false,
    this.showCursor,
    this.autofocus = false,
    this.statesController,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorOpacityAnimates,
    this.cursorColor,
    this.cursorErrorColor,
    this.selectionHeightStyle = BoxHeightStyle.tight,
    this.selectionWidthStyle = BoxWidthStyle.tight,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableInteractiveSelection,
    this.selectionControls,
    this.onTap,
    this.onTapAlwaysCalled = false,
    this.onTapOutside,
    this.mouseCursor,
    this.buildCounter,
    this.scrollController,
    this.scrollPhysics,
    this.autofillHints,
    this.contentInsertionConfiguration,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.scribbleEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.canRequestFocus = true,
    this.spellCheckConfiguration,
    this.magnifierConfiguration,
    this.loadingWidgetBuilder,
    this.errorBuilder,
    required this.suggestionsBuilder,
    required this.getSuggestions,
    required this.getAutocompletion,
    this.contextMenuBuilder,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SmartAutoCompleteWidgetState<T> createState() =>
      _SmartAutoCompleteWidgetState<T>();
}

class _SmartAutoCompleteWidgetState<T>
    extends State<SmartAutoCompleteWidget<T>> {
  late TextEditingController _controller;
  final ValueNotifier<String> notifier = ValueNotifier<String>('');
  final _popped = <String>[];
  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    notifier.dispose();
    super.dispose();
  }

  void _selectSuggestion(String text) async {
    var suggestion =
        (await widget.getAutocompletion(text))?.substring(text.length) ?? '';
    Future.delayed(const Duration(milliseconds: 200), () {
      if (!_popped.contains(suggestion)) {
        var baseOffset = text.length;
        var newText = text + suggestion;
        var extentOffset = newText.length;
        _controller.text = newText;
        _controller.selection = TextSelection(
          baseOffset: baseOffset,
          extentOffset: extentOffset,
          isDirectional: true,
        );
        _popped.add(suggestion);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          focusNode: widget.focusNode,
          decoration: widget.decoration ??
              const InputDecoration(labelText: 'Enter Search Keyword'),
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          textCapitalization: widget.textCapitalization,
          style: widget.style,
          strutStyle: widget.strutStyle,
          textAlign: widget.textAlign,
          textAlignVertical: widget.textAlignVertical,
          textDirection: widget.textDirection,
          readOnly: widget.readOnly,
          contextMenuBuilder: widget.contextMenuBuilder,
          showCursor: widget.showCursor,
          autofocus: widget.autofocus,
          obscuringCharacter: widget.obscuringCharacter,
          obscureText: widget.obscureText,
          autocorrect: widget.autocorrect,
          smartDashesType: widget.smartDashesType,
          smartQuotesType: widget.smartQuotesType,
          enableSuggestions: widget.enableSuggestions,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          expands: widget.expands,
          maxLength: widget.maxLength,
          maxLengthEnforcement: widget.maxLengthEnforcement,
          onChanged: (t) async {
            _selectSuggestion(t);
            notifier.value = t;
            if (t.trim().isEmpty) {
              // _popped.removeRange(0, _popped.length);
            }
            widget.onChanged?.call(t);
          },
          onEditingComplete: widget.onEditingComplete,
          onSubmitted: widget.onSubmitted,
          onAppPrivateCommand: widget.onAppPrivateCommand,
          inputFormatters: widget.inputFormatters,
          enabled: widget.enabled,
          cursorWidth: widget.cursorWidth,
          cursorHeight: widget.cursorHeight,
          cursorRadius: widget.cursorRadius,
          cursorOpacityAnimates: widget.cursorOpacityAnimates,
          cursorColor: widget.cursorColor,
          cursorErrorColor: widget.cursorErrorColor,
          selectionHeightStyle: widget.selectionHeightStyle,
          selectionWidthStyle: widget.selectionWidthStyle,
          keyboardAppearance: widget.keyboardAppearance,
          scrollPadding: widget.scrollPadding,
          dragStartBehavior: widget.dragStartBehavior,
          enableInteractiveSelection: widget.enableInteractiveSelection,
          selectionControls: widget.selectionControls,
          onTap: widget.onTap,
          onTapAlwaysCalled: widget.onTapAlwaysCalled,
          onTapOutside: widget.onTapOutside,
          mouseCursor: widget.mouseCursor,
          buildCounter: widget.buildCounter,
          scrollController: widget.scrollController,
          scrollPhysics: widget.scrollPhysics,
          autofillHints: widget.autofillHints,
          contentInsertionConfiguration: widget.contentInsertionConfiguration,
          clipBehavior: widget.clipBehavior,
          restorationId: widget.restorationId,
          scribbleEnabled: widget.scribbleEnabled,
          enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
          canRequestFocus: widget.canRequestFocus,
          spellCheckConfiguration: widget.spellCheckConfiguration,
          magnifierConfiguration: widget.magnifierConfiguration,
        ),
        ValueListenableBuilder<String>(
          valueListenable: notifier,
          builder: (BuildContext context, String value, Widget? child) {
            final trimmedValue = value.trim();
            if (trimmedValue.isNotEmpty) {
              final suggestions =
                  widget.getSuggestions(trimmedValue.toLowerCase());
              return FutureWidget<List<T>>(
                future: suggestions,
                loading: (context, snapshot) {
                  return widget.loadingWidgetBuilder?.call() ??
                      const Center(
                        child: CircularProgressIndicator(),
                      );
                },
                error: (context, error) {
                  return widget.errorBuilder?.call(context, error) ??
                      const Text('An error occurred');
                },
                data: (context, data) {
                  return widget.suggestionsBuilder(context, data);
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
