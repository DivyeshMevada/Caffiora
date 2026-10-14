import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class AdminManagement extends StatefulWidget {
  const AdminManagement({super.key});

  @override
  State<AdminManagement> createState() => _AdminManagementState();
}

class _AdminManagementState extends State<AdminManagement> {
  final List<String> categories = ['Espresso Bar', 'Bakery'];

  final List<Map<String, dynamic>> products = [
    {
      'name': 'Italian Roast',
      'price': 249,
      'category': 'Espresso Bar',
      'stock': 45,
      'image': 'assets/images/italian_roast.jpg',
    },
    {
      'name': 'Caramel Macchiato',
      'price': 319,
      'category': 'Espresso Bar',
      'stock': 32,
      'image': 'assets/images/caramel_macchiato.jpg',
    },
    {
      'name': 'Velvet Espresso',
      'price': 279,
      'category': 'Espresso Bar',
      'stock': 28,
      'image': 'assets/images/velvet_espresso.jpg',
    },
    {
      'name': 'Velvet Croissant',
      'price': 239,
      'category': 'Bakery',
      'stock': 20,
      'image': 'assets/images/velvet_croissant.jpg',
    },
    {
      'name': 'Cold Brew',
      'price': 249,
      'category': 'Espresso Bar',
      'stock': 38,
      'image': 'assets/images/cold_brew.jpg',
    },
    {
      'name': 'Stroopwafel Cupcake',
      'price': 289,
      'category': 'Bakery',
      'stock': 18,
      'image': 'assets/images/stroopwafel_cupcake.jpg',
    },
    {
      'name': 'Iced Latte',
      'price': 249,
      'category': 'Espresso Bar',
      'stock': 41,
      'image': 'assets/images/iced_latte.jpg',
    },
    {
      'name': 'Iced Matcha',
      'price': 349,
      'category': 'Espresso Bar',
      'stock': 24,
      'image': 'assets/images/iced_matcha.jpg',
    },
  ];

  final List<Map<String, String>> customers = [
    {
      'name': 'Raj Patel',
      'email': 'rajpatel@gmail.com',
      'phone': '9798347684',
    },
    {
      'name': 'Rajiv Kumar',
      'email': 'rajiv@gmail.com',
      'phone': '9876543210',
    },
    {
      'name': 'Aarav Shah',
      'email': 'aarav@gmail.com',
      'phone': '9898989898',
    },
  ];

  final List<Map<String, String>> staff = [
    {
      'name': 'Marco Valente',
      'role': 'Senior Barista',
      'id': 'CF-002',
      'shift': '08:00 - 16:00',
    },
    {
      'name': 'John Smith',
      'role': 'Barista',
      'id': 'CF-003',
      'shift': '10:00 - 18:00',
    },
    {
      'name': 'Emma Wilson',
      'role': 'Staff',
      'id': 'CF-004',
      'shift': '12:00 - 20:00',
    },
  ];

  final List<Map<String, String>> inventory = [
    {'name': 'Coffee Beans', 'quantity': '12.5 kg', 'target': '20 kg'},
    {'name': 'Milk', 'quantity': '8 units', 'target': '30 units'},
    {'name': 'Cups', 'quantity': '42 pcs', 'target': '1000 pcs'},
  ];

  final List<String> sections = [
    'Products',
    'Categories',
    'Customers',
    'Staff',
    'Inventory',
    'Pricing',
  ];

