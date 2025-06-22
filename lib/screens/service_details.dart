import 'package:flutter/material.dart';
import 'package:hemmah_app/screens/DesignerProfileScreen.dart';

class ServiceDetailScreen extends StatelessWidget {
  final Map<String, dynamic> service;

  const ServiceDetailScreen({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Service Image
                    if (service['image'] != null)
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                        ),
                        child: Image.file(
                          service['image'],
                          fit: BoxFit.cover,
                        ),
                      )
                    else
                      Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.grey.shade200,
                        child: const Center(
                          child: Icon(
                            Icons.image,
                            size: 50,
                            color: Colors.grey,
                          ),
                        ),
                      ),

                    // Provider Info Card
                    Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2B2B2B),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Stars Rating
                                Row(
                                  children: List.generate(
                                    5,
                                    (index) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                // User type
                                const Text(
                                  "UI UX Designer",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // User name
                              const Text(
                                "أحمد عبد الله",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 8),
                          // Avatar
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xFF00C180),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Service Title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        service['title'] ?? "تنفيذ تطبيق IOS باستخدام Flutter",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Service Description
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF00C180), width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "وصف الخدمة",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF00C180),
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.info_outline,
                                color: Color(0xFF00C180),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            "هل ترغب في إنشاء تطبيق iOS احترافي؟",
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "سأقدم لك المساعدة في تحويل فكرتك إلى تطبيق متكامل باستخدام Flutter ليعمل بكفاءة عالية على iOS.",
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 16),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "ما تتضمنه هذه الخدمة:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.right,
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.check_circle,
                                color: Color(0xFF00C180),
                                size: 20,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          _buildBulletPoint("تصميم واجهات المستخدم (UI/UX) باستخدام Flutter"),
                          _buildBulletPoint("برمجة التطبيق وفق المواصفات المطلوبة"),
                          _buildBulletPoint("اختبار كامل للتطبيق وإصلاح الأخطاء"),
                          _buildBulletPoint("نسخ قابلة للتثبيت على متجر iOS"),
                          _buildBulletPoint("تكامل مع واجهات API الخارجية إذا لزم الأمر"),
                          _buildBulletPoint("دعم فني لمدة 30 يوم بعد التسليم"),
                          _buildBulletPoint("تحسينات أداء وتجربة المستخدم"),
                          _buildBulletPoint("المساعدة في نشر التطبيق (اختياري)"),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Price Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            "السعر:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${service['price'] ?? 800} ريال",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFF00C180),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Delivery Time
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            service['delivery'] ?? "5 أيام",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF00C180),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "مدة التنفيذ:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 100), // Space for buttons
                  ],
                ),
              ),
            ),
            
            // Bottom Action Buttons
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                            Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DesignerProfileScreen(service: service),
      ),
    );
                        // TODO: Implement checkout/next action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00C180),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "التالي",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF00C180)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "رجوع",
                      style: TextStyle(
                        color: Color(0xFF00C180),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
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
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Color(0xFF00C180),
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}