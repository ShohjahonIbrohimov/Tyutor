import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moreinfo/bloc/news/news_bloc.dart';
import 'package:moreinfo/cubit/news/news_cubit.dart';
import 'package:moreinfo/l10n/app_localization.dart';
import 'package:moreinfo/presentation/config/constants.dart';
import 'package:moreinfo/presentation/helpers/helper_functions.dart';
import 'package:provider/src/provider.dart';

class NewsCard extends StatefulWidget {
  Map<String, dynamic> news;

  NewsCard({
    Key? key,
    required this.news,
  }) : super(key: key);

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  String description = '';
  String title = '';

  @override
  void initState() {
    super.initState();
    description = appendDot(widget.news['description'].toString(), 80);
    title = appendDot(widget.news['title'].toString(), 50);
  }

  String appendDot(String text, int num) {
    String dotTxt = text;
    if (text.length > num) {
      dotTxt = text.substring(0, num);
      dotTxt = '$dotTxt...';
    }
    return dotTxt;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 2.0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: primaryColor,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 10),
              Container(
                child: Text(
                  description,
                  style: const TextStyle(
                    color: textColor,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(formatUTCDate(widget.news['created_at'].toString())),
              ElevatedButton(
                onPressed: () {
                  context.read<NewsCubit>().setNews(widget.news);
                  Navigator.pushNamed(context, '/news_more');
                },
                child:
                    Text(AppLocalization.of(context)!.translate('read_more')),
                style: ElevatedButton.styleFrom(primary: primaryColor),
              )
            ],
          )
        ],
      ),
    );
  }
}
