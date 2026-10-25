import 'package:flutter/material.dart';

/// Kategori resep beserta ikon dan warna penandanya.
class RecipeCategory {
  final String name;
  final IconData icon;
  final Color color;

  const RecipeCategory(this.name, this.icon, this.color);

  static const all = [
    RecipeCategory('Sarapan', Icons.free_breakfast_rounded, Color(0xFFE58A1F)),
    RecipeCategory('Makan Berat', Icons.rice_bowl_rounded, Color(0xFFC0392B)),
    RecipeCategory('Camilan', Icons.bakery_dining_rounded, Color(0xFF2E8B57)),
    RecipeCategory('Minuman', Icons.local_cafe_rounded, Color(0xFF3A7CA5)),
  ];

  static RecipeCategory byName(String name) =>
      all.firstWhere((c) => c.name == name, orElse: () => all.first);
}
