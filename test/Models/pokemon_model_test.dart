import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_game/Models/pokemon_model.dart';

void main() {
  group('PokemonModel', () {
    test('fromJson and toJson', () {
      final json = {'name': 'Pikachu', 'id': 25};
      final model = PokemonCard.fromJson(json);
      expect(model.name, 'Pikachu');
      expect(model.id, 25);
    });
  });
}
