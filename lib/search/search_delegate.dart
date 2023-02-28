import 'package:flutter/material.dart';
import 'package:movies_flutter/models/models.dart';
import 'package:movies_flutter/providers/pokemon_provider.dart';
import 'package:provider/provider.dart';

class PokemonSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar Pokemon';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }

    final moviesProvider = Provider.of<PokemonProvider>(context, listen: false);

    return FutureBuilder(
      builder: (BuildContext context,
          AsyncSnapshot<PokemonDetailResponse?> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            width: double.infinity,
            height: 500,
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        final pokemonInfo = snapshot.data!;

        return _MovieItem(pokemonInfo);
      },
      future: moviesProvider.searchPokemon(query),
    );
  }

  Widget _emptyContainer() {
    return Container(
      child: Center(
        child: Icon(
          Icons.dangerous,
          color: Colors.black38,
          size: 130,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _emptyContainer();
  }
}

class _MovieItem extends StatelessWidget {
  final PokemonDetailResponse movie;

  const _MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Hero(
        tag: movie.name,
        child: FadeInImage(
          placeholder: AssetImage('assets/no-image.jpg'),
          image: NetworkImage(
              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${movie.id}.png"),
          width: 50,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(movie.name.toUpperCase()),
      onTap: () {
        Navigator.pushNamed(context, 'detail', arguments: movie.id.toString());
      },
    );
  }
}
