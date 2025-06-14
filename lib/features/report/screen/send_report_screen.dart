import 'package:afriqueen/features/report/widgets/send_report_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SendReportScreen extends StatelessWidget {
  const SendReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back)),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 15.w, vertical: 10.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 30.h,
            children: [
              //----------Title text-----------
              const SendReportTitle(),
              //------------Reporter Name---------------
              const ReporterName(),
              //---------------Reporter Email--------------------
              const ReporterEmail(),
              SizedBox(
                height: 20.h,
              ),
              //-----------Confirm information--------------------
              const ConfirmInformation(),
              //---------------- Send Button-----------
              const SendReportButton()
            ],
          ),
        ),
      )),
    );
  }
}
