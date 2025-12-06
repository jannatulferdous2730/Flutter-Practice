import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/recipe_service.dart';

class RecipeViewModel extends ChangeNotifier {
  final RecipeService _recipeService = RecipeService();

  List<Recipe> _recipes = [];
  bool _isLoading = false;
  String? _error;

  /// Getters
  List<Recipe> get recipes => _recipes;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Initialize and load recipes
  Future<void> loadRecipes() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _recipeService.fetchRecipes();
      _recipes = response.recipes;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Get recipe by index
  Recipe? getRecipeByIndex(int index) {
    if (index >= 0 && index < _recipes.length) {
      return _recipes[index];
    }
    return null;
  }

  /// Get total recipe count
  int get recipesCount => _recipes.length;
}
