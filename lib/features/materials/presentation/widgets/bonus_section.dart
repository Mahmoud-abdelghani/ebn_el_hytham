import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

class BonusSection extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final int bonusApplied;
  final void Function(int) onApply;
  final VoidCallback onSendToServer;

  const BonusSection({
    super.key,
    required this.formKey,
    required this.controller,
    required this.bonusApplied,
    required this.onApply,
    required this.onSendToServer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ScreenSize.width * 0.045),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: context.glassBorder, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.add_circle_outline_rounded,
                color: context.accent,
                size: ScreenSize.height * 0.024,
              ),
              SizedBox(width: ScreenSize.width * 0.025),
              Text(
                'Apply Bonus to All Students',
                style: TextStyle(
                  color: context.onBackground,
                  fontSize: ScreenSize.height * 0.018,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              if (bonusApplied > 0)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenSize.width * 0.025,
                    vertical: ScreenSize.height * 0.005,
                  ),
                  decoration: BoxDecoration(
                    color: context.accent.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '+$bonusApplied pts',
                    style: TextStyle(
                      color: context.accent,
                      fontSize: ScreenSize.height * 0.014,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: ScreenSize.height * 0.015),
          Form(
            key: formKey,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: context.onBackground,
                      fontSize: ScreenSize.height * 0.017,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter bonus (2–5)',
                      hintStyle: TextStyle(
                        color: context.textMuted,
                        fontSize: ScreenSize.height * 0.015,
                      ),
                      filled: true,
                      fillColor: context.scaffold,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: ScreenSize.width * 0.04,
                        vertical: ScreenSize.height * 0.013,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: context.glassBorder,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: context.glassBorder,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: context.accent,
                          width: 1.5,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: context.cs.error,
                          width: 1,
                        ),
                      ),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Required';
                      final n = int.tryParse(v);
                      if (n == null || n < 2 || n > 5) return '2 – 5 only';
                      return null;
                    },
                  ),
                ),
                SizedBox(width: ScreenSize.width * 0.03),
                GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      onApply(int.parse(controller.text));
                      controller.clear();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenSize.width * 0.05,
                      vertical: ScreenSize.height * 0.016,
                    ),
                    decoration: BoxDecoration(
                      color: context.accent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Apply',
                      style: TextStyle(
                        color: context.cs.onSecondary,
                        fontSize: ScreenSize.height * 0.016,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: ScreenSize.height * 0.012),
          GestureDetector(
            onTap: onSendToServer,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: ScreenSize.height * 0.013,
              ),
              decoration: BoxDecoration(
                color: context.accent.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: context.accent.withOpacity(0.4),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cloud_upload_rounded,
                    color: context.accent,
                    size: ScreenSize.height * 0.02,
                  ),
                  SizedBox(width: ScreenSize.width * 0.02),
                  Text(
                    'Save Bonus to Server',
                    style: TextStyle(
                      color: context.accent,
                      fontSize: ScreenSize.height * 0.016,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
