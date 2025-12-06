import 'package:flutter_test/flutter_test.dart';
import 'package:list_of_food_recipe/models/recipe.dart';

void main() {
  group('Recipe Model Tests', () {
    test('Recipe.fromJson parses correctly from Map', () {
      final json = {
        'title': 'Pasta Carbonara',
        'description': 'Creamy pasta dish with bacon and cheese.',
        'ingredients': ['spaghetti', 'bacon', 'egg', 'cheese']
      };

      final recipe = Recipe.fromJson(json);

      expect(recipe.title, 'Pasta Carbonara');
      expect(recipe.description, 'Creamy pasta dish with bacon and cheese.');
      expect(recipe.ingredients.length, 4);
      expect(recipe.ingredients.first, 'spaghetti');
    });

    test('Recipe.toJson converts Recipe to Map', () {
      final recipe = Recipe(
        title: 'Test Recipe',
        description: 'A test recipe',
        ingredients: ['ingredient1', 'ingredient2'],
      );

      final json = recipe.toJson();

      expect(json['title'], 'Test Recipe');
      expect(json['description'], 'A test recipe');
      expect(json['ingredients'].length, 2);
    });

    test('Recipe toString returns formatted string', () {
      final recipe = Recipe(
        title: 'Test',
        description: 'desc',
        ingredients: ['ing1'],
      );

      final str = recipe.toString();
      expect(str.contains('Test'), true);
      expect(str.contains('Recipe'), true);
    });
  });

  group('RecipeResponse Model Tests', () {
    test('RecipeResponse.fromJson parses complete JSON response', () {
      final jsonString = '''{
        "recipes": [
          {
            "title": "Pasta Carbonara",
            "description": "Creamy pasta dish with bacon and cheese.",
            "ingredients": ["spaghetti", "bacon", "egg", "cheese"]
          },
          {
            "title": "Caprese Salad",
            "description": "Simple and refreshing salad.",
            "ingredients": ["tomatoes", "mozzarella", "basil"]
          }
        ]
      }''';

      final response = RecipeResponse.fromJson(jsonString);

      expect(response.recipes.length, 2);
      expect(response.recipes[0].title, 'Pasta Carbonara');
      expect(response.recipes[1].title, 'Caprese Salad');
    });

    test('RecipeResponse handles empty recipes list', () {
      final jsonString = '{"recipes": []}';

      final response = RecipeResponse.fromJson(jsonString);

      expect(response.recipes.isEmpty, true);
      expect(response.recipes.length, 0);
    });

    test('RecipeResponse toString returns formatted string', () {
      final response = RecipeResponse(recipes: [
        Recipe(
          title: 'Test',
          description: 'desc',
          ingredients: ['ing1'],
        )
      ]);

      final str = response.toString();
      expect(str.contains('RecipeResponse'), true);
      expect(str.contains('1 items'), true);
    });
  });

  group('Recipe JSON Serialization Tests', () {
    test('Recipe round-trip serialization works correctly', () {
      final original = Recipe(
        title: 'Banana Smoothie',
        description: 'Healthy smoothie',
        ingredients: ['bananas', 'milk'],
      );

      final json = original.toJson();
      final parsed = Recipe.fromJson(json);

      expect(parsed.title, original.title);
      expect(parsed.description, original.description);
      expect(parsed.ingredients, original.ingredients);
    });

    test('Recipe handles special characters in fields', () {
      final json = {
        'title': 'Pasta à la Crème',
        'description': 'A classic "French" dish with dairy.',
        'ingredients': ["crème fraîche", "café"]
      };

      final recipe = Recipe.fromJson(json);

      expect(recipe.title, 'Pasta à la Crème');
      expect(recipe.description.contains('"'), true);
      expect(recipe.ingredients.contains('crème fraîche'), true);
    });
  });
}
