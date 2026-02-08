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
      backgroundColor: ColorGuid.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: ColorGuid.mainColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        shadowColor: ColorGuid.mainColor,
        elevation: 8,
        title: Text(
          'Timetable',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: ScreenSize.height * 0.025,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList.separated(
            itemCount: data.length,
            itemBuilder: (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ' ${data[index].day}',
                  style: TextStyle(
                    fontSize: ScreenSize.height * 0.025,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                              Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: ScreenSize.height * 0.01,
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: ScreenSize.height * 0.058,
                                  horizontal: ScreenSize.width * 0.05,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: ColorGuid.boardersColor,
                                  ),
                                ),
                                width: ScreenSize.width * 0.45,
                                child: Text(
                                  data[index].lectures[index1].title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    color: ColorGuid.mainColor,
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
                        height: ScreenSize.height * 0.15,
                        width: ScreenSize.width,
                        child: Center(
                          child: Text(
                            'No Lectures',
                            style: TextStyle(
                              color: ColorGuid.mainColor,
                              fontWeight: FontWeight.w400,
                              fontSize: ScreenSize.height * 0.022,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
            separatorBuilder: (context, index) =>
                SizedBox(height: ScreenSize.height * 0.01),
          ),
        ],
      ),
    );
  }
}
