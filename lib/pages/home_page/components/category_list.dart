import 'package:quote_app/headers.dart';
import 'package:quote_app/utils/Global.dart';

Widget categoryList({required setState}) {
  return Expanded(
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: allCategories
          .map(
            (e) => GestureDetector(
              onTap: () {
                Global.selectedCategory == e
                    ? Global.selectedCategory = "All"
                    : Global.selectedCategory = e;
                selectedCategoryQuote = allQuotes
                    .where((element) =>
                        element.category == Global.selectedCategory)
                    .toList();
                setState(() {});
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Global.selectedCategory == e
                        ? Colors.primaries[allCategories.indexOf(e)]
                        : Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                          offset: Global.selectedCategory == e
                              ? Offset(-5, -5)
                              : Offset(-0, -0),
                          color: Colors.grey)
                    ]),
                child: Text(
                  e.replaceFirst(
                    e[0],
                    e[0].toUpperCase(),
                  ),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
          .toList(),
    ),
  );
}
