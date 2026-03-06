import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/fees/presentation/pages/instructor_salary_screen.dart';
import 'package:ebn_el_hytham/features/instructor/presentation/widgets/custom_alert_dialog.dart';
import 'package:ebn_el_hytham/features/materials/presentation/pages/instructor_materials_screen.dart';
import 'package:ebn_el_hytham/features/profile/presentation/pages/instructor_profile_screen.dart';
import 'package:ebn_el_hytham/features/results/presentation/pages/instructor_result_screen.dart';
import 'package:ebn_el_hytham/features/students/presentation/widgets/feature_container.dart';
import 'package:ebn_el_hytham/features/timetable/data/models/time_table_model.dart';
import 'package:ebn_el_hytham/features/timetable/presentation/pages/instructor_timetable_screen.dart';
import 'package:flutter/material.dart';

class InstructorHomeView extends StatefulWidget {
  const InstructorHomeView({super.key});
  static const String routeName = 'InstructorHomeView';

  @override
  State<InstructorHomeView> createState() => _InstructorHomeViewState();
}

class _InstructorHomeViewState extends State<InstructorHomeView> {
  // Dark charcoal background color
  static const Color _bgDark = Color(0xFF161B22);
  static const Color _bgCard = Color(0xFF1F2630);
  static const Color _amber = Color(0xFFFFC94A);

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Scaffold(
      backgroundColor: _bgDark,
      body: Column(
        children: [
          // ── Modern Header ──────────────────────────────────────
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: _bgCard,
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
                // Top row: avatar + faculty + notification bell
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Avatar with amber ring
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: _amber, width: 2.2),
                      ),
                      child: CircleAvatar(
                        radius: ScreenSize.height * 0.033,
                        backgroundImage: const NetworkImage(
                          'https://astra.edu.au/wp-content/uploads/2022/02/student-information-uai-1000x562.jpg',
                        ),
                      ),
                    ),
                    // Faculty chip
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _amber.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: _amber.withOpacity(0.35)),
                      ),
                      child: Text(
                        'Faculty of Engineering',
                        style: TextStyle(
                          color: _amber,
                          fontSize: ScreenSize.height * 0.014,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                    // Notification bell
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.notifications_outlined,
                            color: Colors.white70,
                            size: ScreenSize.height * 0.033,
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            width: 9,
                            height: 9,
                            decoration: const BoxDecoration(
                              color: _amber,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: ScreenSize.height * 0.022),
                // Greeting + name
                Text(
                  'Welcome back 👋',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: ScreenSize.height * 0.016,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: ScreenSize.height * 0.005),
                Text(
                  'Mohamed Salah',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenSize.height * 0.026,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
                SizedBox(height: ScreenSize.height * 0.006),
                // ID + email pill row
                Row(
                  children: [
                    _InfoPill(
                      icon: Icons.badge_outlined,
                      label: '21011276',
                      amber: _amber,
                    ),
                    SizedBox(width: ScreenSize.width * 0.03),
                    Expanded(
                      child: _InfoPill(
                        icon: Icons.email_outlined,
                        label: 'mohamedsalah0997@gmail.com',
                        amber: _amber,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ── Section label ────────────────────────────────────
          Padding(
            padding: EdgeInsets.only(
              left: ScreenSize.width * 0.05,
              right: ScreenSize.width * 0.05,
              top: ScreenSize.height * 0.025,
              bottom: ScreenSize.height * 0.008,
            ),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 18,
                  decoration: BoxDecoration(
                    color: _amber,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Quick Access',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: ScreenSize.height * 0.018,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
          ),

          // ── Feature Grid ─────────────────────────────────────
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenSize.width * 0.04,
              ),
              child: GridView(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                children: [
                  FeatureContainer(
                    iconPath: 'assets/Faculties.png',
                    title: 'Profile',
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        InstructorProfileScreen.routeName,
                      );
                    },
                  ),
                  FeatureContainer(
                    iconPath: 'assets/atten.png',
                    title: 'Attendance',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => CustomAlertDialog(),
                      );
                    },
                  ),
                  FeatureContainer(
                    iconPath: 'assets/sylle.png',
                    title: 'Materials',
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        InstructorMaterialsScreen.routeName,
                      );
                    },
                  ),
                  FeatureContainer(
                    iconPath: 'assets/Group.png',
                    title: "Today's Lecture",
                    onTap: () {},
                  ),
                  FeatureContainer(
                    iconPath: 'assets/timetable.png',
                    title: 'Time Table',
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        InstructorTimetableScreen.routeName,
                        arguments: timeTableData,
                      );
                    },
                  ),
                  FeatureContainer(
                    iconPath: 'assets/Salary.png',
                    title: 'Salary',
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        InstructorSalaryScreen.routeName,
                      );
                    },
                  ),
                  FeatureContainer(
                    iconPath: 'assets/Swap.png',
                    title: 'Notifications',
                    onTap: () {},
                  ),
                  FeatureContainer(
                    iconPath: 'assets/results.png',
                    title: 'Results',
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        InstructorResultScreen.routeName,
                      );
                    },
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

// Small pill widget for ID / email info
class _InfoPill extends StatelessWidget {
  const _InfoPill({
    required this.icon,
    required this.label,
    required this.amber,
  });
  final IconData icon;
  final String label;
  final Color amber;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: amber, size: 13),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white38,
              fontSize: ScreenSize.height * 0.013,
            ),
          ),
        ),
      ],
    );
  }
}
