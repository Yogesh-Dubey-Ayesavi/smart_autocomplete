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
      title: 'Smart AutoComplete Demo',
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.greenAccent, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.greenAccent, brightness: Brightness.light),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Smart Auto Complete'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController controller = TextEditingController();

  Future<List<String>> getSuggestions(String key) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return chromeHistory.where((e) => e.toLowerCase().startsWith(key)).toList();
  }

  Future<String?> getAutoCompletion(String text) async {
    if (text.isEmpty) {
      return null;
    }
    await Future.delayed(const Duration(milliseconds: 500));
    var input = text.toLowerCase();
    var sortedOptions = chromeHistory
        .where((option) => option.toLowerCase().startsWith(input))
        .toList();
    sortedOptions.sort((a, b) => a.length.compareTo(b.length));

    if (sortedOptions.isNotEmpty) {
      var completion = sortedOptions.first;
      return completion;
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
                child: SmartAutoCompleteWidget<String>(
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
                                title: Text(item),
                                onTap: () {
                                  controller.text = item;
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
