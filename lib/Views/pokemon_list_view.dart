// Flutter imports
import 'package:flutter/material.dart';
import 'package:pokemon_game/Extension/colors.dart';
import 'package:pokemon_game/Views/pokemon_card_view.dart';
import 'package:pokemon_game/Views/pokemon_details.dart';
import 'package:pokemon_game/font_extension.dart';
import 'package:provider/provider.dart';
import 'package:pokemon_game/ViewModels/home_viewmodel.dart';
import 'package:pokemon_game/Providers/search_provider.dart';
import 'package:pokemon_game/Models/pokemon_model.dart';
import 'package:pokemon_game/Utility/navigation_helper.dart';

class PokemonListView extends StatefulWidget {
  const PokemonListView({super.key});

  @override
  State<PokemonListView> createState() => _PokemonListViewState();
}

class PokemonListConsumer extends StatelessWidget {
  final Widget Function(
    BuildContext,
    HomeViewViewmodel,
    SearchProvider,
    Widget?,
  )
  builder;
  const PokemonListConsumer({Key? key, required this.builder})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeViewViewmodel, SearchProvider>(builder: builder);
  }
}

class _PokemonListViewState extends State<PokemonListView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeViewViewmodel>(
        context,
        listen: false,
      ).fetchInitialPokemon(context);
    });
  }

  Map<String, dynamic> pokemonCardToMap(PokemonCard card) {
    return {
      'id': card.id,
      'name': card.name,
      'image': card.images.small, // or large if you prefer
      // Add more fields as needed for the view
    };
  }

  @override
  Widget build(BuildContext context) {
    return PokemonListConsumer(
      builder: (context, viewModel, searchProvider, child) {
        // Keep the controller in sync only if needed
        if (_searchController.text != searchProvider.searchQuery) {
          _searchController.text = searchProvider.searchQuery;
          _searchController.selection = TextSelection.fromPosition(
            TextPosition(offset: _searchController.text.length),
          );
        }
        final filteredList = viewModel.pokemonList;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.yellowAccent.shade700,
            title:
                searchProvider.isSearching
                    ? TextField(
                      controller: _searchController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: 'Search Pokémon',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        searchProvider.setSearchQuery(value);
                        viewModel.searchPokemon(context, value);
                      },
                    )
                    : Text(
                      'Pokémon',
                      style: TextStyle(
                        color: AppColors.blackColor,
                      ).medium(fontSize: 22),
                    ),
            actions: [
              searchProvider.isSearching
                  ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      searchProvider.setSearching(false);
                      searchProvider.clearSearch();
                      viewModel.searchPokemon(context, '');
                    },
                  )
                  : IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      searchProvider.setSearching(true);
                    },
                  ),
            ],
          ),
          body: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!viewModel.isLoadingMore &&
                  scrollInfo.metrics.pixels >=
                      scrollInfo.metrics.maxScrollExtent - 200 &&
                  !viewModel.isLoading &&
                  viewModel.pokemonList.length < viewModel.totalCount) {
                viewModel.fetchMorePokemon(context);
              }
              return false;
            },
            child:
                viewModel.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : viewModel.hasNoResults
                    ? Center(
                      child: Text(
                        'No Result Found...',
                        style: TextStyle(
                          color: AppColors.blackColor,
                        ).medium(fontSize: 22),
                      ),
                    )
                    : GridView.builder(
                      controller: viewModel.scrollController,
                      padding: const EdgeInsets.all(10),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 14,
                            mainAxisSpacing: 14,
                            childAspectRatio: 3 / 2.8,
                          ),
                      itemCount:
                          filteredList.length +
                          (viewModel.isLoadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == filteredList.length &&
                            viewModel.isLoadingMore) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final pokemon = filteredList[index];
                        final pokemonMap = pokemonCardToMap(pokemon);
                        return GestureDetector(
                          onTap: () {
                            context.navigateTo(
                              PokemonDetailPage(pokemon: pokemon),
                            );
                          },
                          child: PokemonCardView(pokemon: pokemonMap),
                        );
                      },
                    ),
          ),
        );
      },
    );
  }
}
