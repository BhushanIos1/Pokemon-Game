// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_game/Models/pokemon_model.dart';

void main() {
  group('PokemonCard', () {
    test('fromJson with int id', () {
      final json = {'name': 'Pikachu', 'id': 25};
      final model = PokemonCard.fromJson(json);
      expect(model.id, 25); // stays int
    });

    test('fromJson with string id', () {
      final json = {'name': 'Pikachu', 'id': '25'};
      final model = PokemonCard.fromJson(json);
      expect(model.id, '25'); // stays string
    });
  });
}

