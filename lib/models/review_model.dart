class Review {
  final int userId;
  final int rating;
  final String comment;
  final List<Review> reviews;

  Review({
    required this.userId,
    required this.rating,
    required this.comment,
    required this.reviews,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      userId: json['user_id'],
      rating: json['rating'],
      comment: json['comment'],
      reviews:
          (json['reviews'] as List).map((e) => Review.fromJson(e)).toList(),
    );
  }
}
