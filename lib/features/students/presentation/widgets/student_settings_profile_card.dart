import 'package:flutter/material.dart';
import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';

class StudentSettingsProfileCard extends StatelessWidget {
  final String name;
  final String email;
  final String level;
  final String photoUrl;
  final VoidCallback onTap;

  const StudentSettingsProfileCard({
    super.key,
    required this.name,
    required this.email,
    required this.level,
    required this.photoUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(ScreenSize.width * 0.045),
        decoration: BoxDecoration(
          color: ColorGuid.surfaceColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: ColorGuid.amber.withOpacity(0.25),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: ColorGuid.amber.withOpacity(0.07),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: ColorGuid.amber, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: ColorGuid.amber.withOpacity(0.22),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: ScreenSize.height * 0.034,
                backgroundColor: ColorGuid.scaffoldBackgroundColor,
                backgroundImage:
                    photoUrl.isNotEmpty ? NetworkImage(photoUrl) : null,
                child: photoUrl.isEmpty
                    ? Icon(
                        Icons.person,
                        color: ColorGuid.amber,
                        size: ScreenSize.height * 0.032,
                      )
                    : null,
              ),
            ),
            SizedBox(width: ScreenSize.width * 0.04),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: ColorGuid.textPrimary,
                      fontSize: ScreenSize.height * 0.019,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: ScreenSize.height * 0.004),
                  Text(
                    email,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: ColorGuid.textMuted,
                      fontSize: ScreenSize.height * 0.013,
                    ),
                  ),
                  SizedBox(height: ScreenSize.height * 0.006),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: ColorGuid.amber.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: ColorGuid.amber.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      level,
                      style: TextStyle(
                        color: ColorGuid.amber,
                        fontSize: ScreenSize.height * 0.012,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.chevron_right_rounded,
              color: ColorGuid.amber.withOpacity(0.6),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
