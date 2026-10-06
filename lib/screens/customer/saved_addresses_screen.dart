import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class SavedAddressesScreen extends StatefulWidget {
  const SavedAddressesScreen({super.key});

  @override
  State<SavedAddressesScreen> createState() => _SavedAddressesScreenState();
}

class _SavedAddressesScreenState extends State<SavedAddressesScreen> {
  List<Map<String, dynamic>> addresses = [
    {
      'title': 'Home',
      'name': 'Raj Patel',
      'address': 'Silver Stone St. 2, Nana Mova Road',
      'city': 'Rajkot, Gujarat - 360004',
      'phone': '+91 9798347684',
    },
  ];

  // =====================================================
  // ADD / EDIT ADDRESS
  // =====================================================

  void _showAddressForm({int? index}) {
    final existing = index != null ? addresses[index] : null;

    final titleController = TextEditingController(
      text: existing?['title'] ?? '',
    );

    final nameController = TextEditingController(
      text: existing?['name'] ?? '',
    );

    final addressController = TextEditingController(
      text: existing?['address'] ?? '',
    );

    final cityController = TextEditingController(
      text: existing?['city'] ?? '',
    );

    final phoneController = TextEditingController(
      text: existing?['phone'] ?? '',
    );

    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(
              20,
              15,
              20,
              25,
            ),
            decoration: const BoxDecoration(
              color: AppTheme.cream,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25),
              ),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 45,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      index == null ? 'Add New Address' : 'Edit Address',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.coffeeDark,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _field(
                      controller: titleController,
                      label: 'Address Title',
                      hint: 'Home / Work / Other',
                      icon: Icons.label_outline,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Enter address title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    _field(
                      controller: nameController,
                      label: 'Full Name',
                      hint: 'Enter your name',
                      icon: Icons.person_outline,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    _field(
                      controller: addressController,
                      label: 'Address',
                      hint: 'House no, street, area',
                      icon: Icons.home_outlined,
                      maxLines: 2,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Enter address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    _field(
                      controller: cityController,
                      label: 'City / State / Pincode',
                      hint: 'Rajkot, Gujarat - 360004',
                      icon: Icons.location_city_outlined,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Enter city and pincode';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    _field(
                      controller: phoneController,
                      label: 'Phone Number',
                      hint: '10 digit mobile number',
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null ||
                            !RegExp(
                              r'^[0-9]{10}$',
                            ).hasMatch(value.trim())) {
                          return 'Enter valid 10 digit number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          if (!formKey.currentState!.validate()) {
                            return;
                          }

                          final newAddress = {
                            'title': titleController.text.trim(),
                            'name': nameController.text.trim(),
                            'address': addressController.text.trim(),
                            'city': cityController.text.trim(),
                            'phone': phoneController.text.trim(),
                          };

                          setState(() {
                            if (index == null) {
                              addresses.add(newAddress);
                            } else {
                              addresses[index] = newAddress;
                            }
                          });

                          Navigator.pop(sheetContext);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                index == null
                                    ? 'Address added successfully'
                                    : 'Address updated successfully',
                              ),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        child: Text(
                          index == null ? 'Save Address' : 'Update Address',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // =====================================================
  // TEXT FIELD
  // =====================================================

  Widget _field({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
      ),
    );
  }

  // =====================================================
  // DELETE ADDRESS
  // =====================================================

  void _deleteAddress(int index) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text(
            'Delete Address?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppTheme.coffeeDark,
            ),
          ),
          content: const Text(
            'Are you sure you want to delete this address?',
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
                  addresses.removeAt(index);
                });

                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Address deleted successfully'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Saved Addresses',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.coffeeDark,
        foregroundColor: Colors.white,
        onPressed: () {
          _showAddressForm();
        },
        child: const Icon(Icons.add),
      ),
      body: addresses.isEmpty
          ? _emptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final address = addresses[index];

                return _addressCard(
                  address,
                  index,
                );
              },
            ),
    );
  }

  // =====================================================
  // ADDRESS CARD
  // =====================================================

  Widget _addressCard(
    Map<String, dynamic> address,
    int index,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: AppTheme.cream,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.location_on,
                  color: AppTheme.coffee,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  address['title'],
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.coffeeDark,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  _showAddressForm(index: index);
                },
                icon: const Icon(
                  Icons.edit_outlined,
                  size: 20,
                ),
              ),
              IconButton(
                onPressed: () {
                  _deleteAddress(index);
                },
                icon: const Icon(
                  Icons.delete_outline,
                  size: 20,
                ),
              ),
            ],
          ),
          const Divider(height: 25),
          Text(
            address['name'],
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            address['address'],
            style: const TextStyle(
              color: AppTheme.grey,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            address['city'],
            style: const TextStyle(
              color: AppTheme.grey,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.phone_outlined,
                size: 16,
                color: AppTheme.coffee,
              ),
              const SizedBox(width: 6),
              Text(
                address['phone'],
                style: const TextStyle(
                  color: AppTheme.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =====================================================
  // EMPTY STATE
  // =====================================================

  Widget _emptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                color: AppTheme.cream,
                borderRadius: BorderRadius.circular(45),
              ),
              child: const Icon(
                Icons.location_off_outlined,
                size: 45,
                color: AppTheme.coffee,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'No Saved Addresses',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppTheme.coffeeDark,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Add an address to make checkout faster.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.grey,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                _showAddressForm();
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Address'),
            ),
          ],
        ),
      ),
    );
  }
}
