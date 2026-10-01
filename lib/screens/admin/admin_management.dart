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
    },
    {
      'name': 'Caramel Macchiato',
      'price': 319,
      'category': 'Espresso Bar',
      'stock': 32,
    },
    {
      'name': 'Velvet Espresso',
      'price': 279,
      'category': 'Espresso Bar',
      'stock': 28,
    },
    {
      'name': 'Velvet Croissant',
      'price': 239,
      'category': 'Bakery',
      'stock': 20,
    },
    {
      'name': 'Cold Brew',
      'price': 249,
      'category': 'Espresso Bar',
      'stock': 38,
    },
    {
      'name': 'Stroopwafel Cupcake',
      'price': 289,
      'category': 'Bakery',
      'stock': 18,
    },
    {
      'name': 'Iced Latte',
      'price': 249,
      'category': 'Espresso Bar',
      'stock': 41,
    },
    {
      'name': 'Iced Matcha',
      'price': 349,
      'category': 'Espresso Bar',
      'stock': 24,
    },
  ];

  final List<Map<String, String>> customers = [
    {'name': 'Raj Patel', 'email': 'rajpatel@gmail.com', 'phone': '9798347684'},
    {'name': 'Rajiv Kumar', 'email': 'rajiv@gmail.com', 'phone': '9876543210'},
    {'name': 'Aarav Shah', 'email': 'aarav@gmail.com', 'phone': '9898989898'},
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

  final List<Map<String, dynamic>> inventory = [
    {'name': 'Coffee Beans', 'quantity': '12.5 kg', 'target': '20 kg'},
    {'name': 'Milk', 'quantity': '8 units', 'target': '30 units'},
    {'name': 'Cups', 'quantity': '42 pcs', 'target': '1000 pcs'},
  ];

  int selectedSection = 0;

  final List<String> sections = [
    'Products',
    'Categories',
    'Customers',
    'Staff',
    'Inventory',
    'Pricing',
  ];

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
        onPressed: () {
          _showAddDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // ==========================================================
  // SECTION SELECTOR
  // ==========================================================

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
            onTap: () {
              setState(() {
                selectedSection = index;
              });
            },
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

  // ==========================================================
  // SELECTED SECTION
  // ==========================================================

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

  // ==========================================================
  // PRODUCTS
  // ==========================================================

  Widget _productsSection() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        _sectionHeader(
          title: 'Products',
          subtitle: '${products.length} products available',
        ),

        const SizedBox(height: 15),

        ...products.map((product) => _productManagementCard(product)),
      ],
    );
  }

  Widget _productManagementCard(Map<String, dynamic> product) {
    final int stock = product['stock'];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: AppTheme.cream,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.local_cafe_outlined,
              color: AppTheme.coffee,
              size: 30,
            ),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.coffeeDark,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  product['category'],
                  style: const TextStyle(color: AppTheme.grey, fontSize: 12),
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
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₹${product['price']}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppTheme.coffeeDark,
                ),
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  _smallIconButton(Icons.edit_outlined, () {
                    _showEditProductDialog(product);
                  }),
                  const SizedBox(width: 5),
                  _smallIconButton(Icons.delete_outline, () {
                    _deleteProduct(product);
                  }),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // CATEGORIES
  // ==========================================================

  Widget _categoriesSection() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        _sectionHeader(
          title: 'Categories',
          subtitle: '${categories.length} categories',
        ),

        const SizedBox(height: 18),

        ...categories.asMap().entries.map((entry) {
          final index = entry.key;
          final category = entry.value;

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.cream,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    index == 0
                        ? Icons.local_cafe_outlined
                        : Icons.bakery_dining_outlined,
                    color: AppTheme.coffee,
                  ),
                ),

                const SizedBox(width: 14),

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
                        '${products.where((p) => p['category'] == category).length} products',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                IconButton(
                  onPressed: () {
                    _showEditCategoryDialog(category);
                  },
                  icon: const Icon(Icons.edit_outlined, color: AppTheme.coffee),
                ),

                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  // ==========================================================
  // CUSTOMERS
  // ==========================================================

  Widget _customersSection() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        _sectionHeader(
          title: 'Customers',
          subtitle: '${customers.length} registered customers',
        ),

        const SizedBox(height: 18),

        ...customers.map(
          (customer) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: AppTheme.cream,
                  child: Text(
                    customer['name']![0],
                    style: const TextStyle(
                      color: AppTheme.coffeeDark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(width: 13),

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

                IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // STAFF
  // ==========================================================

  Widget _staffSection() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        _sectionHeader(
          title: 'Staff',
          subtitle: '${staff.length} staff members',
        ),

        const SizedBox(height: 18),

        ...staff.map(
          (member) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
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

                const SizedBox(width: 14),

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

                      const SizedBox(height: 3),

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

                const Icon(Icons.chevron_right, color: AppTheme.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // INVENTORY
  // ==========================================================

  Widget _inventorySection() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        _sectionHeader(title: 'Inventory', subtitle: 'Current stock overview'),

        const SizedBox(height: 18),

        ...inventory.map((item) {
          final quantity = item['quantity'].toString();
          final target = item['target'].toString();

          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(11),
                      decoration: BoxDecoration(
                        color: AppTheme.cream,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.inventory_2_outlined,
                        color: AppTheme.coffee,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        item['name'],
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
                      style: TextStyle(fontSize: 11, color: AppTheme.grey),
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

    final result = q / t;

    if (result > 1) {
      return 1;
    }

    return result;
  }

  // ==========================================================
  // PRICING
  // ==========================================================

  Widget _pricingSection() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        _sectionHeader(title: 'Pricing', subtitle: 'Manage product prices'),

        const SizedBox(height: 18),

        ...products.map(
          (product) => Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.sell_outlined, color: AppTheme.coffee),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    product['name'],
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

                const SizedBox(width: 5),

                IconButton(
                  onPressed: () {
                    _showEditPriceDialog(product);
                  },
                  icon: const Icon(Icons.edit_outlined, size: 20),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // SECTION HEADER
  // ==========================================================

  Widget _sectionHeader({required String title, required String subtitle}) {
    return Row(
      children: [
        Expanded(
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
        ),
      ],
    );
  }

  // ==========================================================
  // SMALL ICON BUTTON
  // ==========================================================

  Widget _smallIconButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: AppTheme.cream,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 17, color: AppTheme.coffee),
      ),
    );
  }

  // ==========================================================
  // ADD DIALOG
  // ==========================================================

  void _showAddDialog() {
    if (selectedSection == 0) {
      _showAddProductDialog();
    } else if (selectedSection == 1) {
      _showAddCategoryDialog();
    } else if (selectedSection == 3) {
      _showAddStaffDialog();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Add ${sections[selectedSection]} option selected'),
        ),
      );
    }
  }

  // ==========================================================
  // ADD PRODUCT
  // ==========================================================

  void _showAddProductDialog() {
    final nameController = TextEditingController();
    final priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Add Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
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
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.trim().isEmpty ||
                    priceController.text.trim().isEmpty) {
                  return;
                }

                setState(() {
                  products.add({
                    'name': nameController.text.trim(),
                    'price': int.tryParse(priceController.text) ?? 0,
                    'category': 'Espresso Bar',
                    'stock': 0,
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

  // ==========================================================
  // EDIT PRODUCT
  // ==========================================================

  void _showEditProductDialog(Map<String, dynamic> product) {
    final priceController = TextEditingController(
      text: product['price'].toString(),
    );

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('Edit ${product['name']}'),
          content: TextField(
            controller: priceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Price',
              prefixText: '₹ ',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  product['price'] =
                      int.tryParse(priceController.text) ?? product['price'];
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

  // ==========================================================
  // DELETE PRODUCT
  // ==========================================================

  void _deleteProduct(Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Product'),
          content: Text('Are you sure you want to delete ${product['name']}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  products.remove(product);
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

  // ==========================================================
  // ADD CATEGORY
  // ==========================================================

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
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.trim().isEmpty) {
                  return;
                }

                setState(() {
                  categories.add(controller.text.trim());
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

  // ==========================================================
  // EDIT CATEGORY
  // ==========================================================

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
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final index = categories.indexOf(category);

                if (index != -1 && controller.text.trim().isNotEmpty) {
                  setState(() {
                    categories[index] = controller.text.trim();
                  });
                }

                Navigator.pop(dialogContext);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // ADD STAFF
  // ==========================================================

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
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.trim().isEmpty) {
                  return;
                }

                setState(() {
                  staff.add({
                    'name': nameController.text.trim(),
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

  // ==========================================================
  // EDIT PRICE
  // ==========================================================

  void _showEditPriceDialog(Map<String, dynamic> product) {
    final controller = TextEditingController(text: product['price'].toString());

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('Change Price'),
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
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final price = int.tryParse(controller.text);

                if (price != null) {
                  setState(() {
                    product['price'] = price;
                  });
                }

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
