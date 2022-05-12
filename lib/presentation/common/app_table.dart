import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:moreinfo/presentation/common/circle_icon_button.dart';
import 'package:moreinfo/presentation/config/constants.dart';
import 'package:provider/src/provider.dart';

void defaultonSelectChanged(e) {}

class AppTable extends StatelessWidget {
  List headerItems;
  List<Widget>? actions;
  List data;
  String? route;
  Function(dynamic) onSelectChanged;
  AppTable({
    Key? key,
    required this.headerItems,
    required this.data,
    this.route,
    this.onSelectChanged = defaultonSelectChanged,
    this.actions = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(
      showCheckboxColumn: false,
      columns: [
        ...headerItems
            .map(
              (e) => DataColumn(
                label: Text(
                  e["title"],
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            )
            .toList(),
        const DataColumn(
          label: Text(
            '',
          ),
        ),
      ],
      rows: data
          .map(
            (e) => DataRow(
              onSelectChanged: (y) {
                onSelectChanged(e);
              },
              cells: [
                ...headerItems
                    .map(
                      (i) => DataCell(Text(e[i["key"]].toString())),
                    )
                    .toList(),
                DataCell(
                  Row(
                    children: [
                      CircleIconButton(
                        icon: Icons.schedule_outlined,
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/period_list',
                          );
                        },
                      ),
                      CircleIconButton(
                        icon: Icons.edit_outlined,
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/survey_form',
                            arguments: {'isEdit': true},
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
          .toList(),
    );
  }
}
