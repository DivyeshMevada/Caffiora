import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'menu_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';
import 'search_screen.dart';
import 'product_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final List<Widget> screens = [
    const HomeContent(),
    const MenuScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  void changeTab(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppTheme.coffeeDark,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,

        onTap: changeTab,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            activeIcon: Icon(Icons.menu_book),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// HOME CONTENT
// ---------------------------------------------------------

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'CAFFIORA',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                        color: AppTheme.coffeeDark,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Brewed Fresh. Served with Elegance.',
                      style: TextStyle(fontSize: 11, color: AppTheme.grey),
                    ),
                  ],
                ),

                const Spacer(),

                // Notification
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_none,
                      color: AppTheme.coffeeDark,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // Search
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
              child: Container(
                height: 52,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: AppTheme.grey),
                    SizedBox(width: 12),
                    Text(
                      'Search coffee...',
                      style: TextStyle(color: AppTheme.grey, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Signature Blend
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: AppTheme.coffeeDark,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'SIGNATURE BLEND',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                            letterSpacing: 2,
                          ),
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          'Velvet\nEspresso',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          'A rich handcrafted coffee\nexperience beyond ordinary.',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            height: 1.5,
                          ),
                        ),

                        const SizedBox(height: 15),

                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProductDetails(
                                  productName: 'Velvet Espresso',
                                  price: 279,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.cream,
                            foregroundColor: AppTheme.coffeeDark,
                            minimumSize: const Size(130, 42),
                          ),
                          child: const Text('Explore Coffee'),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 10),

                  // Coffee Image Placeholder
                  Container(
                    height: 135,
                    width: 105,
                    decoration: BoxDecoration(
                      color: AppTheme.coffeeLight,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(
                      Icons.coffee,
                      color: Colors.white,
                      size: 65,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Explore Categories
            const Text(
              'Explore Categories',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: AppTheme.coffeeDark,
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              height: 105,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  CategoryItem(icon: Icons.coffee, title: 'Espresso Bar'),
                  CategoryItem(icon: Icons.local_cafe, title: 'Bakery'),
                  CategoryItem(icon: Icons.icecream, title: 'Cold Brew'),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Today's Selection
            Row(
              children: [
                const Text(
                  "Today's Selection",
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.coffeeDark,
                  ),
                ),

                const Spacer(),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MenuScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'View all',
                    style: TextStyle(color: AppTheme.coffeeDark),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Products
            Row(
              children: [
                Expanded(
                  child: CoffeeCard(
                    name: 'Italian Roast',
                    price: 249,
                    rating: 4.9,
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: CoffeeCard(
                    name: 'Caramel Macchiato',
                    price: 319,
                    rating: 4.8,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: CoffeeCard(
                    name: 'Velvet Espresso',
                    price: 279,
                    rating: 4.9,
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: CoffeeCard(
                    name: 'Iced Latte',
                    price: 249,
                    rating: 4.9,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// CATEGORY ITEM
// ---------------------------------------------------------

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const CategoryItem({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: AppTheme.coffee),

          const SizedBox(height: 8),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppTheme.coffeeDark,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// COFFEE CARD
// ---------------------------------------------------------

class CoffeeCard extends StatelessWidget {
  final String name;
  final double price;
  final double rating;

  const CoffeeCard({
    super.key,
    required this.name,
    required this.price,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProductDetails(productName: name, price: price),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 125,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppTheme.cream,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.coffee, size: 55, color: AppTheme.coffee),
            ),

            const SizedBox(height: 10),

            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppTheme.coffeeDark,
              ),
            ),

            const SizedBox(height: 5),

            Row(
              children: [
                const Icon(Icons.star, size: 15, color: Colors.amber),

                const SizedBox(width: 3),

                Text(
                  rating.toString(),
                  style: const TextStyle(fontSize: 12, color: AppTheme.grey),
                ),

                const Spacer(),

                Text(
                  '₹${price.toInt()}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.coffeeDark,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
