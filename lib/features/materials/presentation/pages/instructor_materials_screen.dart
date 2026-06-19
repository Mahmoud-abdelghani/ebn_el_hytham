import 'package:ebn_el_hytham/core/utils/app_bar_builder.dart';
import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/materials/data/models/instructor_material_model.dart';
import 'package:ebn_el_hytham/features/materials/presentation/cubit/instructor_materials_cubit.dart';
import 'package:ebn_el_hytham/features/materials/presentation/pages/instructor_material_details_screen.dart';
import 'package:ebn_el_hytham/features/materials/presentation/widgets/materials_shimmer_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InstructorMaterialsScreen extends StatelessWidget {
  const InstructorMaterialsScreen({super.key});
  static const String routeName = 'InstructorMaterialsScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffold,
      appBar: buildDarkAppBar(context, 'My Courses'),
      body: BlocBuilder<InstructorMaterialsCubit, InstructorMaterialsState>(
        builder: (context, state) {
          if (state is InstructorMaterialsLoading) {
            return const MaterialsShimmerLoading();
          } else if (state is InstructorMaterialsFailure) {
            return _ErrorState(message: state.message);
          } else if (state is InstructorMaterialsSuccess) {
            return _MaterialsList(materials: state.materials);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  const _ErrorState({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(ScreenSize.width * 0.08),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.wifi_off_rounded,
              color: context.accent,
              size: ScreenSize.height * 0.07,
            ),
            SizedBox(height: ScreenSize.height * 0.02),
            Text(
              'Failed to load courses',
              style: TextStyle(
                color: context.onBackground,
                fontSize: ScreenSize.height * 0.022,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: ScreenSize.height * 0.008),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.onSurfaceMuted,
                fontSize: ScreenSize.height * 0.016,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MaterialsList extends StatelessWidget {
  final List<InstructorMaterialModel> materials;
  const _MaterialsList({required this.materials});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.width * 0.05,
        vertical: ScreenSize.height * 0.025,
      ),
      itemCount: materials.length,
      separatorBuilder: (_, __) => SizedBox(height: ScreenSize.height * 0.016),
      itemBuilder: (context, index) =>
          _CourseCard(material: materials[index], index: index),
    );
  }
}

class _CourseCard extends StatelessWidget {
  final InstructorMaterialModel material;
  final int index;
  const _CourseCard({required this.material, required this.index});

  static const List<Color> _accents = [
    Color(0xFFFFC107),
    Color(0xFF64B5F6),
    Color(0xFF81C784),
    Color(0xFFBA68C8),
    Color(0xFFFF8A65),
  ];

  @override
  Widget build(BuildContext context) {
    final accent = _accents[index % _accents.length];
    final studentCount = material.assignedMaterials.length;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        InstructorMaterialDetailsScreen.routeName,
        arguments: index,
      ),
      child: Container(
        padding: EdgeInsets.all(ScreenSize.width * 0.048),
        decoration: BoxDecoration(
          color: context.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: context.glassBorder, width: 1.2),
        ),
        child: Row(
          children: [
            Container(
              width: ScreenSize.width * 0.012,
              height: ScreenSize.height * 0.08,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            SizedBox(width: ScreenSize.width * 0.04),
            Container(
              width: ScreenSize.height * 0.062,
              height: ScreenSize.height * 0.062,
              decoration: BoxDecoration(
                color: accent.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                Icons.menu_book_rounded,
                color: accent,
                size: ScreenSize.height * 0.032,
              ),
            ),
            SizedBox(width: ScreenSize.width * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    material.name,
                    style: TextStyle(
                      color: context.onBackground,
                      fontSize: ScreenSize.height * 0.02,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                    ),
                  ),
                  SizedBox(height: ScreenSize.height * 0.006),
                  Text(
                    material.code,
                    style: TextStyle(
                      color: accent,
                      fontSize: ScreenSize.height * 0.016,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: ScreenSize.height * 0.008),
                  Row(
                    children: [
                      _MiniChip(
                        icon: Icons.calendar_today_rounded,
                        label: material.day,
                        color: context.textMuted,
                      ),
                      SizedBox(width: ScreenSize.width * 0.03),
                      _MiniChip(
                        icon: Icons.access_time_rounded,
                        label: material.time,
                        color: context.textMuted,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  '$studentCount',
                  style: TextStyle(
                    color: accent,
                    fontSize: ScreenSize.height * 0.026,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'Students',
                  style: TextStyle(
                    color: context.textMuted,
                    fontSize: ScreenSize.height * 0.013,
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

class _MiniChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _MiniChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: ScreenSize.height * 0.014, color: color),
        SizedBox(width: ScreenSize.width * 0.01),
        Text(
          label,
          style: TextStyle(color: color, fontSize: ScreenSize.height * 0.014),
        ),
      ],
    );
  }
}
