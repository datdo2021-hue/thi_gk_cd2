class Article {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final String publishedAt;

  Article({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.publishedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      // Hỗ trợ cả key 'body' từ API và 'description' từ Local Storage
      description: json['description'] ?? json['body'] ?? '',
      imageUrl: json['imageUrl'] ?? "https://picsum.photos/seed/${json['id']}/400/200",
      publishedAt: json['publishedAt'] ?? DateTime.now().toString().substring(0, 10),
    );
  }

  // Thêm hàm này để lưu dữ liệu
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'publishedAt': publishedAt,
    };
  }

  // Ghi đè toán tử == để so sánh Article chính xác khi xóa/thêm
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Article && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}