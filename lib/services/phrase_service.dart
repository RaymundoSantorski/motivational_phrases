import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:motivational_phrases/models/phrase_model.dart';

class PhraseService {
  static late List<Phrase> phrases;
  static Future<void> init() async {
    final String response = await rootBundle.loadString('data/phrases.json');
    List<dynamic> data = await json.decode(response);
    phrases = data.map((phrase) => Phrase.fromJson(phrase)).toList();
    print(data);
  }
}
