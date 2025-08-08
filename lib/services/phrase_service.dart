import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:motivational_phrases/models/phrase_model.dart';

class PhraseService {
  static late List<Phrase> phrases;
  static Future<void> init() async {
    try {
      final String response = await rootBundle.loadString('data/phrases.json');
      List<dynamic> data = await json.decode(response);
      phrases = data.map((phrase) => Phrase.fromJson(phrase)).toList();
      print(data);
    } catch (error) {
      phrases = [];
      print('No se pudieron cargar las frases');
    }
  }

  static Phrase getNextPhrase() {
    Phrase nextPhrase = phrases[Random().nextInt(phrases.length)];
    phrases.removeWhere((phrase) => phrase.id == nextPhrase.id);
    if (phrases.isEmpty) PhraseService.init();
    return nextPhrase;
  }
}
