import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/model/article.dart';
import '../providers/news_provider.dart';

class DetailScreen extends StatelessWidget {
  final Article article;

  const DetailScreen({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Nền trắng tinh để đọc báo dễ hơn
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.red[800], // Đồng bộ màu đỏ của Home
        centerTitle: true,
        title: const Text(
          'CHI TIẾT',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.white,
          ),
        ),
        // Nút back màu trắng
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Consumer<NewsProvider>(
            builder: (context, provider, child) {
              final isFav = provider.isFavorite(article);
              return IconButton(
                // Đổi sang màu trắng để nổi bật trên nền đỏ
                icon: Icon(
                  isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  color: Colors.white,
                ),
                onPressed: () => provider.toggleFavorite(article),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hình ảnh bo góc phía dưới
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24.0),
                bottomRight: Radius.circular(24.0),
              ),
              child: Image.network(
                article.imageUrl,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),

            // Nội dung bài báo
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tiêu đề
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800, // Chữ đậm kiểu báo chí
                      height: 1.3, // Khoảng cách dòng cho tiêu đề
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Ngày đăng có kèm Icon
                  Row(
                    children: [
                      Icon(Icons.access_time_rounded, size: 18, color: Colors.grey[600]),
                      const SizedBox(width: 6),
                      Text(
                        article.publishedAt,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  Divider(color: Colors.grey[200], thickness: 1.5),
                  const SizedBox(height: 16),

                  // Nội dung chi tiết
                  Text(
                    article.description,
                    style: const TextStyle(
                      fontSize: 17,
                      height: 1.6, // Khoảng cách dòng chuẩn để đọc văn bản dài không bị mỏi mắt
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 40), // Khoảng trống ở cuối trang
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}