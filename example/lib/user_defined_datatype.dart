import 'dart:math';

import 'package:example/chrome_history.dart';
import 'package:flutter/material.dart';
import 'package:smart_autocomplete/smart_autocomplete.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.greenAccent, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.red, brightness: Brightness.light),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Smart Auto Complete'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Data {
  final String id;
  final String text;
  const Data({required this.id, required this.text});
}

List<Data> getData() {
  return chromeHistory
      .map((e) => Data(id: Random().nextInt(300).toString(), text: e))
      .toList();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController controller = TextEditingController();
  final data = getData();

  Future<List<Data>> getSuggestions(String key) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return data.where((e) => e.text.toLowerCase().startsWith(key)).toList();
  }

  Future<String?> getAutoCompletion(String text) async {
    if (text.isEmpty) {
      return null;
    }
    await Future.delayed(const Duration(milliseconds: 500));
    var input = text.toLowerCase();
    var sortedOptions = data
        .where((option) => option.text.toLowerCase().startsWith(input))
        .toList();
    sortedOptions.sort((a, b) => a.text.length.compareTo(b.text.length));

    if (sortedOptions.isNotEmpty) {
      var completion = sortedOptions.first;
      return completion.text.substring(input.length);
    } else {
      return null;
    }
  }

  bool showSuggestions =
      true; // Add a flag to control whether to show suggestions

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8.00),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(10.0), // Adjust the value as needed
                  color: Theme.of(context)
                      .colorScheme
                      .onInverseSurface, // Adjust color as needed
                ),
                child: SmartAutoCompleteWidget<Data>(
                    controller: controller,
                    loadingWidgetBuilder: () => showSuggestions
                        ? const SizedBox(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                              ],
                            ))
                        : const SizedBox.shrink(),
                    suggestionsBuilder: (context, data) {
                      if (!showSuggestions || data.isEmpty) {
                        return const SizedBox.shrink();
                      } else {
                        return LimitedBox(
                          maxHeight: 300,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final item = data[index];
                              return ListTile(
                                title: Text(item.text),
                                onTap: () {
                                  controller.text = item.text;
                                  setState(() {
                                    showSuggestions = false;
                                  });
                                },
                              );
                            },
                          ),
                        );
                      }
                    },
                    getSuggestions: getSuggestions,
                    onChanged: (f) {
                      setState(() {
                        showSuggestions = true;
                      });
                    },
                    getAutocompletion: getAutoCompletion),
              )
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