  int selectedSection = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      appBar: AppBar(
        title: const Text(
          'Management',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          _buildSectionSelector(),
          Expanded(child: _buildSelectedSection()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.coffeeDark,
        foregroundColor: Colors.white,
        onPressed: _showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  // SECTION SELECTOR

  Widget _buildSectionSelector() {
    return SizedBox(
      height: 58,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: sections.length,
        itemBuilder: (context, index) {
          final selected = selectedSection == index;

          return GestureDetector(
            onTap: () => setState(() => selectedSection = index),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: selected ? AppTheme.coffeeDark : Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  sections[index],
                  style: TextStyle(
                    color: selected ? Colors.white : AppTheme.coffeeDark,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSelectedSection() {
    switch (selectedSection) {
      case 0:
        return _productsSection();
      case 1:
        return _categoriesSection();
      case 2:
        return _customersSection();
      case 3:
        return _staffSection();
      case 4:
        return _inventorySection();
      case 5:
        return _pricingSection();
      default:
        return _productsSection();
    }
  }

  // SECTION HEADER

  Widget _sectionHeader({
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppTheme.coffeeDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 13, color: AppTheme.grey),
          ),
        ],
      ),
    );
  }

  // PRODUCT IMAGE

  Widget _productImage(
    Map<String, dynamic> product, {
    double size = 65,
  }) {
    final imagePath = product['image'] as String?;

    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: SizedBox(
        height: size,
        width: size,
        child: imagePath == null || imagePath.isEmpty
            ? _imagePlaceholder()
            : Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _imagePlaceholder();
                },
              ),
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      color: AppTheme.cream,
      child: const Icon(
        Icons.local_cafe_outlined,
        color: AppTheme.coffee,
        size: 30,
      ),
    );
  }

  // PRODUCTS

  Widget _productsSection() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        _sectionHeader(
          title: 'Products',
          subtitle: '${products.length} products available',
        ),
        ...products.map(_productManagementCard),
      ],
    );
  }

  Widget _productManagementCard(Map<String, dynamic> product) {
    final int stock = product['stock'] as int;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          _productImage(product),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.coffeeDark,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product['category'] as String,
                  style: const TextStyle(
                    color: AppTheme.grey,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Stock: $stock',
                  style: TextStyle(
                    color: stock < 20 ? Colors.red : Colors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '₹${product['price']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.coffeeDark,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                tooltip: 'Edit product',
                onPressed: () => _showEditProductDialog(product),
                icon: const Icon(
                  Icons.edit_outlined,
                  color: AppTheme.coffee,
                ),
              ),
              IconButton(
                tooltip: 'Delete product',
                onPressed: () => _deleteProduct(product),
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // CATEGORIES

  Widget _categoriesSection() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        _sectionHeader(
          title: 'Categories',
          subtitle: '${categories.length} categories',
        ),
        ...categories.map((category) {
          final categoryProducts =
              products.where((p) => p['category'] == category).toList();

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    height: 58,
                    width: 58,
                    child: categoryProducts.isNotEmpty
                        ? _productImage(categoryProducts.first, size: 58)
                        : _imagePlaceholder(),
                  ),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.coffeeDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${categoryProducts.length} products',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => _showEditCategoryDialog(category),
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: AppTheme.coffee,
                  ),
                ),
                IconButton(
                  onPressed: () => _deleteCategory(category),
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  // CUSTOMERS

  Widget _customersSection() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        _sectionHeader(
          title: 'Customers',
          subtitle: '${customers.length} registered customers',
        ),
        ...customers.map(
          (customer) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 27,
                  backgroundColor: AppTheme.cream,
                  child: Text(
                    customer['name']![0],
                    style: const TextStyle(
                      color: AppTheme.coffeeDark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        customer['name']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.coffeeDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        customer['email']!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.grey,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        customer['phone']!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // STAFF

  Widget _staffSection() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        _sectionHeader(
          title: 'Staff',
          subtitle: '${staff.length} staff members',
        ),
        ...staff.map(
          (member) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 27,
                  backgroundColor: AppTheme.coffeeDark,
                  child: Text(
                    member['name']![0],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        member['name']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.coffeeDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        member['role']!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.coffee,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'ID: ${member['id']}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppTheme.grey,
                        ),
                      ),
                      Text(
                        'Shift: ${member['shift']}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppTheme.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // INVENTORY

  Widget _inventorySection() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        _sectionHeader(
          title: 'Inventory',
          subtitle: 'Current stock overview',
        ),
        ...inventory.map((item) {
          final quantity = item['quantity']!;
          final target = item['target']!;

          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppTheme.cream,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        item['name'] == 'Coffee Beans'
                            ? Icons.coffee
                            : item['name'] == 'Milk'
                                ? Icons.water_drop_outlined
                                : Icons.local_cafe_outlined,
                        color: AppTheme.coffee,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        item['name']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.coffeeDark,
                        ),
                      ),
                    ),
                    Text(
                      quantity,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.coffeeDark,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                LinearProgressIndicator(
                  value: _inventoryProgress(quantity, target),
                  minHeight: 7,
                  borderRadius: BorderRadius.circular(10),
                  backgroundColor: Colors.grey.shade200,
                  color: AppTheme.coffee,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Current Stock',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppTheme.grey,
                      ),
                    ),
                    Text(
                      'Target: $target',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppTheme.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  double _inventoryProgress(String quantity, String target) {
    final q = double.tryParse(quantity.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
    final t = double.tryParse(target.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 1;

    if (t <= 0) return 0;
    return (q / t).clamp(0.0, 1.0);
  }

  // PRICING

  Widget _pricingSection() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        _sectionHeader(
          title: 'Pricing',
          subtitle: 'Manage product prices',
        ),
        ...products.map(
          (product) => Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                _productImage(product, size: 50),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    product['name'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.coffeeDark,
                    ),
                  ),
                ),
                Text(
                  '₹${product['price']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.coffeeDark,
                  ),
                ),
                IconButton(
                  onPressed: () => _showEditPriceDialog(product),
                  icon: const Icon(
                    Icons.edit_outlined,
                    size: 20,
                    color: AppTheme.coffee,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ADD BUTTON ACTION

  void _showAddDialog() {
    if (selectedSection == 0) {
      _showAddProductDialog();
    } else if (selectedSection == 1) {
      _showAddCategoryDialog();
    } else if (selectedSection == 3) {
      _showAddStaffDialog();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Add ${sections[selectedSection]} selected')),
      );
    }
  }

  // ADD PRODUCT

  void _showAddProductDialog() {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    String selectedCategory = categories.first;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Add Product'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Product Name',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Price',
                        prefixText: '₹ ',
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: selectedCategory,
                      decoration: const InputDecoration(
                        labelText: 'Category',
                      ),
                      items: categories
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setDialogState(() => selectedCategory = value);
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final name = nameController.text.trim();
                    final price = int.tryParse(priceController.text.trim());

                    if (name.isEmpty || price == null || price < 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Enter a valid name and price'),
                        ),
                      );
                      return;
                    }

                    setState(() {
                      products.add({
                        'name': name,
                        'price': price,
                        'category': selectedCategory,
                        'stock': 0,
                        'image': null,
                      });
                    });

                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // EDIT PRODUCT

  void _showEditProductDialog(Map<String, dynamic> product) {
    final nameController =
        TextEditingController(text: product['name'].toString());
    final priceController =
        TextEditingController(text: product['price'].toString());
    String selectedCategory = categories.contains(product['category'])
        ? product['category'] as String
        : categories.first;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Edit Product'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Product Name',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Price',
                        prefixText: '₹ ',
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: selectedCategory,
                      decoration: const InputDecoration(
                        labelText: 'Category',
                      ),
                      items: categories
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setDialogState(() => selectedCategory = value);
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final name = nameController.text.trim();
                    final price = int.tryParse(priceController.text.trim());

                    if (name.isEmpty || price == null || price < 0) return;

                    setState(() {
                      product['name'] = name;
                      product['price'] = price;
                      product['category'] = selectedCategory;
                    });

                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // DELETE PRODUCT

  void _deleteProduct(Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Product'),
          content: Text(
            'Are you sure you want to delete ${product['name']}?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                setState(() => products.remove(product));
                Navigator.pop(dialogContext);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  // ADD CATEGORY

  void _showAddCategoryDialog() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Add Category'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'Category Name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final name = controller.text.trim();
                if (name.isEmpty) return;

                if (categories.contains(name)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Category already exists'),
                    ),
                  );
                  return;
                }

                setState(() => categories.add(name));
                Navigator.pop(dialogContext);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  // EDIT CATEGORY

  void _showEditCategoryDialog(String category) {
    final controller = TextEditingController(text: category);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Edit Category'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'Category Name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final name = controller.text.trim();
                if (name.isEmpty) return;

                setState(() {
                  final index = categories.indexOf(category);
                  if (index != -1) categories[index] = name;

                  for (final product in products) {
                    if (product['category'] == category) {
                      product['category'] = name;
                    }
                  }
                });

                Navigator.pop(dialogContext);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // DELETE CATEGORY

  void _deleteCategory(String category) {
    final hasProducts =
        products.any((product) => product['category'] == category);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Category'),
          content: Text(
            hasProducts
                ? 'This category contains products. Delete it anyway?'
                : 'Delete $category?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  categories.remove(category);
                  for (final product in products) {
                    if (product['category'] == category) {
                      product['category'] = 'Uncategorized';
                    }
                  }
                });
                Navigator.pop(dialogContext);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  // ADD STAFF

  void _showAddStaffDialog() {
    final nameController = TextEditingController();
    final roleController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Add Staff'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Staff Name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: roleController,
                decoration: const InputDecoration(labelText: 'Role'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text.trim();
                if (name.isEmpty) return;

                setState(() {
                  staff.add({
                    'name': name,
                    'role': roleController.text.trim().isEmpty
                        ? 'Staff'
                        : roleController.text.trim(),
                    'id': 'CF-${staff.length + 5}',
                    'shift': '08:00 - 16:00',
                  });
                });

                Navigator.pop(dialogContext);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  // EDIT PRICE

  void _showEditPriceDialog(Map<String, dynamic> product) {
    final controller = TextEditingController(text: product['price'].toString());

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('Change ${product['name']} Price'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'New Price',
              prefixText: '₹ ',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final price = int.tryParse(controller.text.trim());

                if (price == null || price < 0) return;

                setState(() => product['price'] = price);
                Navigator.pop(dialogContext);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
