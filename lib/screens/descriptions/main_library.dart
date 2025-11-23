
import 'package:flutter/material.dart';
import 'package:traveleaze/utilities/constants/colors.dart';
import 'package:traveleaze/utilities/constants/sizes.dart';

class MainLibraryDetailScreen extends StatelessWidget {
  final String title;
  final String imagePath;
  final String description;

  const MainLibraryDetailScreen({
    super.key,
    required this.title,
    required this.imagePath,
    this.description = '',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          title,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'feature_${title}_hero',
                  child: Image.asset(
                    imagePath,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: double.infinity,
                      height: 200,
                      color: AppColors.grey,
                      child: const Icon(Icons.broken_image, size: 56, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),
            
                // Content
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: AppSizes.spaceBtwItems),
            
                      // Paragraphs to mimic the screenshot
                      const Text(
                        'The main library at Soroti University is a hub of knowledge and resources for students and researchers. It offers a vast collection of books, journals, and digital materials across various disciplines.',
                        style: TextStyle(fontSize: 16, height: 1.4),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Equipped with modern facilities, the library provides a conducive environment for studying and collaboration. Students can access computers, Wi-Fi, and quiet study areas to enhance their learning experience.',
                        style: TextStyle(fontSize: 16, height: 1.4),
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(fontSize: 16, color: Colors.black, height: 1.4),
                          children: [
                            const TextSpan(text: 'Located on '),
                            TextSpan(
                                text: 'Ground Floor, Teaching Block',
                                style: TextStyle(color: AppColors.primary, decoration: TextDecoration.underline)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
            
                      // Add to itinerary button (pill)
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // TODO: add itinerary action
                          },
                          icon: const Icon(Icons.add, size: 18),
                          label: const Text('Add to Itinerary'),
                          style: ElevatedButton.styleFrom(
                            
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                            elevation: 2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
 
}
