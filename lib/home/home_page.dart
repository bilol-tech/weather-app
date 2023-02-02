import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:weather_app/home/search_page.dart';
import 'package:weather_app/model/model.dart';

import '../repository/get_info.dart';
import '../widgets/current_hour.dart';
import '../widgets/shimmer_items.dart';

class HomePage extends StatefulWidget {
  final String name1;
  HomePage({super.key, required this.name1});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RefreshController controller = RefreshController();
  Weather weatherdata = Weather();
  bool isLoading = true;

  Future<void> getInfo() async {
    isLoading;
    setState(() {});
    final data = await GetInfoRepository.getinfo(name: widget.name1);
    weatherdata = Weather.fromJson(data);
    isLoading = false;
    setState(() {});
  }

  bool checkHour(int index, Weather? snapshot) {
    return int.tryParse((snapshot
                    ?.forecast?.forecastday?.first.hour?[index].time ??
                "")
            .substring(
                (snapshot?.forecast?.forecastday?.first.hour?[index].time ?? "")
                        .indexOf(":") -
                    2,
                (snapshot?.forecast?.forecastday?.first.hour?[index].time ?? "")
                    .indexOf(":"))) ==
        TimeOfDay.now().hour;
  }

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          color: Color(0xff2E335A),
          buttonBackgroundColor: Color(0xff3C3C43),
          backgroundColor: Color(0xff25936B4),
          items: <Widget>[
            SvgPicture.asset(
              'assets/svg/loc.svg',
              height: 40,
              width: 40,
            ),
            Icon(
              Icons.add,
              size: 40,
              color: Colors.white,
            ),
            Icon(
              Icons.format_list_bulleted,
              size: 40,
              color: Colors.white,
            ),
          ],
          onTap: (index) {
            //Handle button tap
          },
        ),
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: (() {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: ((context) => SearchPAge())));
                }),
                icon: Icon(
                  Icons.search,
                  size: 35,
                ))
          ],
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/night.png'),
                  fit: BoxFit.cover)),
          child: SmartRefresher(
            controller: controller,
            enablePullDown: true,
            onRefresh: () async {
              await getInfo();
              controller.refreshCompleted();
            },
            child: isLoading
                ? const ShimmerItems(
                    height: 20,
                    width: 20,
                  )
                : Column(
                    children: [
                      130.verticalSpace,
                      SizedBox(
                        height: 12,
                      ),
                      Text(weatherdata.location?.name ?? '',
                          style: TextStyle(fontSize: 34, color: Colors.white)),
                      5.verticalSpace,
                      Text('${weatherdata.current?.tempC ?? ''}°',
                          style: TextStyle(fontSize: 96, color: Colors.white)),
                      5.verticalSpace,
                      Text(weatherdata.current?.condition?.text ?? '',
                          style: TextStyle(fontSize: 20, color: Colors.grey)),
                      3.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              "H:${weatherdata.forecast?.forecastday?.first.day?.maxtempC ?? 0}",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                          15.horizontalSpace,
                          Text(
                              "L:${weatherdata.forecast?.forecastday?.last.day?.maxtempC ?? 0}",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                        ],
                      ),
                      Spacer(),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2.5,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topLeft,
                                colors: [
                                  Color(0xff48319D),
                                  Color.fromARGB(255, 97, 3, 61)
                                      .withOpacity(0.75),
                                  Color(0xff2E335A),
                                ]),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(44),
                                topRight: Radius.circular(44))),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: weatherdata.forecast?.forecastday?.first
                                    .hour?.length ??
                                0,
                            itemBuilder: ((context, index) => Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 100, top: 30),
                                  child: ShowCurrentTime(
                                    isActive: checkHour(index, weatherdata),
                                    title: weatherdata.forecast?.forecastday
                                        ?.first.hour?[index].time,
                                    temp: weatherdata.forecast?.forecastday
                                        ?.first.hour?[index].tempC,
                                    image: weatherdata.forecast?.forecastday
                                        ?.first.hour?[index].condition?.icon,
                                  ),
                                ))),
                      )
                    ],
                  ),
          ),
        ));
  }
}

   // Text('${data.current['temp_c']}'),