import 'package:flutter/material.dart';
import 'package:hemmah_app/screens/Custom_navbar';
import 'package:hemmah_app/screens/ServiceStorage.dart';
import 'package:hemmah_app/screens/home_screen.dart';
import 'package:hemmah_app/screens/add_services_screen.dart';
import 'package:hemmah_app/screens/settings_screen.dart';
import 'package:hemmah_app/screens/chat_screen.dart';

class MainContainer extends StatefulWidget {
  const MainContainer({super.key});

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _animationController;
  List<Map<String, dynamic>> services = [];
  
  // Initialize with lazy loading to avoid unnecessary rebuilds
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    
    // Load services when the container initializes
    _loadServices();
    
    // Initialize screens
    _screens = [
      HomeScreen(userName: '', services: services),
      Container(), // Placeholder - Add service is handled with modal
      const SettingsScreen(),
      const MessageScreen(),
    ];
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Load services from local storage
  Future<void> _loadServices() async {
    try {
      final loadedServices = await ServicesStorage.getServices();
      setState(() {
        services = loadedServices;
        // Update the HomeScreen with new services
        _screens[0] = HomeScreen(userName: '', services: services);
      });
    } catch (e) {
      print('Error loading services: $e');
    }
  }

  // Save services to local storage
  Future<void> _saveServices() async {
    try {
      await ServicesStorage.saveServices(services);
    } catch (e) {
      print('Error saving services: $e');
    }
  }

  void _onItemTapped(int index) {
    if (index == 1) {
      // Show add service modal
      _showAddServiceModal();
      return;
    }

    setState(() {
      _selectedIndex = index;
    });

    // Run the animation
    _animationController.reset();
    _animationController.forward();
  }
void _showAddServiceModal() {
  // Get the categories from the state
  final categories = [
    {'title': 'تطبيقات الجوال', 'type': 'mobile', 'icon': Icons.smartphone},
    {'title': 'تطوير الويب', 'type': 'web', 'icon': Icons.code},
    {'title': 'واجهات المستخدم', 'type': 'uiux', 'icon': Icons.devices},
  ];
  
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return FractionallySizedBox(
        heightFactor: 0.9, // Takes 90% of screen height
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: AddServiceScreen(
            categories: categories,
            inBottomSheet: true,
            onServiceAdded: (newService) {
              // Add timestamp for sorting
              newService['timestamp'] = DateTime.now().millisecondsSinceEpoch;
              
              // Add the new service to the list
              setState(() {
                services.add(newService);
              });
              
              // Save to local storage
              _saveServices();
              
              // Refresh the home screen
              setState(() {
                _screens[0] = HomeScreen(userName: '', services: services);
              });
              
              // Close the modal
              Navigator.pop(context);
            },
          ),
        ),
      );
    },
  );
}
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // Handle back button presses
      onWillPop: () async {
        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        extendBody: true,
        // Use IndexedStack to preserve state of all screens
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar: CustomBottomNavBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }
}