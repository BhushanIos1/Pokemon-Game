import 'package:pokemon_game/Models/pokemon_model.dart';
import 'package:pokemon_game/Services/api_manager.dart';
import 'package:pokemon_game/Services/web_url.dart';
import 'package:flutter/material.dart';

class HomeRepository {
  Future<PokemonCardResponse> fetchPokemonCards({
    required BuildContext context,
    int page = 1,
    int pageSize = 20,
    String? searchQuery,
  }) async {
    String url;
    if (searchQuery != null &&
        searchQuery.isNotEmpty &&
        searchQuery.length >= 3) {
      // Use the set name search if query is 3+ chars
      url =
          '${ApiUrl.searchUrl}?q=name:$searchQuery*&page=$page&pageSize=$pageSize';
    } else {
      url = '${ApiUrl.listUrl}?page=$page&pageSize=$pageSize';
    }
    final response = await ApiManager().get(context, url);
    if (response == null) {
      return PokemonCardResponse(
        data: [],
        page: page,
        pageSize: pageSize,
        count: 0,
        totalCount: 0,
      );
    }
    return PokemonCardResponse.fromJson(response);
  }
}
