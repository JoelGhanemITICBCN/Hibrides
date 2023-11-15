import 'package:flutter/material.dart';
import 'package:namer_app/models/llista_articles.dart';
import 'package:provider/provider.dart';

class ComptadorEnter extends StatelessWidget {
  final int? index;
  ComptadorEnter({super.key, required this.index});

  @override
  // ignore: library_private_types_in_public_api

  Widget build(BuildContext context) {
    return Consumer<LlistaArticles>(builder: (context, LlistaArticles, _) {
      var article = LlistaArticles.itemAt(index ?? 0);
      var contador = article.quantity;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '$contador',
          ),
          Row(children: [
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    LlistaArticles.incrementaQuantitat(article);
                  },
                ),
                IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      LlistaArticles.decrementaQuantitat(article);
                    }),
              ],
            )
          ]),
        ],
      );
    });
  }
}
