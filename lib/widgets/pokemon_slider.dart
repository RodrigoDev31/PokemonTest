import 'package:flutter/material.dart';

import '../models/models.dart';

class PokemonSliderWidget extends StatefulWidget {
  final List<Result> pokemon;
  final String? tittle;
  const PokemonSliderWidget({super.key, required this.pokemon, this.tittle});

  @override
  State<PokemonSliderWidget> createState() => _PokemonSliderWidget();
}

class _PokemonSliderWidget extends State<PokemonSliderWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 800,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.tittle != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.tittle!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 0.7,
              ),
              scrollDirection: Axis.vertical,
              itemBuilder: ((context, index) {
                final pokemon = widget.pokemon[index];
                return _PokemonContainer(
                  pokemon: pokemon,
                  heroId: "${pokemon.id}",
                );
              }),
              itemCount: widget.pokemon.length,
            ),
          )
        ],
      ),
    );
  }
}

class _PokemonContainer extends StatelessWidget {
  final Result pokemon;
  final String heroId;

  const _PokemonContainer({
    Key? key,
    required this.pokemon,
    required this.heroId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, "detail", arguments: pokemon.id),
            child: Hero(
              tag: pokemon.id!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage("assets/no-image.jpg"),
                  image: NetworkImage(
                      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${pokemon.id}.png"),
                  width: 120,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            pokemon.name.toUpperCase(),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
