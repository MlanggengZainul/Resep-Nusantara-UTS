import 'package:flutter/material.dart';
import 'models/recipe.dart';
import 'routes.dart';
import 'screens/home_screen.dart';
import 'screens/recipe_detail_screen.dart';
import 'screens/recipe_list_screen.dart';
import 'theme/app_theme.dart';

void main() => runApp(const ResepNusantaraApp());

class ResepNusantaraApp extends StatelessWidget {
  const ResepNusantaraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resep Nusantara',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      initialRoute: AppRoutes.home,
      // Semua perpindahan halaman dikelola di satu tempat.
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AppRoutes.list:
            final args = settings.arguments as RecipeListArgs;
            return MaterialPageRoute(
              builder: (_) => RecipeListScreen(args: args),
            );
          case AppRoutes.detail:
            final recipe = settings.arguments as Recipe;
            return MaterialPageRoute(
              builder: (_) => RecipeDetailScreen(recipe: recipe),
            );
          default:
            return MaterialPageRoute(builder: (_) => const HomeScreen());
        }
      },
    );
  }
}
