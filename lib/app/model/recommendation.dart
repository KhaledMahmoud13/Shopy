class Recommendation {
  final int id;
  final String name;
  final String gender;
  final String category;
  final String recommendedBrand;
  final String imageUrl;

  Recommendation({
    required this.id,
    required this.name,
    required this.gender,
    required this.category,
    required this.recommendedBrand,
    required this.imageUrl,
  });

  factory Recommendation.fromValue(Map<dynamic, dynamic> value) =>
      Recommendation(
        id: value["id"],
        name: value["name"],
        gender: value["gender"],
        category: value["category"],
        recommendedBrand: value["recommendedBrand"],
        imageUrl: value["imageUrl"],
      );
}
