import 'package:ebn_el_hytham/core/utils/app_bar_builder.dart';
import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/materials/data/models/material_model.dart';
import 'package:ebn_el_hytham/features/materials/presentation/cubit/assigned_materials_cubit.dart';
import 'package:ebn_el_hytham/features/materials/presentation/pages/student_material_details_view.dart';
import 'package:ebn_el_hytham/features/materials/presentation/widgets/custom_material_container.dart';
import 'package:ebn_el_hytham/features/materials/presentation/widgets/materials_shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentMaterialsListView extends StatelessWidget {
  const StudentMaterialsListView({super.key});
  static const String routeName = 'StudentMaterialsListView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // [scaffoldBackgroundColor] dark charcoal
      backgroundColor: ColorGuid.scaffoldBackgroundColor,
      appBar: buildDarkAppBar('Materials'),
      body: BlocBuilder<AssignedMaterialsCubit, AssignedMaterialsState>(
        builder: (context, state) {
          if (state is AssignedMaterialsLoading) {
            return const MaterialsShimmerLoading();
          } else if (state is AssignedMaterialsFailure) {
            return Center(child: Text(state.message));
          } else if (state is! AssignedMaterialsSuccess) {
            return const MaterialsShimmerLoading();
          }
          return ListView.separated(
            padding: EdgeInsets.symmetric(vertical: ScreenSize.height * 0.012),
            itemBuilder: (context, index) => CustomMaterialContainer(
              txt1: state.materials[index].name,
              ontap: () {
                Navigator.pushNamed(
                  context,
                  StudentMaterialDetailsView.routeName,
                  arguments: state.materials[index],
                );
              },
            ),
            separatorBuilder: (context, index) =>
                SizedBox(height: ScreenSize.height * 0.006),
            itemCount: state.materials.length,
          );
        },
      ),
    );
  }
}
