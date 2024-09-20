class ReviewModel {
  final String name;
  final String rating;
  final String reviewDate;
  final String review;
  final String imageUrl;

  ReviewModel(
      {required this.imageUrl,
      required this.name,
      required this.rating,
      required this.review,
      required this.reviewDate});
}
