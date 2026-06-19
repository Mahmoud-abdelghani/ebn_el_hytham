import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/instructor/data/models/instructor_model.dart';
import 'package:ebn_el_hytham/features/instructor/presentation/widgets/info_pill.dart';
import 'package:ebn_el_hytham/features/instructor/presentation/widgets/shared_shell.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SuccessHeader extends StatelessWidget {
  const SuccessHeader({
    required this.bgCard,
    required this.amber,
    required this.profile,
  });

  final Color bgCard, amber;
  final InstructorModel profile;

  @override
  Widget build(BuildContext context) {
    return HeaderShell(
      bgCard: bgCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: amber, width: 2.2),
                ),
                child: CircleAvatar(
                  radius: ScreenSize.height * 0.033,
                  backgroundImage: const NetworkImage(
                    'https://astra.edu.au/wp-content/uploads/2022/02/student-information-uai-1000x562.jpg',
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: amber.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: amber.withValues(alpha: 0.35)),
                ),
                child: Text(
                  profile.department,
                  style: TextStyle(
                    color: amber,
                    fontSize: ScreenSize.height * 0.014,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications_outlined,
                        color: context.onSurfaceMuted,
                        size: ScreenSize.height * 0.033),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 9,
                      height: 9,
                      decoration:
                          BoxDecoration(color: amber, shape: BoxShape.circle),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: ScreenSize.height * 0.022),
          Text('Welcome back 👋',
              style: TextStyle(
                  color: context.onSurfaceMuted,
                  fontSize: ScreenSize.height * 0.016)),
          SizedBox(height: ScreenSize.height * 0.005),
          Text(profile.name,
              style: TextStyle(
                  color: context.onBackground,
                  fontSize: ScreenSize.height * 0.026,
                  fontWeight: FontWeight.w700)),
          SizedBox(height: ScreenSize.height * 0.006),
          Row(
            children: [
              InfoPill(icon: Icons.badge_outlined, label: profile.id, amber: amber),
              SizedBox(width: ScreenSize.width * 0.03),
              Expanded(
                child: InfoPill(
                    icon: Icons.email_outlined,
                    label: profile.email,
                    amber: amber),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ShimmerHeader extends StatelessWidget {
  const ShimmerHeader({required this.bgCard, required this.amber});
  final Color bgCard, amber;

  @override
  Widget build(BuildContext context) {
    return HeaderShell(
      bgCard: bgCard,
      child: Shimmer.fromColors(
        baseColor: const Color(0xFF2A3240),
        highlightColor: const Color(0xFF3D4E61),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row shimmer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Avatar placeholder
                const CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                ),
                // Faculty chip placeholder
                Container(
                  width: 140,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                // Bell placeholder
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            SizedBox(height: ScreenSize.height * 0.022),
            // "Welcome back" placeholder
            Container(
              width: 100,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            SizedBox(height: ScreenSize.height * 0.01),
            // Name placeholder
            Container(
              width: 180,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            SizedBox(height: ScreenSize.height * 0.012),
            // Pills row placeholder
            Row(
              children: [
                Container(
                  width: 80,
                  height: 14,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                SizedBox(width: ScreenSize.width * 0.03),
                Container(
                  width: 160,
                  height: 14,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
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

class ErrorHeader extends StatelessWidget {
  const ErrorHeader({
    required this.bgCard,
    required this.amber,
    required this.message,
    required this.onRetry,
  });
  final Color bgCard, amber;
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return HeaderShell(
      bgCard: bgCard,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wifi_off_rounded, color: amber, size: 36),
          const SizedBox(height: 8),
          Text(
            'Failed to load profile',
            style: TextStyle(
                color: context.onSurfaceMuted,
                fontSize: ScreenSize.height * 0.016),
          ),
          const SizedBox(height: 4),
          Text(
            message,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: context.textMuted,
                fontSize: ScreenSize.height * 0.012),
          ),
          const SizedBox(height: 12),
          TextButton.icon(
            onPressed: onRetry,
            icon: Icon(Icons.refresh_rounded, color: amber, size: 18),
            label: Text('Retry', style: TextStyle(color: amber)),
          ),
        ],
      ),
    );
  }
}
