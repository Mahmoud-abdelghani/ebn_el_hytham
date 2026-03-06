import 'package:ebn_el_hytham/core/utils/app_bar_builder.dart';
import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/materials/presentation/widgets/custom_small_data_container.dart';
import 'package:ebn_el_hytham/features/timetable/data/models/time_table_model.dart';
import 'package:flutter/material.dart';

class InstructorTimetableScreen extends StatelessWidget {
  const InstructorTimetableScreen({super.key});
  static const String routeName = 'InstructorTimetableScreen';

  @override
  Widget build(BuildContext context) {
    List<TimeTableModel> data =
        ModalRoute.of(context)!.settings.arguments as List<TimeTableModel>;
    return Scaffold(
      // [scaffoldBackgroundColor] dark charcoal
      backgroundColor: ColorGuid.scaffoldBackgroundColor,
      appBar: buildDarkAppBar('Timetable'),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: ScreenSize.height * 0.015)),
          SliverList.separated(
            itemCount: data.length,
            itemBuilder: (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Day header with [amber] accent bar ─────────────
                Padding(
                  padding: EdgeInsets.only(
                    left: ScreenSize.width * 0.04,
                    bottom: ScreenSize.height * 0.008,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 16,
                        decoration: BoxDecoration(
                          color: ColorGuid.amber, // [amber] day label bar
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        data[index].day,
                        style: TextStyle(
                          fontSize: ScreenSize.height * 0.022,
                          fontWeight: FontWeight.bold,
                          color: ColorGuid.textPrimary, // [textPrimary] white
                        ),
                      ),
                    ],
                  ),
                ),
                // ── Lecture rows ────────────────────────────────────
                data[index].lectures.isNotEmpty
                    ? Column(
                        children: List.generate(
                          data[index].lectures.length,
                          (index1) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  CustomSmallDataContainer(
                                    data: data[index].lectures[index1].fatra,
                                    textDirection: TextDirection.ltr,
                                    virticalMargin: ScreenSize.height * 0.001,
                                  ),
                                  CustomSmallDataContainer(
                                    data: data[index].lectures[index1].time,
                                    textDirection: TextDirection.ltr,
                                    virticalMargin: ScreenSize.height * 0.001,
                                  ),
                                  CustomSmallDataContainer(
                                    data: data[index].lectures[index1].location,
                                    textDirection: TextDirection.ltr,
                                    virticalMargin: ScreenSize.height * 0.001,
                                  ),
                                ],
                              ),
                              // Lecture title on the right
                              Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: ScreenSize.height * 0.01,
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: ScreenSize.height * 0.058,
                                  horizontal: ScreenSize.width * 0.05,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  // [surfaceColor] replaces old white
                                  color: ColorGuid.surfaceColor,
                                  border: Border.all(
                                    color: ColorGuid.boardersColor, // [boardersColor]
                                  ),
                                ),
                                width: ScreenSize.width * 0.45,
                                child: Text(
                                  data[index].lectures[index1].title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    color: ColorGuid.textPrimary, // [textPrimary]
                                    fontWeight: FontWeight.w400,
                                    fontSize: ScreenSize.height * 0.02,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox(
                        height: ScreenSize.height * 0.12,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            'No Lectures',
                            style: TextStyle(
                              color: ColorGuid.textMuted, // [textMuted]
                              fontWeight: FontWeight.w400,
                              fontSize: ScreenSize.height * 0.02,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
            separatorBuilder: (context, index) =>
                Divider(color: ColorGuid.boardersColor, height: ScreenSize.height * 0.03),
          ),
          SliverToBoxAdapter(child: SizedBox(height: ScreenSize.height * 0.02)),
        ],
      ),
    );
  }
}
