class SearchModel {
  final String title;
  final String subTitle;

  SearchModel({
    required this.title,
    required this.subTitle,
  });
}

List<SearchModel> getSearchData = [
  SearchModel(
    title: 'Impark',
    subTitle: '105 rue Saint-Antoine Ouest',
  ),
  SearchModel(
    title: 'Stationnement salur rue',
    subTitle: '790 rue William',
  ),
  SearchModel(
    title: 'Stationnement sur da rue',
    subTitle: '144 boul. Robert-Bourassa',
  ),
  SearchModel(
    title: 'Parkopedia',
    subTitle: '150 rue Sainte-Catherine O',
  ),
  SearchModel(
    title: 'Complexe Desjardins',
    subTitle: '4382 av. du Square-Victoria',
  ),
  SearchModel(
    title: 'Stationnement sur la rue',
    subTitle: '216 rue King',
  ),
  SearchModel(
    title: 'Stationnement sur le male rue',
    subTitle: '687 rue Queen',
  ),
];
