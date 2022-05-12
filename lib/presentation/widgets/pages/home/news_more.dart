import 'package:flutter/material.dart';
import 'package:moreinfo/cubit/news/news_cubit.dart';
import 'package:moreinfo/presentation/common/app_container.dart';
import 'package:moreinfo/presentation/config/constants.dart';
import 'package:moreinfo/presentation/helpers/helper_functions.dart';
import 'package:moreinfo/presentation/widgets/molecules/user_menu.dart';
import 'package:provider/src/provider.dart';

const title = 'It is a long established fact that a reader will be distracted';
const description =
    'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less The point of using Lorem Ipsum is that it has a more-or-less It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less The point of using Lorem Ipsum is that it has a more-or-less';

class NewsMorePage extends StatefulWidget {
  const NewsMorePage({Key? key}) : super(key: key);

  @override
  State<NewsMorePage> createState() => _NewsMorePageState();
}

class _NewsMorePageState extends State<NewsMorePage> {
  Map<String, dynamic> news = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    news = context.read<NewsCubit>().state;
  }

  bool checkImage(String? url) {
    if (url != null) {
      String imagName = url.substring(url.lastIndexOf('/') + 1);
      return imagName.contains('.');
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    print(news['image']);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        actions: [UserMenu()],
      ),
      body: SingleChildScrollView(
        child: AppContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height * 0.82),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news['title'].toString(),
                      style: const TextStyle(
                        color: primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // Container(
                    //   height: 233,
                    //   margin: const EdgeInsets.symmetric(vertical: 20),
                    //   decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //       onError: (exception, stackTrace) =>
                    //           {print(exception)},
                    //       image: NetworkImage(news['image']),
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                    //   child: null,
                    // ),
                    checkImage(news['image'])
                        ? Image.network(
                            news['image'],
                            errorBuilder: (context, error, stackTrace) {
                              return Text('sd');
                              // print('object');
                            },
                          )
                        : Container(),
                    Text(
                      news['description'].toString(),
                      style: const TextStyle(
                        color: primaryColor,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(formatUTCDate(news['created_at'].toString())),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    ));
  }
}
