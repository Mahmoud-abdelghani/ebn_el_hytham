import 'dart:math';

import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/authentication/presentation/widgets/custom_button.dart';
import 'package:ebn_el_hytham/features/authentication/presentation/widgets/custom_fields.dart';
import 'package:ebn_el_hytham/features/materials/presentation/widgets/custom_data_in_a_row.dart';
import 'package:ebn_el_hytham/features/materials/presentation/widgets/custom_details_tile.dart';
import 'package:ebn_el_hytham/features/military/presentation/widgets/custom_data_container.dart';
import 'package:ebn_el_hytham/features/results/data/models/instructor_material_result.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class InstructorDetailsResultScreen extends StatefulWidget {
  const InstructorDetailsResultScreen({super.key});
  static const String routeName = 'instructor-details-result-screen';

  @override
  State<InstructorDetailsResultScreen> createState() =>
      _InstructorDetailsResultScreenState();
}

class _InstructorDetailsResultScreenState
    extends State<InstructorDetailsResultScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int index = ModalRoute.of(context)!.settings.arguments as int;
    final grades = listOfResults[index].listStudentMark
        .map((e) => e.mark)
        .toList();

    final mu = mean(grades);
    final sigma = stdDeviation(grades, mu);

    return Scaffold(
      backgroundColor: ColorGuid.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: ColorGuid.mainColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        shadowColor: ColorGuid.mainColor,
        elevation: 8,
        title: Text(
          listOfResults[index].materialName,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: ScreenSize.height * 0.025,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: CustomDataInARow(
              txtLeft: listOfResults[index].department,
              txtRight: listOfResults[index].season,
            ),
          ),
          SliverToBoxAdapter(
            child: CustomDataInARow(
              txtLeft: listOfResults[index].examDate,
              txtRight: 'Totla students ${listOfResults[index].totalStrudent}',
            ),
          ),
          SliverToBoxAdapter(
            child: CustomDataContainer(
              data:
                  'number of success : ${listOfResults[index].totalNumberSuccess}',
              textDirection: TextDirection.ltr,
            ),
          ),
          SliverToBoxAdapter(
            child: CustomDataContainer(
              data: 'number of fails : ${listOfResults[index].totalNumberFail}',
              textDirection: TextDirection.ltr,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenSize.height * 0.02,
                vertical: ScreenSize.height * 0.02,
              ),
              child: CustomFields(
                fieldKey: formKey,
                fieldValidator: (value) {
                  if (value!.isEmpty) {
                    return 'fill that field to add a bonus';
                  } else if (int.parse(value) > 5 || int.parse(value) < 2) {
                    return 'bonus should be between 5 ~ 2';
                  } else {
                    return null;
                  }
                },
                textEditingController: textEditingController,
                label: 'Bonus',
                hint: 'Add bonus',
                iconData: Icons.add,
                textInputType: TextInputType.number,
                isPassword: false,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenSize.height * 0.02,
                vertical: ScreenSize.height * 0.00,
              ),
              child: CustomButton(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    listOfResults[index].addBonus(
                      int.parse(textEditingController.text),
                    );
                    textEditingController.clear();
                  }
                  setState(() {});
                },
                txt: 'Apply Bonus',
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                left: ScreenSize.width * 0.1,
                bottom: ScreenSize.height * 0.02,
              ),
              child: Text(
                'Gaussian Distribution',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: ScreenSize.height * 0.025,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenSize.height * 0.03,
              ),
              child: SizedBox(
                height: ScreenSize.height * 0.4,
                child: LineChart(
                  LineChartData(
                    backgroundColor: Colors.white,
                    minX: 0,
                    maxX: 100,
                    minY: 0,
                    maxY: gaussian(mu, mu, sigma) * 1.2,
                    titlesData: FlTitlesData(
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 10,
                          getTitlesWidget: (value, meta) {
                            return Text(value.toInt().toString());
                          },
                        ),
                      ),

                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: gaussian(mu, mu, sigma) / 5,
                          getTitlesWidget: (value, meta) {
                            return Text(value.toStringAsFixed(2));
                          },
                        ),
                      ),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        color: ColorGuid.mainColor,
                        spots: gaussianSpots(mu, sigma),
                        isCurved: true,
                        dotData: FlDotData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverList.separated(
            itemCount: listOfResults[index].listStudentMark.length,
            itemBuilder: (context, index2) => CustomDetailsTile(
              name: listOfResults[index].listStudentMark[index2].studentName,
              id: listOfResults[index].listStudentMark[index2].studentId,
              onTap: () {},
              mark: listOfResults[index].listStudentMark[index2].mark
                  .toString(),
            ),
            separatorBuilder: (context, index) =>
                SizedBox(height: ScreenSize.height * 0.01),
          ),
        ],
      ),
    );
  }

  double mean(List<double> grades) {
    return grades.reduce((a, b) => a + b) / grades.length;
  }

  double stdDeviation(List<double> grades, double mean) {
    final variance =
        grades.map((g) => (g - mean) * (g - mean)).reduce((a, b) => a + b) /
        grades.length;

    return sqrt(variance);
  }

  double gaussian(double x, double mean, double std) {
    return (1 / (std * sqrt(2 * pi))) *
        exp(-pow(x - mean, 2) / (2 * pow(std, 2)));
  }

  List<FlSpot> gaussianSpots(double mean, double std) {
    final spots = <FlSpot>[];

    for (double x = 0; x <= 100; x += 1) {
      spots.add(FlSpot(x, gaussian(x, mean, std)));
    }
    return spots;
  }
}
