import 'package:ebn_el_hytham/core/utils/app_bar_builder.dart';
import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/instructor/data/models/instructor_model.dart';
import 'package:ebn_el_hytham/features/instructor/presentation/cubit/instructor_profile_cubit.dart';
import 'package:ebn_el_hytham/features/profile/presentation/widgets/student_profile_strings_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class InstructorProfileScreen extends StatelessWidget {
  const InstructorProfileScreen({super.key});
  static const String routeName = 'InstructorProfileScreen';

  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      backgroundColor: ColorGuid.scaffoldBackgroundColor,
      appBar: buildDarkAppBar('Profile'),
      body: BlocBuilder<InstructorProfileCubit, InstructorProfileState>(
        builder: (context, state) {
          if (state is InstructorProfileLoading ||
              state is InstructorProfileInitial) {
            return const _ProfileShimmer();
          }

          if (state is InstructorProfileError) {
            return _ProfileError(
              message: state.message,
              onRetry: () {
                context.read<InstructorProfileCubit>().getProfileData(
                  token: id,
                );
              },
            );
          }

          if (state is InstructorProfileSuccess) {
            return _ProfileContent(profile: state.profile);
          }

          return const SizedBox();
        },
      ),
    );
  }
}

// ─── Success Content ──────────────────────────────────────────────
class _ProfileContent extends StatelessWidget {
  const _ProfileContent({required this.profile});
  final InstructorModel profile;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.width * 0.05,
        vertical: ScreenSize.height * 0.03,
      ),
      child: Column(
        children: [
          // ── Avatar ──
          Center(
            child: Container(
              width: ScreenSize.width * 0.55,
              height: ScreenSize.height * 0.27,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ScreenSize.height * 0.04),
                border: Border.all(color: ColorGuid.amber, width: 2.5),
                image: const DecorationImage(
                  image: NetworkImage(
                    "https://static.vecteezy.com/system/resources/previews/036/280/651/original/default-avatar-profile-icon-social-media-user-image-gray-avatar-icon-blank-profile-silhouette-illustration-vector.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: ScreenSize.height * 0.02),

          // ── Name ──
          Text(
            profile.name,
            style: TextStyle(
              color: ColorGuid.textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: ScreenSize.height * 0.03,
            ),
          ),
          SizedBox(height: ScreenSize.height * 0.005),

          // ── ID ──
          Text(
            "ID: ${profile.id}",
            style: TextStyle(
              color: ColorGuid.amber,
              fontWeight: FontWeight.w600,
              fontSize: ScreenSize.height * 0.022,
            ),
          ),
          SizedBox(height: ScreenSize.height * 0.004),

          // ── Department ──
          Text(
            profile.department,
            style: TextStyle(
              color: ColorGuid.textSecondary,
              fontWeight: FontWeight.w400,
              fontSize: ScreenSize.height * 0.018,
            ),
          ),
          SizedBox(height: ScreenSize.height * 0.004),

          // ── Email ──
          Text(
            profile.email,
            style: TextStyle(
              color: ColorGuid.textMuted,
              fontWeight: FontWeight.w300,
              fontSize: ScreenSize.height * 0.015,
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: ScreenSize.height * 0.02),
            child: Divider(color: ColorGuid.boardersColor),
          ),

          // ── Info Card ──
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(ScreenSize.width * 0.045),
            decoration: BoxDecoration(
              color: ColorGuid.surfaceColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: ColorGuid.glassBorder, width: 1.2),
            ),
            child: Column(
              children: [
                StudentProfileStringsHelper(
                  firstTxt: 'National ID',
                  secondTxt: profile.nationalId,
                ),
                StudentProfileStringsHelper(
                  firstTxt: 'Member Since',
                  secondTxt: profile.createdAt,
                ),
                StudentProfileStringsHelper(
                  firstTxt: 'Total Courses',
                  secondTxt: profile.totalAssignedCourses,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Shimmer ──────────────────────────────────────────────────────
class _ProfileShimmer extends StatelessWidget {
  const _ProfileShimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF2A3240),
      highlightColor: const Color(0xFF3D4E61),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenSize.width * 0.05,
          vertical: ScreenSize.height * 0.03,
        ),
        child: Column(
          children: [
            // Avatar placeholder
            Center(
              child: Container(
                width: ScreenSize.width * 0.55,
                height: ScreenSize.height * 0.27,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(ScreenSize.height * 0.04),
                ),
              ),
            ),
            SizedBox(height: ScreenSize.height * 0.02),

            // Name placeholder
            _ShimmerBox(width: ScreenSize.width * 0.5, height: 22),
            SizedBox(height: ScreenSize.height * 0.01),

            // ID placeholder
            _ShimmerBox(width: ScreenSize.width * 0.3, height: 16),
            SizedBox(height: ScreenSize.height * 0.008),

            // Department placeholder
            _ShimmerBox(width: ScreenSize.width * 0.55, height: 14),
            SizedBox(height: ScreenSize.height * 0.006),

            // Email placeholder
            _ShimmerBox(width: ScreenSize.width * 0.65, height: 12),

            Padding(
              padding: EdgeInsets.symmetric(vertical: ScreenSize.height * 0.02),
              child: Divider(color: ColorGuid.boardersColor),
            ),

            // Info card placeholder
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(ScreenSize.width * 0.045),
              decoration: BoxDecoration(
                color: ColorGuid.surfaceColor,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: ColorGuid.glassBorder, width: 1.2),
              ),
              child: Column(
                children: List.generate(
                  3,
                  (i) => Padding(
                    padding: EdgeInsets.only(bottom: ScreenSize.height * 0.015),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _ShimmerBox(width: ScreenSize.width * 0.3, height: 13),
                        _ShimmerBox(width: ScreenSize.width * 0.35, height: 13),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Error ───────────────────────────────────────────────────────
class _ProfileError extends StatelessWidget {
  const _ProfileError({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off_rounded, color: ColorGuid.amber, size: 52),
            SizedBox(height: ScreenSize.height * 0.02),
            Text(
              'Failed to load profile',
              style: TextStyle(
                color: ColorGuid.textPrimary,
                fontSize: ScreenSize.height * 0.022,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: ScreenSize.height * 0.008),
            Text(
              message,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorGuid.textMuted,
                fontSize: ScreenSize.height * 0.014,
              ),
            ),
            SizedBox(height: ScreenSize.height * 0.025),
            TextButton.icon(
              onPressed: onRetry,
              icon: Icon(
                Icons.refresh_rounded,
                color: ColorGuid.amber,
                size: 20,
              ),
              label: Text(
                'Try Again',
                style: TextStyle(
                  color: ColorGuid.amber,
                  fontSize: ScreenSize.height * 0.018,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Helper widget ────────────────────────────────────────────────
class _ShimmerBox extends StatelessWidget {
  const _ShimmerBox({required this.width, required this.height});
  final double width, height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
