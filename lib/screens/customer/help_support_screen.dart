import 'package:flutter/material.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final TextEditingController searchController = TextEditingController();

  final TextEditingController problemController = TextEditingController();

  final List<Map<String, String>> faqs = [
    {
      "question": "How can I place an order?",
      "answer":
          "Select your favorite coffee from the Menu, customize it, add it to Cart and proceed to Checkout.",
    },
    {
      "question": "How can I track my order?",
      "answer":
          "You can check your order status from the My Orders section in your profile.",
    },
    {
      "question": "How can I cancel my order?",
      "answer":
          "Open your order details and contact support for cancellation assistance.",
    },
    {
      "question": "What payment methods are available?",
      "answer": "Currently Cash On Delivery is available in the app demo.",
    },
    {
      "question": "How can I change my delivery address?",
      "answer": "Go to Checkout and select Change or Add New Address.",
    },
    {
      "question": "How can I reset my password?",
      "answer":
          "From the Login screen, select Forgot Password and follow the verification steps.",
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    problemController.dispose();
    super.dispose();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void showReportProblem() {
    problemController.clear();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Color(0xFFF8F3ED),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(28),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Report a Problem",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3E2723),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  "Tell us about your problem and our support team will help you.",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: problemController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: "Describe your problem",
                    hintText: "Enter your issue here...",
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      if (problemController.text.trim().isEmpty) {
                        showMessage(
                          "Please describe your problem",
                        );
                        return;
                      }

                      Navigator.pop(context);

                      showMessage(
                        "Your problem has been submitted",
                      );
                    },
                    child: const Text(
                      "Submit Problem",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  void callSupport() {
    showMessage(
      "Support calling feature is available in the demo.",
    );
  }

  void emailSupport() {
    showMessage(
      "Email support feature is available in the demo.",
    );
  }

  void liveChat() {
    showMessage(
      "Live Chat will be available soon.",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3ED),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F3ED),
        title: const Text(
          "Help & Support",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF3E2723),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            20,
            10,
            20,
            30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: const Color(0xFF3E2723),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.support_agent,
                      size: 42,
                      color: Colors.white,
                    ),
                    SizedBox(height: 14),
                    Text(
                      "How can we help you?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 7),
                    Text(
                      "We're here to make your CAFFIORA experience better.",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // SEARCH
              const Text(
                "Search Help",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3E2723),
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search your question...",
                  prefixIcon: const Icon(
                    Icons.search,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      searchController.clear();
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.clear,
                    ),
                  ),
                ),
                onChanged: (_) {
                  setState(() {});
                },
              ),

              const SizedBox(height: 25),

              // FAQ
              const Text(
                "Frequently Asked Questions",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3E2723),
                ),
              ),

              const SizedBox(height: 10),

              ...faqs
                  .where(
                    (faq) => faq["question"]!.toLowerCase().contains(
                          searchController.text.toLowerCase(),
                        ),
                  )
                  .map(
                    (faq) => Card(
                      elevation: 0,
                      margin: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                      ),
                      child: ExpansionTile(
                        tilePadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        childrenPadding: const EdgeInsets.fromLTRB(
                          16,
                          0,
                          16,
                          16,
                        ),
                        leading: const Icon(
                          Icons.help_outline,
                          color: Color(0xFF6F4E37),
                        ),
                        title: Text(
                          faq["question"]!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              faq["answer"]!,
                              style: const TextStyle(
                                color: Colors.grey,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

              const SizedBox(height: 20),

              // CONTACT
              const Text(
                "Contact Us",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3E2723),
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: contactCard(
                      icon: Icons.phone,
                      title: "Call Support",
                      subtitle: "Talk to us",
                      onTap: callSupport,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: contactCard(
                      icon: Icons.email_outlined,
                      title: "Email Support",
                      subtitle: "Send an email",
                      onTap: emailSupport,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              contactCard(
                icon: Icons.chat_bubble_outline,
                title: "Live Chat",
                subtitle: "Chat with our support team",
                onTap: liveChat,
                fullWidth: true,
              ),

              const SizedBox(height: 25),

              // ORDER SUPPORT
              const Text(
                "Order Support",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3E2723),
                ),
              ),

              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    supportOption(
                      Icons.local_shipping_outlined,
                      "Order not received",
                    ),
                    supportOption(
                      Icons.inventory_2_outlined,
                      "Wrong item received",
                    ),
                    supportOption(
                      Icons.remove_shopping_cart_outlined,
                      "Missing item",
                    ),
                    supportOption(
                      Icons.report_problem_outlined,
                      "Damaged item",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // REPORT PROBLEM
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton.icon(
                  onPressed: showReportProblem,
                  icon: const Icon(
                    Icons.report_problem_outlined,
                  ),
                  label: const Text(
                    "Report a Problem",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF3E2723),
                    side: const BorderSide(
                      color: Color(0xFF6F4E37),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // APP INFORMATION
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE3D8),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.coffee,
                      size: 32,
                      color: Color(0xFF6F4E37),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "CAFFIORA",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3E2723),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Premium Coffee Experience",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "App Version 1.0.0",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget contactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool fullWidth = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: fullWidth ? double.infinity : null,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFEDE3D8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF6F4E37),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget supportOption(
    IconData icon,
    String title,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: const Color(0xFFEDE3D8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF6F4E37),
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 14,
      ),
      onTap: () {
        showMessage(
          "Please contact support for assistance.",
        );
      },
    );
  }
}
