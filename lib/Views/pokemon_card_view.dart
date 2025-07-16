import 'package:flutter/material.dart';
import 'package:pokemon_game/Extension/colors.dart';
import 'package:pokemon_game/font_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PokemonCardView extends StatelessWidget {
  const PokemonCardView({super.key, required this.pokemon});

  final Map<String, dynamic> pokemon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.yellowAccent.shade700,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.3 * 255).toInt()),
            blurRadius: 2,
            offset: Offset(0, 1.5),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            flex: 8, // 80%
            child: Hero(
              tag: 'pokemon_image_${pokemon['id']}',
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black.withAlpha((0.15 * 255).toInt()),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: pokemon['image'],
                    fit: BoxFit.fill,
                    width: double.infinity,
                    placeholder:
                        (context, url) => const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                    errorWidget:
                        (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2, // 20%
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  pokemon['name'] ?? '',
                  style: TextStyle(
                    color: AppColors.blackColor,
                  ).semibold(fontSize: 18),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                //const SizedBox(height: 8), // Gap below text
              ],
            ),
          ),
        ],
      ),
    );
  }
}
