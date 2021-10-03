import '../models/user.dart';
import 'users_provider.dart';
import 'package:flutter/material.dart';

class SearchResultsProvider with ChangeNotifier {
  String? searchValue;
  List<User> searchResults = [];
  bool searchingStarted = false;

  void updateSearchingStarted(status) {
    searchingStarted = status;
    notifyListeners();
  }

  void generateSearchResults(UsersProvider usersProvider) async {
    final localSearchValue = searchValue;
    searchResults.clear();
    if (usersProvider.users == null || searchValue!.length == 0) return;
    for (var i = 0; i < usersProvider.users!.length; i++) {
      if (localSearchValue != searchValue) return;
      final user = usersProvider.users![i];
      if ((user.firstName + user.lastName + user.portfolio)
              .toLowerCase()
              .contains(localSearchValue!.toLowerCase()) &&
          searchResults.contains(user) == false) searchResults.add(user);
    }
  }
}
