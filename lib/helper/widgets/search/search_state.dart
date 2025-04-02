import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/search/custom_searchbar.dart';

class SearchState extends StatefulWidget {
  const SearchState({super.key});

  @override
  State<SearchState> createState() => _SearchStateState();
}

class _SearchStateState extends State<SearchState> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          CustomSearchbar(),
          Expanded(
            child: Text("data"),
          ),
        ],
      ),
    );
  }
}
