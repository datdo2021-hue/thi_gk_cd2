import 'package:flutter/material.dart';

import '../../data/model/article.dart';

class NewsCard extends StatelessWidget {
  final Article article;
  final VoidCallback onTap;

  const NewsCard({Key? key, required this.article, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8.0),
        leading: Image.network(article.imageUrl, width: 80, fit: BoxFit.cover),
        title: Text(article.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(article.description, maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 4),
            Text(article.publishedAt, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}