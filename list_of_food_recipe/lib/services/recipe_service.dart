import 'package:flutter/services.dart';
import '../models/recipe.dart';

class RecipeService {
  /// Fetch recipes from JSON asset file
  Future<RecipeResponse> fetchRecipes() async {
    try {
      final jsonString = await rootBundle.loadString('assets/recipes.json');
      return RecipeResponse.fromJson(jsonString);
    } catch (e) {
      throw Exception('Failed to load recipes: $e');
    }
  }
}
