import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:motivational_phrases/models/phrase_model.dart';
import 'package:motivational_phrases/services/phrase_service.dart';
import 'package:share_plus/share_plus.dart';
=======
import 'package:motivational_phrases/services/phrase_service.dart';
>>>>>>> Stashed changes

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
<<<<<<< Updated upstream
  await PhraseService.init();
=======
  PhraseService.init();
>>>>>>> Stashed changes
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
  bool _visible = true;

  void getPhrase() {
    setState(() {
      phrase = PhraseService.getNextPhrase();
    });
    toggleVisibility();
  }

  void toggleVisibility() {
    setState(() {
      _visible = !_visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;

    Future<void> sharePhrase() async {
      ShareParams params = ShareParams(
        text: '${phrase.phrase} - ${phrase.author}',
      );
      final ShareResult result = await SharePlus.instance.share(params);

      if (result.status == ShareResultStatus.success) {
        SnackBar snackBar = SnackBar(
          backgroundColor: scheme.primaryFixedDim,
          content: Text(
            '¡Se compartió la frase!',
            textAlign: TextAlign.center,
            style: TextStyle(color: scheme.onPrimaryContainer),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    return Scaffold(
      backgroundColor: scheme.onPrimary,
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.ios_share), onPressed: sharePhrase),
        ],
        title: Text(widget.title),
        backgroundColor: scheme.onSecondary,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: scheme.onPrimary,
        onPressed: () async {
          toggleVisibility();
        },
        child: Icon(Icons.arrow_forward, size: 40),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 400),
            opacity: _visible ? 1.0 : 0.0,
            onEnd: () {
              if (!_visible) getPhrase();
            },
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
      ),
    );
  }
}
