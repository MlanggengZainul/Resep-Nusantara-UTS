import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../routes.dart';
import '../theme/app_theme.dart';
import '../widgets/recipe_card.dart';

/// Argumen yang dikirim dari Beranda ke halaman daftar.
class RecipeListArgs {
  final List<Recipe> recipes;
  final String? category; // null = semua kategori
  final String query;

  const RecipeListArgs({
    required this.recipes,
    this.category,
    this.query = '',
  });
}

/// Halaman 2: Daftar resep berdasarkan kategori, dengan pencarian.
class RecipeListScreen extends StatefulWidget {
  final RecipeListArgs args;
  const RecipeListScreen({super.key, required this.args});

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.args.query);
  late String _query = widget.args.query;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Recipe> get _filtered {
    final q = _query.toLowerCase().trim();
    return widget.args.recipes.where((r) {
      final matchCategory =
          widget.args.category == null || r.category == widget.args.category;
      return matchCategory && r.name.toLowerCase().contains(q);
    }).toList();
  }

  void _openDetail(Recipe recipe) {
    Navigator.pushNamed(context, AppRoutes.detail, arguments: recipe);
  }

  @override
  Widget build(BuildContext context) {
    final items = _filtered;
    return Scaffold(
      appBar: AppBar(title: Text(widget.args.category ?? 'Semua Resep')),
      body: Column(
        children: [
          Container(
            color: AppColors.dark,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: TextField(
              controller: _controller,
              onChanged: (v) => setState(() => _query = v),
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
          ),
          Expanded(
            child: items.isEmpty
                ? const Center(
                    child: Text('Resep tidak ditemukan. Coba kata kunci lain.'),
                  )
                : LayoutBuilder(
                    builder: (context, constraints) {
                      // Responsif: layar lebar memakai grid 2 kolom.
                      if (constraints.maxWidth >= 600) {
                        return GridView.builder(
                          padding: const EdgeInsets.all(16),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            mainAxisExtent: 100,
                          ),
                          itemCount: items.length,
                          itemBuilder: (context, i) => RecipeCard(
                            recipe: items[i],
                            onTap: () => _openDetail(items[i]),
                          ),
                        );
                      }
                      return ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: items.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, i) => RecipeCard(
                          recipe: items[i],
                          onTap: () => _openDetail(items[i]),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
