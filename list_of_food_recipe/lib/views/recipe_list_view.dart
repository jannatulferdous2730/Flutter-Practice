import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/recipe_view_model.dart';
import '../widgets/recipe_list_item.dart';
import 'recipe_detail_view.dart';

class RecipeListView extends StatefulWidget {
  const RecipeListView({super.key});

  @override
  State<RecipeListView> createState() => _RecipeListViewState();
}

class _RecipeListViewState extends State<RecipeListView> {
  @override
  void initState() {
    super.initState();
    // Load recipes when the view is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RecipeViewModel>().loadRecipes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Recipes'),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Consumer<RecipeViewModel>(
        builder: (context, viewModel, child) {
          // Show loading indicator
          if (viewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Show error message
          if (viewModel.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${viewModel.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => viewModel.loadRecipes(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // Show recipes list
          if (viewModel.recipes.isEmpty) {
            return const Center(
              child: Text('No recipes available'),
            );
          }

          return ListView.builder(
            itemCount: viewModel.recipes.length,
            itemBuilder: (context, index) {
              final recipe = viewModel.recipes[index];
              return RecipeListItem(
                recipe: recipe,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RecipeDetailView(recipe: recipe),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
