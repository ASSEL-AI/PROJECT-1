import 'package:flutter/material.dart';

class DesignerProfileScreen extends StatelessWidget {
  final Map<String, dynamic> service;
  
  const DesignerProfileScreen({
    Key? key,
    required this.service,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      
                      // Designer Avatar
                      Center(
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF00C180),
                          ),
                          child: const Center(
                            child: Text(
                              "ه",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Designer Name
                      const Text(
                        "أحمد عبد الله",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      const SizedBox(height: 4),
                      
                      // Designer Title
                      const Text(
                        "UI UX Designer",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      
                      const SizedBox(height: 8),
                      
                      // Rating Stars
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          5,
                          (index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 20,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Designer Description
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Description Row 1
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    "مصمم محترف يقدم لك تجربة استخدام سلسة وجذابة نهائية بصرية واضحة وعصرية",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.circle,
                                  color: Color(0xFF00C180),
                                  size: 6,
                                ),
                              ],
                            ),
                            
                            SizedBox(height: 16),
                            
                            // Description Row 2
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    "خبرة في تصميم واجهات التطبيقات والمواقع الإلكترونية",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.circle,
                                  color: Color(0xFF00C180),
                                  size: 6,
                                ),
                              ],
                            ),
                            
                            SizedBox(height: 16),
                            
                            // Description Row 3
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    "تصميم يركز على راحة المستخدم وسهولة التعامل",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.circle,
                                  color: Color(0xFF00C180),
                                  size: 6,
                                ),
                              ],
                            ),
                            
                            SizedBox(height: 16),
                            
                            // Description Row 4
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    "متقن لأدوات التصميم مثل Adobe XD, Figma",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.circle,
                                  color: Color(0xFF00C180),
                                  size: 6,
                                ),
                              ],
                            ),
                            
                            SizedBox(height: 16),
                            
                            // Description Row 5
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    "فهم عميق لسلوك المستخدم وتجربة المستخدم",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.circle,
                                  color: Color(0xFF00C180),
                                  size: 6,
                                ),
                              ],
                            ),
                            
                            SizedBox(height: 16),
                            
                            // Description Row 6
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    "تسليم احترافي في الوقت المتفق عليه",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.circle,
                                  color: Color(0xFF00C180),
                                  size: 6,
                                ),
                              ],
                            ),
                            
                            SizedBox(height: 16),
                            
                            // Description Row 7
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    "قابلية التعديل حسب ملاحظاتك",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.circle,
                                  color: Color(0xFF00C180),
                                  size: 6,
                                ),
                              ],
                            ),
                            
                            SizedBox(height: 16),
                            
                            // Description Row 8
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    "احجز الآن وابدأ بتحويل فكرتك إلى تصميم يبهر جمهورك!",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.circle,
                                  color: Color(0xFF00C180),
                                  size: 6,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Certificates Section
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "شهادات معتمدة:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      
                      const SizedBox(height: 12),
                      
                      // Certificate 1
                      _buildCertificate("Google UX Design Certificate"),
                      
                      const SizedBox(height: 8),
                      
                      // Certificate 2
                      _buildCertificate("Figma for UX/UI - Advanced Techniques"),
                      
                      const SizedBox(height: 8),
                      
                      // Certificate 3
                      _buildCertificate("UI Design Principles - Coursera"),
                      
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
            
            // Action Buttons
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Contact Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Contact functionality
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00C180),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "تواصل",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Back Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade800,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "رجوع",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
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
  
  Widget _buildCertificate(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
          ),
          textAlign: TextAlign.right,
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: const Color(0xFF00C180),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Icon(
            Icons.check,
            color: Colors.white,
            size: 12,
          ),
        ),
      ],
    );
  }
}