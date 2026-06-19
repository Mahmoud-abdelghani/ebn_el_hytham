import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/students/presentation/cubit/profile_cubit.dart';
import 'package:ebn_el_hytham/features/students/presentation/widgets/home_heading_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeHeading extends StatelessWidget {
  const HomeHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        // ── Loading → shimmer ──────────────────────────────────────
        if (state is ProfileLoading || state is ProfileInitial) {
          return const HomeHeadingShimmer();
        }

        // ── Error → minimal error banner ──────────────────────────
        if (state is ProfileError) {
          return _ErrorBanner(message: state.message);
        }

        // ── Success → full header ──────────────────────────────────
        final profile = (state as ProfileSuccess).profile;
        return _HomeHeadingContent(
          imageUrl: profile.photo,
          name: profile.name,
          id: profile.id,
          email: profile.email,
        );
      },
    );
  }
}

// ── Actual header UI (only rendered on success) ───────────────────────────
class _HomeHeadingContent extends StatelessWidget {
  const _HomeHeadingContent({
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
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: context.shadowColor,
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
          // ── Top row: avatar + faculty chip + bell ──────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: context.accent, width: 2.2),
                ),
                child: CircleAvatar(
                  radius: ScreenSize.height * 0.033,
                  backgroundImage: NetworkImage(imageUrl),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: context.accentSubtle,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: context.accentBorder),
                ),
                child: Text(
                  'Faculty of Engineering',
                  style: TextStyle(
                    color: context.accent,
                    fontSize: ScreenSize.height * 0.014,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications_outlined,
                      color: context.onSurfaceMuted,
                      size: ScreenSize.height * 0.033,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                        color: context.accent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: ScreenSize.height * 0.022),

          Text(
            'Welcome back 👋',
            style: TextStyle(
              color: context.onSurfaceMuted,
              fontSize: ScreenSize.height * 0.016,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: ScreenSize.height * 0.005),
          Text(
            name,
            style: TextStyle(
              color: context.onBackground,
              fontSize: ScreenSize.height * 0.026,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
          SizedBox(height: ScreenSize.height * 0.006),
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

// ── Error banner ──────────────────────────────────────────────────────────
class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + ScreenSize.height * 0.02,
        left: ScreenSize.width * 0.05,
        right: ScreenSize.width * 0.05,
        bottom: ScreenSize.height * 0.03,
      ),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: context.cs.error, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: context.cs.error,
                fontSize: ScreenSize.height * 0.015,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Info pill ─────────────────────────────────────────────────────────────
class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: context.accent, size: 13),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: context.textMuted,
              fontSize: ScreenSize.height * 0.013,
            ),
          ),
        ),
      ],
    );
  }
}
