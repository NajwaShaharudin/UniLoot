import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:uni_loot/controllers/charts_controller/chart_order_controller.dart';
import 'package:uni_loot/models/charts/chart_order_model.dart';
import 'package:uni_loot/utils/app_constant.dart';
import '../../widgets/admin_drawer_widget.dart';
import '../auth_ui/welcome_screen.dart';


class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  @override
  Widget build(BuildContext context) {
    final GetAllOrdersChart getAllOrdersChart = Get.put(GetAllOrdersChart());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        centerTitle: true,
        title: const Text("UniLoot Admin"),
        actions: [
          GestureDetector(
            onTap: () async {

              GoogleSignIn googleSignIn = GoogleSignIn();
              FirebaseAuth _auth = FirebaseAuth.instance;
              await _auth.signOut();
              await googleSignIn.signOut();
              Get.offAll(() => WelcomeScreen());
            },
            child: const Icon(Icons.logout),
          )
        ],
      ),

       drawer: const AdminDrawerWidget(),

      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       Positioned(
      //           height: 100,
      //         width: 100,
      //           child: Image.asset('assets/images/shop-logo.jpg'),
      //       ),
      //       SizedBox(
      //         height: Get.height / 90.0,
      //       ),
      //
      //       // const AdminMainWidget()
      //     ],
      //   ),
      // ),

      body: Container(child: Column(
          children: [
            Obx(() {
              final monthlyData = getAllOrdersChart.monthlyOrderData;
              if (monthlyData.isEmpty) {
                return Container(
                  height: Get.height/2,
                  child: const Center(
                    child: CupertinoActivityIndicator(),
                  ),
                );
              }else {
                return SizedBox(
                  height: Get.height / 2,
                  child: SfCartesianChart(
                    tooltipBehavior: TooltipBehavior(enable: true),
                    primaryXAxis: CategoryAxis(arrangeByIndex: true),
                    series: <LineSeries<ChartData, String>>[
                      LineSeries<ChartData, String>(
                          dataSource: monthlyData,
                          width: 2.5,
                          color: AppConstant.appMainColor,
                          xValueMapper: (ChartData data, _) => data.month,
                          yValueMapper: (ChartData data, _) => data.value,
                        name: "Monthly Orders",
                        markerSettings: MarkerSettings(isVisible: true),
                      )
                    ],
                  ),
                );
              }
            })
          ],
        ),
      ),
    );
  }
}