import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import '../widgets/news_card.dart';
import 'detail_screen.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.red[800],
        centerTitle: true,
        title: const Text(
          'TIN ĐÃ LƯU',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer<NewsProvider>(
        builder: (context, provider, child) {
          final favorites = provider.favoriteArticles;

          if (favorites.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border_rounded, size: 80, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  const Text(
                    'Chưa có bài viết yêu thích nào.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(12.0),
            itemCount: favorites.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final article = favorites[index];
              return NewsCard(
                article: article,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScreen(article: article)));
                },
              );
            },
          );
        },
      ),
    );
  }
}