import 'package:flutter/widgets.dart';
import 'package:pokemon_game/Models/pokemon_model.dart';
import 'package:pokemon_game/Repository/home_repository.dart';
import 'package:flutter/material.dart';

class HomeViewViewmodel with ChangeNotifier {
  final HomeRepository _repository = HomeRepository();

  List<PokemonCard> _pokemonList = [];
  List<PokemonCard> get pokemonList => _pokemonList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  int _currentPage = 1;
  int _pageSize = 10;
  int _totalCount = 0;
  int get totalCount => _totalCount;
  String _searchQuery = '';

  bool get hasNoResults => _pokemonList.isEmpty && !_isLoading;

  final ScrollController scrollController = ScrollController();

  HomeViewViewmodel() {
    scrollController.addListener(_onScroll);
  }

  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchInitialPokemon(BuildContext context) async {
    _isLoading = true;
    _currentPage = 1;
    _pokemonList = [];
    notifyListeners();
    try {
      final response = await _repository.fetchPokemonCards(
        context: context,
        page: _currentPage,
        pageSize: _pageSize,
        searchQuery: _searchQuery,
      );
      _pokemonList = response.data;
      _totalCount = response.totalCount;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMorePokemon(BuildContext context) async {
    if (_isLoadingMore || _pokemonList.length >= _totalCount) return;
    _isLoadingMore = true;
    notifyListeners();
    try {
      final response = await _repository.fetchPokemonCards(
        context: context,
        page: _currentPage + 1,
        pageSize: _pageSize,
        searchQuery: _searchQuery,
      );
      _currentPage++;
      _pokemonList.addAll(response.data);
    } finally {
      _isLoadingMore = false;
      notifyListeners();
    }
  }

  void searchPokemon(BuildContext context, String query) async {
    _searchQuery = query;
    if (query.isEmpty || query.length >= 3) {
      await fetchInitialPokemon(context);
    } else {
      // If less than 3 chars, clear the list
      _pokemonList = [];
      notifyListeners();
    }
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      // Near the bottom
      // Note: context is not available here, so pagination should be triggered from the view
    }
  }
}
