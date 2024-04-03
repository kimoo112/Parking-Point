import 'package:flutter/material.dart';
import 'package:parking_app/core/utils/app_assets.dart';
import 'package:parking_app/core/utils/app_text_styles.dart';
import 'package:parking_app/features/auth/presentation/widgets/custom_text_field.dart';

import '../data/model/search_model.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  bool isEmpty = false;
  List<SearchModel> searchedList = getSearchData;
  Future<void> searchForProducts(String value) async {
    searchedList = getSearchData
        .where((element) =>
            element.title.toLowerCase().contains(value.toLowerCase()))
        .toList();
    isEmpty = searchedList.isEmpty;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomTextField(
            onChanged: (p0) {
              searchForProducts(p0);
            },
            icon: Icons.search_off,
            hintText: 'Search here ...',
            suffIcon: Icons.filter_list_rounded,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Favoris (${searchedList.length})',
                style: CustomTextStyles.openSansBoldstyle20Blue),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: searchedList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Image.asset(Assets.imagesSearchImage),
                      title: Text(
                        searchedList[index].title,
                        style: CustomTextStyles.openSansBoldstyle20,
                      ),
                      subtitle: Text(getSearchData[index].subTitle,
                          style: CustomTextStyles.openSans400style16Black),
                      onTap: () {},
                    ),
                  );
                }),
          )
        ],
      )),
    );
  }
}
