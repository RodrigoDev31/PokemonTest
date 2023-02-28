import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_flutter/models/models.dart';
import 'package:provider/provider.dart';
import '../providers/pokemon_provider.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String pokemon = ModalRoute.of(context)!.settings.arguments as String;

    final pokemonProvider =
        Provider.of<PokemonProvider>(context, listen: false);

    final size = MediaQuery.of(context).size;

    return FutureBuilder(
      builder: (BuildContext context,
          AsyncSnapshot<PokemonDetailResponse> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            color: Colors.white,
            width: double.infinity,
            height: size.height * 0.5,
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        final pokemonInfo = snapshot.data!;

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              _CustomAppBar(pokemon: pokemonInfo),
              SliverList(
                  delegate: SliverChildListDelegate.fixed([
                _PosterAndTittle(pokemon: pokemonInfo),
                SizedBox(
                  height: 20,
                ),
                Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: _CustomColumn(pokemon: pokemonInfo))
              ]))
            ],
          ),
        );
      },
      future: pokemonProvider.getPokemon(pokemon),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final PokemonDetailResponse pokemon;
  const _CustomAppBar({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.amber,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          width: double.infinity,
          child: Text(
            pokemon.name.toUpperCase(),
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage("assets/loading.gif"),
          image: NetworkImage(
              "https://www.gamingscan.com/wp-content/uploads/2020/08/Pokemon-Fan-Game.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTittle extends StatelessWidget {
  final PokemonDetailResponse pokemon;
  const _PosterAndTittle({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: pokemon.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage("assets/no-image.jpg"),
                image: NetworkImage(
                    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${pokemon.id}.png"),
                height: 150,
              ),
            ),
          ),
          const SizedBox(width: 20),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 190),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Id: ${pokemon.id.toString()}",
                  style: textTheme.headlineSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  "Base exp: ${pokemon.baseExperience}",
                  style: textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _CustomColumn extends StatelessWidget {
  final PokemonDetailResponse pokemon;
  const _CustomColumn({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Cantidad de habilidades: ${pokemon.abilities.length}",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Text(
          "Habilidades:",
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: pokemon.abilities.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                leading: const Icon(Icons.bookmark),
                title:
                    Text(pokemon.abilities[index].ability.name.toUpperCase()));
          },
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Cantidad de Movimientos: ${pokemon.moves.length}",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Text(
          "Movimientos:",
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: pokemon.moves.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                leading: const Icon(Icons.move_up),
                title: Text(pokemon.moves[index].move.name.toUpperCase()));
          },
        ),
      ],
    );
  }
}
