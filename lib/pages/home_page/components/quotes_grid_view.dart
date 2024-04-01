import 'package:flutter/material.dart';
import 'package:quote_app/headers.dart';
import 'package:quote_app/utils/Global.dart';

Widget quotesGridView({required BuildContext context}) {
  bool isCategorySelected = Global.selectedCategory != "All";
  return isCategorySelected
      ? Expanded(
          flex: 12,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Scrollbar(
              thickness: 10,
              interactive: true,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 4 / 5,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: allQuotes.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.detailPage,
                      arguments: allQuotes[index],
                    );
                  },
                  child: Card(
                    color: Colors.primaries[index % 18].shade400,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            selectedCategoryQuote[index].quote,
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "- ${selectedCategoryQuote[index].author}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      : Expanded(
          flex: 12,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Scrollbar(
              thickness: 10,
              interactive: true,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 4 / 5,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: allQuotes.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.detailPage,
                      arguments: allQuotes[index],
                    );
                  },
                  child: Card(
                    color: Colors.primaries[index % 18].shade400,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            allQuotes[index].quote,
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "- ${allQuotes[index].author}",
                            style: TextStyle(color: Colors.white),
                          ),
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
