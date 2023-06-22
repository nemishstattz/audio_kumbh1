import 'dart:convert';

import 'package:audio_kumbh/constants/asset_constant.dart';
import 'package:audio_kumbh/model/home_model.dart';
import 'package:audio_kumbh/services/api_service.dart';
import 'package:audio_kumbh/widget/app_text.dart';
import 'package:audio_kumbh/widget/appbar.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  get http => null;

  List<Banners>? banner;
  List<Category>? category;
  int pageIndex = 0;

  int bottomIndex = 0;

  List Books = [
    AssetConstant.book1,
    AssetConstant.book10,
    AssetConstant.book11,
    AssetConstant.book12
  ];
  List Audiobook = [
    AssetConstant.book2,
    AssetConstant.book3,
    AssetConstant.book4,
    AssetConstant.book5,
    AssetConstant.book6,
    AssetConstant.book7,
    AssetConstant.book8,
    AssetConstant.book9
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  get() async {
    var response = await ResponseService.postRestUrl(
        RestConstant.endpoint, ResponseService.Bodymap);

    if (response != null) {
      Audiomodel model = Audiomodel.fromJson(jsonDecode(response));

      banner = model.data.banner;
      category = model.data.category;
      print(banner);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60), // here the desired height
        child: CommonAppbar(),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          if(banner != null && banner!.isNotEmpty)
           cursorindicator(),
          if(category != null && category!.isNotEmpty)
          appCategories(),
          const SizedBox(
            height: 5,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: const AppText(
                text: 'Recenly Played',
                color: Colors.brown,
                fontSize: 18,
                fontFamily: 'f1',
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 10,
          ),
          recentlyplayed(),
          audiobooks(),
          recentlyBooks(),
        ],
      ),
      bottomNavigationBar: bottombar(),
    );
  }

  cursorindicator() {
    return banner != null && banner!.isNotEmpty?
      Column(
      children: [
        Container(
                height: 160,
                alignment: Alignment.center,
                width: double.infinity,
                child: PageView.builder(
                  itemCount: banner!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin:
                          const EdgeInsetsDirectional.symmetric(horizontal: 8),
                      child: Image.network(banner![index].img),
                    );
                  },
                  onPageChanged: (index) {
                    setState(() {
                      pageIndex = index;
                    });
                  },
                ),
              ),
        DotsIndicator(
          dotsCount: banner!.length,
          position: pageIndex,
          decorator: const DotsDecorator(
              color: Colors.grey, activeColor: Colors.black),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 10),
          child: const AppText(
              text: 'Categories',
              color: Colors.brown,
              fontSize: 18,
              fontFamily: 'f1',
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 5,
        )
      ],
    )
        :CircularProgressIndicator();
  }

  appCategories() {
    return category != null && category!.isNotEmpty
        ? SizedBox(
            height: 100,
            child: ListView.builder(
              itemCount: category!.length,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(category![index].img)),
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                  ),
                  height: 100,
                  width: 120,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                            height: 20,
                            width: 150,
                            child: Positioned(
                              top: 23,
                              left: 5,
                              child: AppText(
                                fontFamily: 'f1',
                                text: category![index].name,
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            )),
                        Container(
                          height: 1,
                          width: 30,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            AppText(
                              text:
                                  "${category![index].total.toString()} Audio Books",
                              fontFamily: 'f1',
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                child: SvgPicture.asset(
                                    AssetConstant.categoriesnext,
                                    alignment: Alignment.bottomRight,
                                    height: 15,
                                    width: 15),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        : const CircularProgressIndicator();
  }

  recentlyplayed() {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: Books.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(left: 16, top: 10, bottom: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 0.2,
                      blurRadius: 2,
                      blurStyle: BlurStyle.outer)
                ]),
            width: 215,
            child: Row(
              children: [
                Expanded(
                  child: Baseline(
                    baselineType: TextBaseline.alphabetic,
                    baseline: 90,
                    child: Container(
                      margin: const EdgeInsets.only(left: 11),
                      height: 160,
                      width: 90,
                      child: Image.asset(
                        Books[index],
                        //fit: BoxFit.fill
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: SizedBox(
                        width: 50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                alignment: Alignment.topRight,
                                margin: const EdgeInsets.only(right: 5, top: 5),
                                child: SvgPicture.asset(
                                  AssetConstant.hearticon,
                                )),
                            Container(
                              child: const AppText(
                                  text: "Your Cover books",
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.brown,
                                  fontFamily: 'f1'),
                            ),
                            Container(
                              child: const AppText(
                                  text: "Ken Adams",
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.brown,
                                  fontFamily: 'f1'),
                            ),
                            Container(
                              child: const AppText(
                                  text: "Chapter:2/6",
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.brown,
                                  fontFamily: 'f1'),
                            ),
                            Container(
                              child: const AppText(
                                  text: "History",
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.brown,
                                  fontFamily: 'f1'),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                          thumbColor: Colors.transparent,
                                          trackHeight: 3,
                                          overlayShape:
                                              const RoundSliderOverlayShape(
                                                  overlayRadius: 0.0),
                                          thumbShape:
                                              const RoundSliderThumbShape(
                                            enabledThumbRadius: 0,
                                          )),
                                      child: Slider(
                                        value: 2,
                                        max: 8,
                                        min: 0,
                                        activeColor: Colors.brown,
                                        onChanged: (value) {},
                                      )),
                                ),
                                const Icon(
                                  Icons.pause_circle,
                                  color: Colors.brown,
                                  size: 20,
                                ),
                              ],
                            ),
                          ],
                        ))),
              ],
            ),
          );
        },
      ),
    );
  }

  audiobooks() {
    return Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        Container(
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.only(left: 10),
          child: const AppText(
              text: 'Audio Books',
              color: Colors.brown,
              fontSize: 18,
              fontFamily: 'f1',
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 7),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Container(
                child: const AppText(
                    text: 'Recently Added',
                    color: Colors.brown,
                    fontSize: 12,
                    fontFamily: 'f1',
                    fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Container(
                child: const AppText(
                    text: 'View All',
                    color: Colors.brown,
                    fontSize: 12,
                    fontFamily: 'f1',
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }

  SizedBox recentlyBooks() => SizedBox(
        height: 22.h,
        width: 20.w,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: Audiobook.length,
          itemBuilder: (context, index) {
            return Container(
              height: 190,
              width: 110,
              child: Image.asset(Audiobook[index],
                  fit: BoxFit.fill, alignment: Alignment.center),
            );
          },
        ),
      );

  bottombar() {
    return Container(
      height: 67,
      color: Colors.white,
      child: Expanded(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(AssetConstant.bookicon))),
                  child: Container(
                    child: const AppText(
                      color: Colors.brown,
                      text: 'Books',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'f1',
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.bottomCenter,
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(AssetConstant.podcasticon))),
                    child: const AppText(
                      color: Colors.brown,
                      text: 'Baudhik',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'f1',
                    )),
                Baseline(
                    baseline: 2,
                    baselineType: TextBaseline.alphabetic,
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(AssetConstant.rupeesicon))),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.currency_rupee,
                            color: Colors.white,
                          ),
                          Text("Donate",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'f1',
                                  fontSize: 10.67)),
                        ],
                      ),
                    )),
                Container(
                    alignment: Alignment.bottomCenter,
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage(AssetConstant.musicicon),
                    )),
                    child: const AppText(
                      color: Colors.brown,
                      text: 'Geet',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'f1',
                    )),
                Container(
                    alignment: Alignment.bottomCenter,
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(AssetConstant.libraryicon))),
                    child: const AppText(
                      color: Colors.brown,
                      text: 'Library',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'f1',
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
