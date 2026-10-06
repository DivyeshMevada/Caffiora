import '../models/coffee.dart';

class CoffeeData {
  static const List<Coffee> coffees = [
    Coffee(
      id: 'espresso',
      name: 'Espresso',
      description: 'Rich and bold classic espresso.',
      price: 120,
      image: 'assets/images/coffee-espresso.jpg',
      rating: 4.8,
    ),
    Coffee(
      id: 'cappuccino',
      name: 'Cappuccino',
      description: 'Espresso with steamed milk and a silky foam cap.',
      price: 180,
      image: 'assets/images/coffee-cappuccino.jpg',
      rating: 4.7,
    ),
    Coffee(
      id: 'latte',
      name: 'Latte',
      description: 'Smooth espresso blended with creamy steamed milk.',
      price: 200,
      image: 'assets/images/coffee-latte.jpg',
      rating: 4.8,
    ),
    Coffee(
      id: 'americano',
      name: 'Americano',
      description: 'Espresso diluted with hot water for a clean, bold cup.',
      price: 150,
      image: 'assets/images/coffee-americano.jpg',
      rating: 4.6,
    ),
    Coffee(
      id: 'mocha',
      name: 'Mocha',
      description: 'Chocolate and espresso with steamed milk.',
      price: 220,
      image: 'assets/images/coffee-mocha.jpg',
      rating: 4.9,
    ),
    Coffee(
      id: 'cold-coffee',
      name: 'Cold Coffee',
      description: 'Chilled, blended coffee with a refreshing finish.',
      price: 190,
      image: 'assets/images/coffee-cold-coffee.jpg',
      rating: 4.7,
      category: 'Cold Brew',
    ),
    Coffee(
      id: 'iced-latte',
      name: 'Iced Latte',
      description: 'Cold milk poured over espresso and ice.',
      price: 210,
      image: 'assets/images/coffee-iced-latte.jpg',
      rating: 4.8,
      category: 'Cold Brew',
    ),
    Coffee(
      id: 'macchiato',
      name: 'Macchiato',
      description: 'Espresso marked with a touch of milk foam.',
      price: 170,
      image: 'assets/images/coffee-macchiato.jpg',
      rating: 4.7,
    ),
  ];

  static Coffee get featured => coffees.first;

  static List<Coffee> get popular => coffees.take(4).toList();

  static Coffee byName(String name) {
    return coffees.firstWhere(
      (coffee) => coffee.name.toLowerCase() == name.toLowerCase(),
      orElse: () => coffees.first,
    );
  }
}
