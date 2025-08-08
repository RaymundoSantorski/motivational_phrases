import 'package:flutter/material.dart';
import 'package:motivational_phrases/models/phrase_model.dart';
import 'package:motivational_phrases/services/phrase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PhraseService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Phrases'),
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
  Phrase phrase = PhraseService.getNextPhrase();
  void getPhrase() {
    setState(() {
      phrase = PhraseService.getNextPhrase();
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.onPrimary,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: scheme.onSecondary,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: scheme.onPrimary,
        onPressed: getPhrase,
        child: Icon(Icons.arrow_forward, size: 40),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                phrase.phrase,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              Text(phrase.author),
              // SizedBox(height: 150),
            ],
          ),
        ),
      ),
    );
  }
}
