/// This library provides a customizable autocomplete widget for Flutter applications.
///
/// The `SmartAutoCompleteWidget` is a versatile widget that offers autocomplete functionality
/// for text input fields. It suggests and completes text based on a provided set of
/// suggestions. It offers various customization options to tailor the behavior and appearance
/// of the autocomplete functionality.
///
/// The `FutureWidget` is a utility widget designed to simplify asynchronous operations,
/// particularly useful for fetching data asynchronously and updating UI components based on
/// the result of those operations. It handles the asynchronous nature of futures and provides
/// builders for loading states, error states, and data states, making UI updates based on
/// future results straightforward.
///
/// Example:
/// ```dart
/// SmartAutoCompleteWidget<String>(
///   suggestionsBuilder: (context, suggestions) {
///     return ListView.builder(
///       itemCount: suggestions.length,
///       itemBuilder: (context, index) {
///         return ListTile(
///           title: Text(suggestions[index]),
///           onTap: () {
///             // Handle selection logic
///           },
///         );
///       },
///     );
///   },
///   getSuggestions: (String query) {
///     // Logic to fetch suggestions based on the query
///     return Future.value(['Apple', 'Banana', 'Orange']);
///   },
///   getAutocompletion: (String query) {
///     // Logic to fetch autocompletion for the query
///     return Future.value('suggestion');
///   },
/// ),
/// ```
///
/// The above example demonstrates how to use the `SmartAutoCompleteWidget` with custom
/// suggestion and autocompletion logic. The widget displays suggestions in a list view
/// and handles selection of suggestions accordingly. It also shows the integration of
/// the `FutureWidget` to handle asynchronous data fetching.
///
/// See [SmartAutoCompleteWidget] and [FutureWidget] classes for more details on usage
/// and customization options.
///
/// For more examples and detailed usage instructions, refer to the documentation and
/// examples provided with the package.
library smart_autocomplete;

import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'autocompletion_textfield.dart';
part 'future_widget.dart';
