import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/app/core/theme/app_colors.dart';

class LogoutDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const LogoutDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      backgroundColor: AppColors.background,
      child: Container(
        padding: const EdgeInsets.all(24),
        width: context.width * 0.85,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Logout?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text("Are you sure you want to exit?"),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back(); // Close dialog
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.fgLink,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Cancel"),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                      onConfirm();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.error,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Yes"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
