import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/recipe.dart';

/// Satu-satunya pintu akses data resep.
/// Saat ini membaca JSON lokal. Untuk tahap API, cukup ganti isi
/// [fetchRecipes] dengan http.get(...) tanpa mengubah layar mana pun.
class RecipeRepository {
  Future<List<Recipe>> fetchRecipes() async {
    final raw = await rootBundle.loadString('assets/data/recipes.json');
    final data = json.decode(raw) as List<dynamic>;
    return data
        .map((e) => Recipe.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
