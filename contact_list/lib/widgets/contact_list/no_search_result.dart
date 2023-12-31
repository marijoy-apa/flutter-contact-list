import 'package:flutter/material.dart';

class NoSearchResult extends StatelessWidget {
  const NoSearchResult({super.key, required this.searchItem});

  final String searchItem;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 40,
              color: Theme.of(context).iconTheme.color,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 220,
              child: Text(
                'No results for "$searchItem"',
                style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).iconTheme.color,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                semanticsLabel: 'noSearchResult',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Check the spelling or try a new search.',
              style: TextStyle(
                color: Theme.of(context).iconTheme.color,
              ),
            )
          ],
        ),
      ),
    );
  }
}
