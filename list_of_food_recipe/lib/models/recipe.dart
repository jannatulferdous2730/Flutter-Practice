import 'dart:convert';

class Recipe {
  final String title;
  final String description;
  final List<String> ingredients;

  Recipe({
    required this.title,
    required this.description,
    required this.ingredients,
  });

  /// Factory constructor to create Recipe from JSON
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['title'] as String,
      description: json['description'] as String,
      ingredients: List<String>.from(json['ingredients'] as List),
    );
  }

  /// Convert Recipe to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'ingredients': ingredients,
    };
  }

  @override
  String toString() {
    return 'Recipe(title: $title, description: $description, ingredients: $ingredients)';
  }
}

class RecipeResponse {
  final List<Recipe> recipes;

  RecipeResponse({required this.recipes});

  /// Factory constructor to parse the entire response
  factory RecipeResponse.fromJson(String jsonString) {
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    final recipeList = (json['recipes'] as List)
        .map((recipe) => Recipe.fromJson(recipe as Map<String, dynamic>))
        .toList();
    return RecipeResponse(recipes: recipeList);
  }

  @override
  String toString() {
    return 'RecipeResponse(recipes: ${recipes.length} items)';
  }
}
