import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

/// Dark-themed profile header shared by Student and Instructor home screens.
/// Uses [surfaceColor] card with amber ring avatar and amber faculty pill.
class HomeHeading extends StatelessWidget {
  const HomeHeading({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.id,
    required this.email,
  });
  final String imageUrl;
  final String name;
  final String id;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // [surfaceColor] replaces the old PNG background asset
      decoration: BoxDecoration(
        color: ColorGuid.surfaceColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + ScreenSize.height * 0.02,
        left: ScreenSize.width * 0.05,
        right: ScreenSize.width * 0.05,
        bottom: ScreenSize.height * 0.03,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Top row: avatar + faculty chip + bell ──────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Avatar with [amber] ring border
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorGuid.amber, width: 2.2),
                ),
                child: CircleAvatar(
                  radius: ScreenSize.height * 0.033,
                  backgroundImage: NetworkImage(imageUrl),
                ),
              ),
              // Faculty [amber] pill badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: ColorGuid.amberSubtle, // [amberSubtle] tinted fill
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: ColorGuid.amberBorder, // [amberBorder]
                  ),
                ),
                child: Text(
                  'Faculty of Engineering',
                  style: TextStyle(
                    color: ColorGuid.amber, // [amber] text on pill
                    fontSize: ScreenSize.height * 0.014,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              // Notification bell with amber dot indicator
              Stack(
                alignment: Alignment.topRight,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications_outlined,
                      color: ColorGuid.textSecondary, // [textSecondary]
                      size: ScreenSize.height * 0.033,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 9,
                      height: 9,
                      // [amber] notification dot
                      decoration: BoxDecoration(
                        color: ColorGuid.amber,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: ScreenSize.height * 0.022),
          // ── Greeting ───────────────────────────────────────
          Text(
            'Welcome back 👋',
            style: TextStyle(
              color: ColorGuid.textSecondary, // [textSecondary] subtle greeting
              fontSize: ScreenSize.height * 0.016,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: ScreenSize.height * 0.005),
          // Name in [textPrimary] white bold
          Text(
            name,
            style: TextStyle(
              color: ColorGuid.textPrimary,
              fontSize: ScreenSize.height * 0.026,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
          SizedBox(height: ScreenSize.height * 0.006),
          // ID + Email as info pills
          Row(
            children: [
              _InfoPill(icon: Icons.badge_outlined, label: id),
              SizedBox(width: ScreenSize.width * 0.03),
              Expanded(
                child: _InfoPill(icon: Icons.email_outlined, label: email),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Small amber-icon + muted-text pill used for metadata fields
class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: ColorGuid.amber, size: 13), // [amber] icon
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: ColorGuid.textMuted, // [textMuted]
              fontSize: ScreenSize.height * 0.013,
            ),
          ),
        ),
      ],
    );
  }
}
