import 'dart:ui';

import 'package:briefly/models/news_model.dart';
import 'package:briefly/services/api_service.dart';
import 'package:briefly/widgets/card.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // static const imgLink = 'https://scontent-bom1-2.cdninstagram.com/v/t51.2885-15/329317951_1043593799935199_2295232219652093670_n.jpg?stp=dst-jpg_e35_p720x720&_nc_ht=scontent-bom1-2.cdninstagram.com&_nc_cat=111&_nc_ohc=URKGXuy_do0AX92xErD&edm=ABmJApABAAAA&ccb=7-5&ig_cache_key=MzAzNzM3OTM0ODY3OTU4NjQwOQ%3D%3D.2-ccb7-5&oh=00_AfBxnQ-EAVf3oRO7jGfxeYVedrUQS1Lwsi967dtg2DsvAg&oe=6440165B&_nc_sid=6136e7';
  String searchTerm = 'technology';
  APIservice client = APIservice();
  TextEditingController searchBarController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void searchTopic(){
    setState(() {
      searchTerm = searchBarController.text;
    });
    searchBarController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
      )
    );
    Size size = MediaQuery.of(context).size;
    EdgeInsets devicePadding = MediaQuery.of(context).padding;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false ,
          // backgroundColor: const Color.fromARGB(255, 250, 250, 250),
          backgroundColor: const Color(0xFFe3e3e3),
          body: Container(
            decoration: const BoxDecoration(
            ),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: devicePadding.top + 12
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 17),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFf6f5f4),
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  // border: Border.all(width: 0.8)
                                  boxShadow: [
                                    BoxShadow(color: Color.fromARGB(42, 0, 0, 0), blurRadius: 10)
                                  ]

                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                  const Text(
                                  'ly.',
                                  style: TextStyle(
                                    fontFamily: 'BostonAngel',
                                    fontSize: 20,
                                    color: Color(0xFF03103a)
                                    ),
                                  ),
                                  const SizedBox(width: 5,),
                                  Expanded(
                                    child: TextField(
                                      controller: searchBarController,
                                      cursorColor: const Color.fromARGB(255, 16, 16, 16),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Search for topics',
                                        hintStyle: GoogleFonts.roboto(
                                          fontSize: 14
                                        )
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5,),
                                  GestureDetector(
                                    onTap: searchTopic,
                                    child: const Icon(
                                      CupertinoIcons.arrow_right_circle,
                                      color: Color(0xFF03103a),
                                      )
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: FutureBuilder(
                          future: client.getArticle(searchTerm),
                          builder: (BuildContext context, AsyncSnapshot<List<NewsModel>> snapshot){
                            if(snapshot.hasData){
                              List<NewsModel>? news = snapshot.data;
                              return Swiper.children(
                                layout: SwiperLayout.STACK,
                                loop: false,
                                itemWidth: size.width - 10,
                                axisDirection: AxisDirection.left,
                                scrollDirection: Axis.horizontal,
                                curve: Curves.fastLinearToSlowEaseIn,
                                children: [
                                  ...?news?.map((e) => CustomCard(newsInfo: e))
                                ],
                              );
                            }
                            return const Center(child: CupertinoActivityIndicator(animating: true,),);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children:  [
                              const Icon(CupertinoIcons.music_note_2, size: 12,),
                              const SizedBox(width: 3,),
                              const Text('BBC Radio London', style: TextStyle(fontSize: 12),),
                              const SizedBox(width: 1,),
                              LottieBuilder.asset(
                                'assets/SoundBar.json',
                                )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: devicePadding.bottom>0?devicePadding.bottom:5,)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}