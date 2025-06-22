import 'package:flutter/material.dart';
import 'package:hemmah_app/screens/ChatDetailScreen.dart';
import 'package:hemmah_app/screens/home_screen.dart';
import 'package:hemmah_app/screens/settings_screen.dart';
import 'package:hemmah_app/screens/add_services_screen.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  // Set selectedIndex to 3 for message screen
  int selectedIndex = 3;
  // Add search query state
  String searchQuery = "";
  // Add search controller
  final TextEditingController _searchController = TextEditingController();

  final List<IconData> icons = [
    Icons.home,
    Icons.add,
    Icons.settings,
    Icons.mail_outline,
  ];

  final List<Map<String, String>> messages = const [
    {"time": "1:20", "name": "احمد عبدالله", "msg": "مرحبا", "isAvatar": "true"},
    {"time": "5:30", "name": "خالد عمر", "msg": "مرحبا", "isAvatar": "false"},
    {"time": "7:50", "name": "محمد سعد", "msg": "مرحبا", "isAvatar": "true"},
    {"time": "10:00", "name": "عبدالله فيصل", "msg": "مرحبا", "isAvatar": "true"},
    {"time": "2:25", "name": "تركي عبدالعزيز", "msg": "مرحبا", "isAvatar": "false"},
    {"time": "4:21", "name": "فهد عبدالله", "msg": "مرحبا", "isAvatar": "true"},
    {"time": "9:10", "name": "احمد خالد", "msg": "مرحبا", "isAvatar": "true"},
    {"time": "11:50", "name": "ريان ثابت", "msg": "مرحبا", "isAvatar": "false"},
    
    {"time": "11:50", "name": "bhumit", "msg": "مرحبا", "isAvatar": "false"},
  ];
  
  // Add getter for filtered messages
  List<Map<String, String>> get filteredMessages => searchQuery.isEmpty
      ? messages
      : messages.where((message) => 
          message["name"]!.contains(searchQuery) || 
          message["msg"]!.contains(searchQuery)
      ).toList();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Handle navigation
  void onItemTapped(int index) {
    if (index == selectedIndex) return;
    
    Widget screen;
    switch (index) {
      case 0:
        screen = HomeScreen(userName: '');
        break;
      case 1:
        // Use dummy categories since we don't have them here
        final categories = [
          {'title': 'تطبيقات الجوال', 'type': 'mobile', 'icon': Icons.smartphone},
          {'title': 'تطوير الويب', 'type': 'web', 'icon': Icons.code},
          {'title': 'واجهات المستخدم', 'type': 'uiux', 'icon': Icons.devices},
        ];
        screen = AddServiceScreen(categories: categories);
        break;
      case 2:
        screen = const SettingsScreen();
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
          color: isActive
              ? const Color(0xFF0ACF83)
              : const Color(0xFFB4B4B4),
          shadows: isActive
              ? [
                  Shadow(
                    color: const Color(0xFF0ACF83).withOpacity(0.6),
                    blurRadius: 12,
                    offset: const Offset(0, 3),
                  )
                ]
              : [],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      extendBody: true,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            color: const Color(0xFF00C569),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'الرسائل',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.black54),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: const InputDecoration(
                            hintText: 'بحث',
                            border: InputBorder.none,
                          ),
                          textDirection: TextDirection.rtl,
                          onChanged: (value) {
                            setState(() {
                              searchQuery = value;
                            });
                          },
                        ),
                      ),
                      // Add clear button when search has text
                      if (searchQuery.isNotEmpty)
                        IconButton(
                          icon: const Icon(Icons.clear, size: 18),
                          onPressed: () {
                            setState(() {
                              searchQuery = '';
                              _searchController.clear();
                            });
                          },
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredMessages.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'لا توجد نتائج للبحث',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredMessages.length,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemBuilder: (context, index) {
                      final item = filteredMessages[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatDetailScreen(userName: item["name"]!),
                            ),
                          );
                        },
                        child: ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                          leading: Text(
                            item["time"]!,
                            style: const TextStyle(fontSize: 12),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    item["name"]!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    item["msg"]!,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 8),
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: item["isAvatar"] == "true"
                                    ? Colors.transparent
                                    : Colors.green[300],
                                child: item["isAvatar"] == "true"
                                    ? Icon(Icons.person, color: Colors.green[300])
                                    : const Icon(Icons.person, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      
      // // Bottom Navigation Bar
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
}