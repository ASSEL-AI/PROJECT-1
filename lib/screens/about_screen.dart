import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Add this import

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  // Add this method to handle email launch
  Future<void> _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@himmah.app',
    );
    
    if (!await launchUrl(emailLaunchUri)) {
      throw Exception('Could not launch email client');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00C180),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              'من نحن',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ListView(
                  children: [
                    const Text(
                      'مرحبا بك في تطبيق همة 👋',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                        fontFamily: String.fromEnvironment(""),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'نحن فريق شغوف يقدم تجربة سلسة وسريعة تساعدك على حجز مصممين، مطورين، ومصممين تقنيين بكل سهولة واحترافية.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontFamily: String.fromEnvironment(""),
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        Icon(Icons.edit, color: Color(0xFF00C180)),
                        SizedBox(width: 8),
                        Text(
                          'هدفنا',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 21,
                            fontFamily: String.fromEnvironment(""),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'هو ربط أصحاب المشاريع بالأشخاص المبدعين في مجال التقنية، من خلال ضمنة موثوقة توفر الوقت والجهد.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontFamily: String.fromEnvironment(""),
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        Icon(Icons.visibility, color: Color(0xFF00C180)),
                        SizedBox(width: 8),
                        Text(
                          'رؤيتنا',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 21,
                            fontFamily: String.fromEnvironment(""),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'أن تكون المنصة الأولى التي يعتمد عليها الأفراد والشركات لإيجاد المواهب التقنية بكل احتراف وسرعة.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontFamily: String.fromEnvironment(""),
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        Icon(Icons.thumb_up, color: Color(0xFF00C180)),
                        SizedBox(width: 8),
                        Text(
                          'قيُمنا',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 21,
                            fontFamily: String.fromEnvironment(""),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'أن تكون المنصة الأولى التي يعتمد عليها الأفراد والشركات لإيجاد المواهب التقنية بكل احتراف وسرعة.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontFamily: String.fromEnvironment(""),
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 20),
     const Row(
                      children: [
                        Icon(Icons.email, color: Color(0xFF00C180)),
                        SizedBox(width: 8),
                        Text(
                          'البريد الإلكتروني',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 21,
                            fontFamily: String.fromEnvironment(""),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    
                    // Updated TextButton with email launch functionality
                    TextButton(
                      onPressed: _launchEmail, // Changed to use the email launch method
                      child: const Text(
                        'support@himmah.app',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontFamily: String.fromEnvironment(""),
                          fontSize: 17,
                          color: Color(0xFF00C180), // Added color to make it look like a link
                          decoration: TextDecoration.underline, // Added underline for better UX
                        ),
                      ),
                    ),
                    
                    // Updated back button with green styling
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00C180), // Green background
                        foregroundColor: Colors.white, // White text
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context), // Added navigation functionality
                      child: const Text(
                        'رجوع', // Fixed typo in Arabic text (was 'رحوع')
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20), // Add some bottom padding
              
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
