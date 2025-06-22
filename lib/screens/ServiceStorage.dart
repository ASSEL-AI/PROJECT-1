import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class ServicesStorage {
  static const String _storageKey = 'user_services';

  // Save services to SharedPreferences
  static Future<void> saveServices(List<Map<String, dynamic>> services) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Convert File objects to paths for storage
    final serializableServices = services.map((service) {
      final Map<String, dynamic> serializableService = {...service};
      if (service['image'] is File) {
        serializableService['imagePath'] = service['image'].path;
        serializableService.remove('image');
      }
      return serializableService;
    }).toList();
    
    await prefs.setString(_storageKey, jsonEncode(serializableServices));
  }

  // Get services from SharedPreferences
  static Future<List<Map<String, dynamic>>> getServices() async {
    final prefs = await SharedPreferences.getInstance();
    final String? servicesJson = prefs.getString(_storageKey);
    
    if (servicesJson == null || servicesJson.isEmpty) {
      return [];
    }
    
    // Decode the JSON string
    List<dynamic> decodedServices = jsonDecode(servicesJson);
    
    // Convert back to maps and restore File objects
    return decodedServices.map<Map<String, dynamic>>((service) {
      final Map<String, dynamic> restoredService = {...Map<String, dynamic>.from(service)};
      if (service['imagePath'] != null) {
        restoredService['image'] = File(service['imagePath']);
        restoredService.remove('imagePath');
      }
      return restoredService;
    }).toList();
  }

  // Add a new service
  static Future<void> addService(Map<String, dynamic> newService) async {
    final services = await getServices();
    services.add(newService);
    await saveServices(services);
  }
}