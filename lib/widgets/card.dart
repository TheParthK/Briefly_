import 'package:briefly/models/news_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomCard extends StatelessWidget {
  final NewsModel newsInfo;

  const CustomCard({
    super.key,
    required this.newsInfo

  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () async{
          if(await canLaunchUrl(Uri.parse(newsInfo.srcLink))){
            await launchUrl(
              Uri.parse(newsInfo.srcLink),
              mode: LaunchMode.inAppWebView,
              webOnlyWindowName: newsInfo.source,
              webViewConfiguration: const WebViewConfiguration(enableJavaScript: true, enableDomStorage: true)
              );
          }
        },
        child: Container(
          decoration:  const BoxDecoration(
            color: Color(0xFFf6f5f4),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            // border: Border.all(width: 0.8, color: Colors.black),
            boxShadow: [
              BoxShadow(color: Color.fromARGB(42, 0, 0, 0), blurRadius: 10)
            ]
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                // Expanded(
                //   child: Container(
                //     decoration: BoxDecoration(
                //       image: DecorationImage(image: NetworkImage(newsInfo.imgLink), fit: BoxFit.cover),
                //       borderRadius: const BorderRadius.all(Radius.circular(12)),
                //       border: Border.all(width: 0.8, color: Colors.black)
                //     ),
                //   ),
                // ),
                Container(
                  decoration: BoxDecoration(
                    // border: Border.all(width: 0.8),
                    borderRadius: const BorderRadius.all(Radius.circular(12))
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: Image(
                      image: NetworkImage(newsInfo.imgLink),
                      fit: BoxFit.fitWidth,
                      ),
                  ),
                ),
                const SizedBox(height: 7,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding:const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: const BoxDecoration(
                      color: Color(0xFFffb600),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      // border: Border.all(width: 0.8)
                    ),
                    child: Text(
                      newsInfo.source,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ),
                const SizedBox(height: 2,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 26,
                          color: Colors.black,
                          
                        ),
                        children: [
                          TextSpan(
                            text: newsInfo.title,
                          ),
                        ]
                      )
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      newsInfo.desc,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.roboto(
                        fontSize: 14.5,
                        color: const Color.fromARGB(255, 112, 112, 112)
                      ),
        
                    ),
                  )
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(width: 5,),
                    Flexible(
                      child: Text(
                        '${newsInfo.author} on ${newsInfo.source}',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: Colors.grey
                        )
                      ),
                    ),
                    const SizedBox(width: 2,),
                    const Icon(
                      CupertinoIcons.arrow_up_right,
                      size: 12,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 5,)
                  ],
                ),
                const SizedBox(height: 5,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

