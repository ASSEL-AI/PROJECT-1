import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:hemmah_app/screens/home_screen.dart';
import 'package:hemmah_app/screens/settings_screen.dart';
import 'package:hemmah_app/screens/chat_screen.dart'; // Fixed import with .dart extension
import 'package:hemmah_app/screens/ServiceStorage.dart';

class AddServiceScreen extends StatefulWidget {
  final List<Map<String, dynamic>> categories;
  final bool inBottomSheet;
  final Function(Map<String, dynamic>)? onServiceAdded;

  const AddServiceScreen({
    super.key,
    required this.categories,
    this.inBottomSheet = false,
    this.onServiceAdded,
  });

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  String? selectedCategory;
  String? deliveryTime;
  File? _selectedImage;

  // Set selectedIndex to 1 for add service page
  int selectedIndex = 1;

  final List<IconData> icons = [
    Icons.home,
    Icons.add,
    Icons.settings,
    Icons.mail_outline,
  ];

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // Handle navigation
  void onItemTapped(int index) {
    if (index == selectedIndex) return;

    // Show confirmation if user is leaving with unsaved changes
    if (titleController.text.isNotEmpty ||
        priceController.text.isNotEmpty ||
        _selectedImage != null) {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text('هل أنت متأكد؟'),
              content: const Text(
                'ستفقد التغييرات التي قمت بها. هل تريد المتابعة؟',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('إلغاء'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _navigateToScreen(index);
                  },
                  child: const Text('متابعة'),
                ),
              ],
            ),
      );
    } else {
      _navigateToScreen(index);
    }
  }

  void _navigateToScreen(int index) {
    Widget screen;
    switch (index) {
      case 0:
        screen = HomeScreen(userName: '');
        break;
      case 2:
        screen = const SettingsScreen();
        break;
      case 3:
        screen = const MessageScreen();
        break;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  Widget buildNavItem({required IconData icon, required int index}) {
    final bool isActive = selectedIndex == index;

    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Icon(
          icon,
          size: 32,
          color: isActive ? const Color(0xFF0ACF83) : const Color(0xFFB4B4B4),
          shadows:
              isActive
                  ? [
                    Shadow(
                      color: const Color(0xFF0ACF83).withOpacity(0.6),
                      blurRadius: 12,
                      offset: const Offset(0, 3),
                    ),
                  ]
                  : [],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryGreen = const Color(0xFF0ACF83);

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text("إضافة خدمة جديدة"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle unsaved changes when using back button
            if (titleController.text.isNotEmpty ||
                priceController.text.isNotEmpty ||
                _selectedImage != null) {
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: const Text('هل أنت متأكد؟'),
                      content: const Text(
                        'ستفقد التغييرات التي قمت بها. هل تريد المتابعة؟',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('إلغاء'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text('متابعة'),
                        ),
                      ],
                    ),
              );
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: primaryGreen.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: primaryGreen, width: 2),
                  ),
                  child: Center(
                    child:
                        _selectedImage != null
                            ? Image.file(_selectedImage!)
                            : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.download,
                                  size: 40,
                                  color: Colors.black,
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'ارفاق صور او فيديو',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildTextField(
                controller: titleController,
                label: '*عنوان الخدمة',
                primaryGreen: primaryGreen,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: priceController,
                label: '*سعر الخدمة',
                keyboardType: TextInputType.number,
                primaryGreen: primaryGreen,
              ),
              const SizedBox(height: 16),
              _buildDropdown(
                label: '*تصنيف الخدمة',
                value: selectedCategory,
                items:
                    widget.categories.map((cat) {
                      return DropdownMenuItem<String>(
                        value: cat['type'],
                        child: Text(cat['title']),
                      );
                    }).toList(),
                onChanged: (value) => setState(() => selectedCategory = value),
                primaryGreen: primaryGreen,
              ),
              const SizedBox(height: 16),
              _buildDropdown(
                label: '*مدة التسليم',
                value: deliveryTime,
                items:
                    ['يوم واحد', 'يومان', '3 أيام', 'أسبوع'].map((time) {
                      return DropdownMenuItem<String>(
                        value: time,
                        child: Text(time),
                      );
                    }).toList(),
                onChanged: (value) => setState(() => deliveryTime = value),
                primaryGreen: primaryGreen,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate() &&
                      selectedCategory != null &&
                      deliveryTime != null) {
                    final newService = {
                      'title': titleController.text,
                      'price': priceController.text,
                      'category':
                          selectedCategory, // Changed from 'type' to 'category'
                      'type':
                          selectedCategory, // Keep 'type' for backward compatibility
                      'delivery': deliveryTime,
                      'rating': 5,
                      'image': _selectedImage,
                      'timestamp':
                          DateTime.now()
                              .millisecondsSinceEpoch, // Add timestamp for sorting
                    };

                    // If using the callback
                    if (widget.onServiceAdded != null) {
                      widget.onServiceAdded!(newService);
                    } else {
                      // Original method - return data to previous screen
                      Navigator.pop(context, newService);
                    }
                  }
                },
                child: const Text('نشر الخدمة', style: TextStyle(fontSize: 16)),
              ),
              // Add padding at bottom to avoid content being hidden by navbar
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      // Bottom Navigation Bar
      // bottomNavigationBar: Container(
      //   margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      //   padding: const EdgeInsets.symmetric(horizontal: 24),
      //   height: 85,
      //   decoration: BoxDecoration(
      //     color: const Color(0xFF000000),
      //     borderRadius: BorderRadius.circular(40),
      //   ),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: List.generate(
      //       icons.length,
      //       (index) => buildNavItem(icon: icons[index], index: index),
      //     ),
      //   ),
      // ),
    
    
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    required Color primaryGreen,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator:
          (value) => value == null || value.isEmpty ? 'هذا الحقل مطلوب' : null,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: primaryGreen),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryGreen, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<DropdownMenuItem<String>> items,
    required void Function(String?) onChanged,
    required Color primaryGreen,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: primaryGreen),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryGreen, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      items: items,
      onChanged: onChanged,
      validator: (value) => value == null ? 'هذا الحقل مطلوب' : null,
    );
  }
}
