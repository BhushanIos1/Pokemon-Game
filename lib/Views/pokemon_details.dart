import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pokemon_game/Models/pokemon_model.dart';
import 'package:pokemon_game/Extension/colors.dart';
import 'package:pokemon_game/font_extension.dart';

class PokemonDetailPage extends StatelessWidget {
  final PokemonCard pokemon;
  const PokemonDetailPage({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final set = pokemon.set;
    final screenWidth = MediaQuery.of(context).size.width;
    final imageWidth = screenWidth - 30; // 15 padding on each side

    return Scaffold(
      appBar: AppBar(
        title: Text(
          pokemon.name,
          style: TextStyle(color: AppColors.blackColor).medium(fontSize: 22),
        ),
        backgroundColor: Colors.yellowAccent.shade700,
        leading: BackButton(color: AppColors.blackColor),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image and text below
              Hero(
                tag: 'pokemon_image_${pokemon.id}',
                child: CachedNetworkImage(
                  imageUrl: pokemon.images.large,
                  width: imageWidth,
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                pokemon.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'HP: ${pokemon.hp}',
                style: TextStyle(fontSize: 16, color: AppColors.blackColor),
              ),
              Text(
                'Supertype: ${pokemon.supertype}',
                style: TextStyle(fontSize: 16, color: AppColors.blackColor),
              ),
              if (pokemon.subtypes.isNotEmpty)
                Text(
                  'Subtypes: ${pokemon.subtypes.join(', ')}',
                  style: TextStyle(fontSize: 16, color: AppColors.blackColor),
                ),
              const SizedBox(height: 18),
              // Set Info
              if (set != null) ...[
                Text(
                  'Set: ${set.name} (${set.releaseDate})',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.blackColor,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(set.images.symbol, height: 38),
                    const SizedBox(height: 8),
                    Text(
                      'Series: ${set.series}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.blackColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                const SizedBox(height: 18),
              ],
              // Attacks
              if (pokemon.attacks != null && pokemon.attacks!.isNotEmpty) ...[
                Text(
                  'Attacks:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                ...pokemon.attacks!.map(
                  (attack) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          attack.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('Cost: ${attack.cost.join(', ')}'),
                        Text('Damage: ${attack.damage}'),
                        Text('Effect: ${attack.text}'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
              // Weaknesses, Resistances, Retreat Cost
              if (pokemon.weaknesses != null && pokemon.weaknesses!.isNotEmpty)
                Text(
                  'Weaknesses: ${pokemon.weaknesses!.map((w) => '${w.type} (${w.value})').join(', ')}',
                ),
              if (pokemon.resistances != null &&
                  pokemon.resistances!.isNotEmpty)
                Text(
                  'Resistances: ${pokemon.resistances!.map((r) => '${r.type} (${r.value})').join(', ')}',
                ),
              if (pokemon.retreatCost != null &&
                  pokemon.retreatCost!.isNotEmpty)
                Text('Retreat Cost: ${pokemon.retreatCost!.join(', ')}'),
              const SizedBox(height: 12),
              // Artist, Rarity, Flavor Text
              Text('Artist: ${pokemon.artist}'),
              Text('Rarity: ${pokemon.rarity ?? 'Unknown'}'),
              if (pokemon.flavorText != null)
                Text('Flavor Text: ${pokemon.flavorText}'),
              const SizedBox(height: 18),
              // Prices
              if (pokemon.tcgplayer != null) ...[
                Text(
                  'Prices (TCGPlayer):',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ...pokemon.tcgplayer!.prices.entries.map((entry) {
                  final price = entry.value;
                  return Text(
                    'Low: \$${price.low ?? '-'}\nMid: \$${price.mid ?? '-'}\nHigh: \$${price.high ?? '-'}',
                    style: TextStyle(color: AppColors.blackColor, fontSize: 12),
                  );
                }),
              ],
              if (pokemon.cardmarket != null &&
                  pokemon.cardmarket!.prices.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  'Prices (CardMarket):',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ...pokemon.cardmarket!.prices.entries.map((entry) {
                  return Text(
                    '${entry.key.toPascalCaseWithSpaces()}: ${entry.value}',
                  );
                }),
              ],
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
