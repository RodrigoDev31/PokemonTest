// To parse this JSON data, do
//
//     final pokemonResponse = pokemonResponseFromMap(jsonString);

import 'dart:convert';

class PokemonResponse {
    PokemonResponse({
        required this.count,
        required this.next,
        this.previous,
        required this.results,
    });

  

    int count;
    String next;
    dynamic previous;
    List<Result> results;

    factory PokemonResponse.fromJson(String str) => PokemonResponse.fromMap(json.decode(str));

   

    factory PokemonResponse.fromMap(Map<String, dynamic> json) => PokemonResponse(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
    );

}

class Result {
    Result({
        required this.name,
        required this.url,
        this.id
    });


    String name;
    String url;
    String? id;

    factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  
    factory Result.fromMap(Map<String, dynamic> json) => Result(
        name: json["name"],
        url: json["url"],
    );
}
