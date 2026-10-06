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

  final List<int> tabHistory = [0];

  final List<Widget> screens = [
    const HomeContent(),
    const MenuScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  void changeTab(int index) {
    if (index == selectedIndex) {
      return;
    }

    setState(() {
      selectedIndex = index;
      tabHistory.add(index);
    });
  }

  Future<void> handleBack() async {
    if (tabHistory.length > 1) {
      setState(() {
        tabHistory.removeLast();
        selectedIndex = tabHistory.last;
      });

      return;
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }

        handleBack();
      },
      child: Scaffold(
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
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          20,
          15,
          20,
          25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
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
                      style: TextStyle(
                        fontSize: 11,
                        color: AppTheme.grey,
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                // Container(
                //   height: 45,
                //   width: 45,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(14),
                //   ),
                //   child: IconButton(
                //     onPressed: () {},
                //     icon: const Icon(
                //       Icons.notifications_none,
                //       color: AppTheme.coffeeDark,
                //     ),
                //   ),
                // ),
              ],
            ),

            const SizedBox(height: 25),

            // SEARCH
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchScreen(),
                  ),
                );
              },
              child: Container(
                height: 52,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: AppTheme.grey,
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Search coffee...',
                      style: TextStyle(
                        color: AppTheme.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // SIGNATURE BLEND
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

                  // SIGNATURE IMAGE
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset(
                      'assets/images/velvet_espresso.jpg',
                      height: 135,
                      width: 105,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 135,
                          width: 105,
                          color: AppTheme.coffeeLight,
                          child: const Icon(
                            Icons.coffee,
                            color: Colors.white,
                            size: 65,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // CATEGORIES
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
                children: [
                  CategoryItem(
                    image: 'assets/images/velvet_espresso.jpg',
                    title: 'Espresso Bar',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MenuScreen(
                            initialCategory: 'Espresso Bar',
                          ),
                        ),
                      );
                    },
                  ),
                  CategoryItem(
                    image: 'assets/images/velvet_croissant.jpg',
                    title: 'Bakery',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MenuScreen(
                            initialCategory: 'Bakery',
                          ),
                        ),
                      );
                    },
                  ),
                  CategoryItem(
                    image: 'assets/images/cold_brew.jpg',
                    title: 'Cold Brew',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MenuScreen(
                            initialCategory: 'Cold Brew',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // TODAY'S SELECTION
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
                    style: TextStyle(
                      color: AppTheme.coffeeDark,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // ROW 1
            Row(
              children: [
                Expanded(
                  child: CoffeeCard(
                    name: 'Italian Roast',
                    price: 249,
                    rating: 4.9,
                    image: 'assets/images/italian_roast.jpg',
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: CoffeeCard(
                    name: 'Caramel Macchiato',
                    price: 319,
                    rating: 4.8,
                    image: 'assets/images/caramel_macchiato.jpg',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ROW 2
            Row(
              children: [
                Expanded(
                  child: CoffeeCard(
                    name: 'Velvet Espresso',
                    price: 279,
                    rating: 4.9,
                    image: 'assets/images/velvet_espresso.jpg',
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: CoffeeCard(
                    name: 'Iced Latte',
                    price: 249,
                    rating: 4.9,
                    image: 'assets/images/iced_latte.jpg',
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

class CategoryItem extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onTap;

  const CategoryItem({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.asset(
                image,
                height: 65,
                width: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 65,
                    width: 100,
                    color: AppTheme.cream,
                    child: const Icon(
                      Icons.coffee,
                      color: AppTheme.coffee,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 7),
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
      ),
    );
  }
}

class CoffeeCard extends StatelessWidget {
  final String name;
  final double price;
  final double rating;
  final String image;

  const CoffeeCard({
    super.key,
    required this.name,
    required this.price,
    required this.rating,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetails(
              productName: name,
              price: price,
            ),
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
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                image,
                height: 125,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 125,
                    width: double.infinity,
                    color: AppTheme.cream,
                    child: const Icon(
                      Icons.coffee,
                      size: 55,
                      color: AppTheme.coffee,
                    ),
                  );
                },
              ),
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
                const Icon(
                  Icons.star,
                  size: 15,
                  color: Colors.amber,
                ),
                const SizedBox(width: 3),
                Text(
                  rating.toString(),
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.grey,
                  ),
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
