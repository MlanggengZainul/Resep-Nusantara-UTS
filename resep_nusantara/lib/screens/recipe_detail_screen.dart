import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/recipe.dart';
import '../theme/app_theme.dart';
import '../widgets/section_title.dart';

/// Halaman 3: Detail resep (bahan, langkah, info singkat).
class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;
  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final r = widget.recipe;
    final cat = RecipeCategory.byName(r.category);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 240,
            backgroundColor: AppColors.dark,
            foregroundColor: Colors.white,
            actions: [
              IconButton(
                tooltip: _isFavorite ? 'Hapus dari favorit' : 'Simpan ke favorit',
                icon: Icon(_isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded),
                color: _isFavorite ? Colors.redAccent : Colors.white,
                onPressed: () => setState(() => _isFavorite = !_isFavorite),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(r.name, style: const TextStyle(fontSize: 16)),
              background: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [cat.color, AppColors.dark],
                  ),
                ),
                child: Text(r.emoji, style: const TextStyle(fontSize: 96)),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _InfoChip(Icons.timer_outlined, '${r.duration} menit'),
                      _InfoChip(Icons.people_outline_rounded, '${r.servings} porsi'),
                      _InfoChip(Icons.star_rounded, r.rating.toString()),
                      _InfoChip(Icons.speed_rounded, r.difficulty),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    r.description,
                    style: const TextStyle(fontSize: 15, height: 1.5),
                  ),
                  const SizedBox(height: 24),
                  const SectionTitle('Bahan-bahan'),
                  const SizedBox(height: 12),
                  Card(
                    elevation: 0,
                    color: Colors.white,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          for (final item in r.ingredients)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.check_circle_rounded,
                                      size: 18, color: AppColors.primary),
                                  const SizedBox(width: 10),
                                  Expanded(child: Text(item)),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const SectionTitle('Langkah memasak'),
                  const SizedBox(height: 12),
                  for (var i = 0; i < r.steps.length; i++)
                    _StepTile(number: i + 1, text: r.steps[i]),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoChip(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}

class _StepTile extends StatelessWidget {
  final int number;
  final String text;
  const _StepTile({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: AppColors.primary,
            child: Text(
              '$number',
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(text, style: const TextStyle(fontSize: 15, height: 1.4)),
            ),
          ),
        ],
      ),
    );
  }
}
