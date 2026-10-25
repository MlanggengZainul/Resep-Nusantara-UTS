import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/recipe.dart';
import '../routes.dart';
import '../services/recipe_repository.dart';
import '../theme/app_theme.dart';
import '../widgets/recipe_card.dart';
import '../widgets/section_title.dart';
import 'recipe_list_screen.dart';

/// Halaman 1: Beranda (pencarian, kategori, resep populer, resep terbaru).
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Future<List<Recipe>> _future = RecipeRepository().fetchRecipes();

  void _openList(List<Recipe> recipes, {String? category, String query = ''}) {
    Navigator.pushNamed(
      context,
      AppRoutes.list,
      arguments: RecipeListArgs(recipes: recipes, category: category, query: query),
    );
  }

  void _openDetail(Recipe recipe) {
    Navigator.pushNamed(context, AppRoutes.detail, arguments: recipe);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Recipe>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text('Data resep gagal dimuat.'));
          }
          final recipes = snapshot.data!;
          final popular = recipes.where((r) => r.isPopular).toList();
          final latest = [...recipes]
            ..sort((a, b) => b.addedDate.compareTo(a.addedDate));

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Header(onSearch: (q) => _openList(recipes, query: q)),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      for (final c in RecipeCategory.all)
                        Expanded(
                          child: _CategoryItem(
                            category: c,
                            onTap: () => _openList(recipes, category: c.name),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SectionTitle('Resep Populer'),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 190,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: popular.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 12),
                    itemBuilder: (context, i) => PopularRecipeCard(
                      recipe: popular[i],
                      onTap: () => _openDetail(popular[i]),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SectionTitle('Resep Terbaru'),
                      TextButton(
                        onPressed: () => _openList(recipes),
                        child: const Text('Lihat semua'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                  child: Column(
                    children: [
                      for (final r in latest.take(4)) ...[
                        RecipeCard(recipe: r, onTap: () => _openDetail(r)),
                        const SizedBox(height: 12),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final ValueChanged<String> onSearch;
  const _Header({required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
          20, MediaQuery.of(context).padding.top + 20, 20, 28),
      decoration: const BoxDecoration(
        color: AppColors.dark,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat datang',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Mau masak apa hari ini?',
                      style: TextStyle(color: Colors.white60, fontSize: 14),
                    ),
                  ],
                ),
              ),
              const CircleAvatar(
                backgroundColor: AppColors.accent,
                child: Icon(Icons.restaurant_menu_rounded, color: AppColors.dark),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            onSubmitted: onSearch,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: 'Cari nama resep',
              prefixIcon: const Icon(Icons.search_rounded),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final RecipeCategory category;
  final VoidCallback onTap;
  const _CategoryItem({required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: category.color,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(category.icon, color: Colors.white),
            ),
            const SizedBox(height: 6),
            Text(
              category.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
