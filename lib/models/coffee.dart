class Coffee {
  final String id;
  final String name;
  final String description;
  final double price;
  final String image;
  final double rating;
  final String category;

  const Coffee({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.rating,
    this.category = 'Espresso Bar',
  });
}
