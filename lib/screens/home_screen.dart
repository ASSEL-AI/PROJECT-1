import 'package:flutter/material.dart';
import 'package:hemmah_app/screens/ServiceStorage.dart';
import 'package:hemmah_app/screens/add_services_screen.dart';
import 'package:hemmah_app/screens/chat_screen.dart';
import 'package:hemmah_app/screens/settings_screen.dart';
import 'package:hemmah_app/screens/service_details.dart'; // Add this import for the service detail screen

class HomeScreen extends StatefulWidget {
  final String userName;
  final List<Map<String, dynamic>> services;

  const HomeScreen({
    super.key,
    required this.userName,
    this.services = const [], // Added services parameter with default value
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  bool isLoading = true;
  String _searchQuery = '';
  
  final List<IconData> icons = [
    Icons.home,
    Icons.add,
    Icons.settings,
    Icons.mail_outline,
  ];

  List<Map<String, dynamic>> categories = [
    {'title': 'تطبيقات الجوال', 'type': 'mobile','icon': 'assets/images/MobileApp.png'},
    {'title': 'تطوير الويب', 'type': 'web', 'icon': 'assets/images/Programming.png'},
    {'title': 'واجهات المستخدم', 'type': 'uiux', 'icon': 'assets/images/mobile.png'},
  ];

  String selectedCategory = 'mobile';

  List<Map<String, dynamic>> localServices = []; // Renamed to avoid conflicts

  // Combined services getter
  List<Map<String, dynamic>> get services => [
    ...widget.services,
    ...localServices,
  ];

  // Updated to include search filtering
  List<Map<String, dynamic>> get filteredServices {
    // First filter by category
    final categoryFiltered = services.where((s) => s['category'] == selectedCategory).toList();
    
    // If no search query, return just category filtered results
    if (_searchQuery.isEmpty) {
      return categoryFiltered;
    }
    
    // Filter by search query (looking at title)
    return categoryFiltered.where((service) {
      final title = service['title'] ?? '';
      return title.toString().toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _loadServices();
  }

  // Load services from SharedPreferences
  Future<void> _loadServices() async {
    try {
      final loadedServices = await ServicesStorage.getServices();
      setState(() {
        localServices = loadedServices;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading services: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> onItemTapped(int index) async {
    if (index == 1) {
      // Add service screen
      final newService = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddServiceScreen(categories: categories),
        ),
      );
      if (newService != null) {
        setState(() {
          localServices.add(newService);
        });
        // Save to SharedPreferences
        await ServicesStorage.saveServices(localServices);
      }
    } else if (index == 2) {
      // Settings screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SettingsScreen()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MessageScreen()),
      );
    } else {
      // Just change selected tab (e.g. home or mail)
      setState(() {
        selectedIndex = index;
      });
    }
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
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      extendBody: true,

      body: Stack(
        children: [
          // Container(color: const Color(0xFF00C180), height: 220),
          SafeArea(
            child: Column(
              children: [
                // Header + Search
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF00C180),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CircleAvatar(
                            radius: 24,
                            backgroundImage: AssetImage(
                              'assets/images/profile.png',
                            ),
                          ),
                          Row(
                            children: [
                              // const Icon(
                              //   Icons.notifications_outlined,
                              //   color: Colors.black,
                              // ),
                              const SizedBox(width: 12),
                              Text(
                                'مرحبا ${widget.userName.isEmpty ? 'محمد' : widget.userName}!',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Search bar - Updated with onChanged handler
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search, color: Colors.grey),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Search',
                                ),
                                textDirection: TextDirection.rtl,
                                onChanged: (value) {
                                  // Update search query and refresh UI
                                  setState(() {
                                    _searchQuery = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Category Chips
                SizedBox(
                  height: 90,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children:
                        categories.map((cat) {
                          final isSelected = selectedCategory == cat['type'];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategory = cat['type'];
                              });
                            },
                            child: Container(
                              width: 90,
                              margin: const EdgeInsets.only(left: 12),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? const Color(0xFF00C180)
                                        : Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Icon(
                                  //   cat['icon'],
                                  //   color:
                                  //       isSelected
                                  //           ? Colors.white
                                  //           : Colors.black,
                                  //   size: 28,
                                  // ),
                                      Image.asset(
                                      cat['icon'],
                                      width: 28,
                                      height: 28,
                                      color: isSelected ? Colors.white : Colors.black,
                                    ),
                                  const SizedBox(height: 6),
                                  Text(
                                    cat['title'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color:
                                          isSelected
                                              ? Colors.white
                                              : Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),

                const SizedBox(height: 20),

                // Title
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'الخدمات المميزة',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Services Grid
                Expanded(
                  child:
                      isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : filteredServices.isEmpty
                          ? const Center(
                            child: Text('لا توجد خدمات في هذه الفئة'),
                          )
                          : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: GridView.builder(
                              itemCount: filteredServices.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.7,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                  ),
                              itemBuilder: (context, index) {
                                final service = filteredServices[index];
                                return GestureDetector(
                                  onTap: () {
                                    // Navigate to service detail screen when service card is tapped
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => ServiceDetailScreen(
                                              service: service,
                                            ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        // Image area
                                        Container(
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                const BorderRadius.vertical(
                                                  top: Radius.circular(20),
                                                ),
                                          ),
                                          child:
                                              service['image'] != null
                                                  ? ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.vertical(
                                                          top: Radius.circular(
                                                            20,
                                                          ),
                                                        ),
                                                    child: Image.file(
                                                      service['image'],
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                  : const Icon(
                                                    Icons.image,
                                                    size: 40,
                                                    color: Colors.grey,
                                                  ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                service['title'] ?? '',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                '${service['price'] ?? 0} ريال',
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 4,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: const Color(
                                                    0xFF00C180,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: const Text(
                                                  'التالي',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: List.generate(
                                                  5,
                                                  (i) => const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                    size: 14,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                ),
              ],
            ),
          ),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        height: 85,
        decoration: BoxDecoration(
          color: const Color(0xFF000000),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            icons.length,
            (index) => buildNavItem(icon: icons[index], index: index),
          ),
        ),
      ),
    );
  }
}