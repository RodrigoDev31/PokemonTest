import 'package:flutter/material.dart';
import 'package:movies_flutter/providers/pokemon_provider.dart';
import 'package:movies_flutter/widgets/pokemon_slider.dart';
import 'package:movies_flutter/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../search/search_delegate.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Pokedex"),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: (() => showSearch(
                    context: context, delegate: PokemonSearchDelegate())),
                icon: const Icon(Icons.search))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              PokemonSliderWidget(
                pokemon: pokemonProvider.PokemonsOnList,
              )
            ],
          ),
        ));
  }
}
