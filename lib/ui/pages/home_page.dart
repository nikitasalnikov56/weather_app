import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/models/weather_data.dart';
import 'package:weather_app/domain/provider/weather_provider.dart';
import 'package:weather_app/ui/components/current_temp.dart';
import 'package:weather_app/ui/components/custom_appbar.dart';
import 'package:weather_app/ui/components/row_items.dart';
import 'package:weather_app/ui/components/week_day_items.dart';
import 'package:weather_app/ui/style/app_style.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<WeatherData?>(
        future: context.watch<WeatherProvider>().setUp(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return const WeatherAppBody();
            case ConnectionState.waiting:
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class WeatherAppBody extends StatelessWidget {
  const WeatherAppBody({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              model.setBg(),
            )),
      ),
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Column(
        children: [
          const CustomAppBar(),
          const SizedBox(height: 60),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    '${model.currentDay}',
                    style: AppStyle.fontStyle.copyWith(
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${model.currentDayTime} ${model.currentTime}',
                    style: AppStyle.fontStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.network(
                    model.iconData(),
                    scale: 0.5,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    model.getCurrentStatus(),
                    textAlign: TextAlign.center,
                    style: AppStyle.fontStyle.copyWith(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const CurrentTemp(),
                  const SizedBox(height: 60),
                  const RowItems(),
                  const SizedBox(height: 28),
                  const WeekDayItems(),
                  const SizedBox(height: 28),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
