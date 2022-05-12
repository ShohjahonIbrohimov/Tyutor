import 'package:flutter/material.dart';
import 'package:moreinfo/bloc/news/news_bloc.dart';
import 'package:moreinfo/presentation/config/constants.dart';
import 'package:provider/src/provider.dart';

class NumberPagination extends StatefulWidget {
  int toPage;
  int currentPage;
  int lastPage;
  int total;
  NumberPagination(
      {Key? key,
      required this.currentPage,
      required this.toPage,
      required this.lastPage,
      required this.total})
      : super(key: key);

  @override
  State<NumberPagination> createState() => _NumberPaginationState();
}

class _NumberPaginationState extends State<NumberPagination> {
  int? toPage;
  int? currentPage;
  int? lastPage;
  int? total;

  @override
  void initState() {
    super.initState();
    toPage = widget.toPage;
    total = widget.total;
    currentPage = widget.currentPage;
    lastPage = widget.lastPage;
  }

  @override
  Widget build(BuildContext context) {
    print(toPage);
    print(currentPage);
    return Container(
      width: 162,
      height: 40,
      decoration: BoxDecoration(
        // color: Colors.red,
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(5),
      ),
      clipBehavior: Clip.none,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          PaginationButton(
            onPressed: currentPage! > 1
                ? () {
                    context
                        .read<NewsBloc>()
                        .add(StartFetchNews(currentPage! - 1));
                  }
                : null,
            icon: Icons.navigate_before,
          ),
          Row(
            children: [
              PageNumber(
                currentPage: currentPage,
                isCurrent: true,
                disabled: false,
              ),
              GestureDetector(
                onTap: () => {
                  context.read<NewsBloc>().add(StartFetchNews(currentPage! + 1))
                },
                child: PageNumber(
                  currentPage: currentPage,
                  isCurrent: false,
                  disabled: total! == toPage,
                ),
              )
            ],
          ),
          PaginationButton(
            onPressed: currentPage! != lastPage
                ? () {
                    context
                        .read<NewsBloc>()
                        .add(StartFetchNews(currentPage! + 1));
                  }
                : null,
            icon: Icons.navigate_next,
          ),
        ],
      ),
    );
  }
}

class PageNumber extends StatelessWidget {
  const PageNumber({
    Key? key,
    required this.currentPage,
    required this.isCurrent,
    required this.disabled,
  }) : super(key: key);

  final int? currentPage;
  final bool isCurrent;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: 40,
      decoration: BoxDecoration(
        color: isCurrent ? primaryColor : Colors.white,
        border: Border(
          right: BorderSide(
            color: Colors.grey.shade400,
          ),
        ),
      ),
      child: Center(
        child: Text(
          (isCurrent ? currentPage : currentPage! + 1).toString(),
          style: TextStyle(
            color: !isCurrent
                ? disabled
                    ? Colors.grey
                    : primaryColor
                : Colors.white,
          ),
        ),
      ),
    );
  }
}

class PaginationButton extends StatelessWidget {
  PaginationButton({Key? key, required this.onPressed, required this.icon})
      : super(key: key);

  Function()? onPressed;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Icon(
          icon,
          color: onPressed == null ? Colors.grey.shade400 : primaryColor,
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(),
          ),
          primary: Colors.white,
          elevation: 0,
          side: BorderSide(color: Colors.white),
          onSurface: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 8),
        ),
      ),
    );
  }
}
