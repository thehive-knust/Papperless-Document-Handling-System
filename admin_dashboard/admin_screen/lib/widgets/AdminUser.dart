import 'dart:core';
import 'add_user.dart';
import 'package:admin_screen/widgets/display_user.dart';
import '../providers/portfolio_provider.dart';
import '../providers/search_results_provider.dart';
import 'package:admin_screen/services/requests_to_backend.dart';
import '../providers/users_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

import 'user_details.dart';

class AdminUser extends StatefulWidget {
  @override
  _AdminUserState createState() => _AdminUserState();
}

class _AdminUserState extends State<AdminUser> {
  bool fetchingUsers = false;
  List<dynamic>? users;

  Future<void> fetchUsers() async {
    fetchingUsers = true;
    users = await Api.fetchUsers();
    fetchingUsers = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
    Provider.of<PortfolioProvider>(context, listen: false).initialise();
  }

  void addUserScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return Adduser();
    }));
  }

  Color primaryLight = Color(0xFFEFF7FF);

  OverlayEntry? searchResults;

  OverlayEntry showSearchResults(
      screenSize, usersProvider, searchResultsProvider) {
    return OverlayEntry(
      //opaque: true,
      builder: (context) {
        return Positioned(
          left: 20,
          top: 60,
          width: screenSize.width * 0.5,
          //height: screenSi,
          child: Material(
            type: MaterialType.card,
            borderRadius: BorderRadius.circular(15),
            //color: Colors.black,
            elevation: 1.5,
            child: Container(
              constraints: BoxConstraints(
                maxHeight:
                    screenSize.height <= 300 ? 135 : screenSize.height * 0.5,
              ),
              child: Selector<SearchResultsProvider, List<dynamic>>(
                selector: (context, provider) => provider.searchResults,
                builder: (context, searchResults, child) {
                  return ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: searchResults
                        .map((user) => InkWell(
                              onTap: () {
                                usersProvider.selectedUser = user;
                                searchResultsProvider
                                    .updateSearchingStarted(false);
                                //Overlay.of(context)?.dispose();
                              },
                              child: ListTile(
                                title:
                                    Text(user.firstName + " " + user.lastName),
                                subtitle: Text(user.portfolio),
                              ),
                            ))
                        .toList(),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);
    final searchResultsProvider = Provider.of<SearchResultsProvider>(context);
    final screenSize = MediaQuery.of(context).size;

    if (users == null && !fetchingUsers) fetchUsers();
    if (users != null && usersProvider.rowList == null)
      usersProvider.initialise(context, users!);
    return Scaffold(
      backgroundColor: primaryLight,
      body: GestureDetector(
        onTap: () {
          searchResultsProvider.updateSearchingStarted(false);
        },
        child: Column(
          children: [
            Card(
              color: Colors.grey[600],
              child: Row(
                children: [
                  Expanded(
                    flex: 15,
                    child: Container(
                      //constraints: BoxConstraints(minHeight: 40, maxHeight: 50),
                      padding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                      // width: 900,
                      height: 50,
                      //margin: EdgeInsets.fromLTRB(10, 10, 50, 5),
                      child: TextField(
                        cursorColor: Colors.black,
                        cursorHeight: 25,
                        cursorWidth: 3.2,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                          prefixIcon: Icon(Icons.search),
                          filled: true,
                          hintText: "Search",
                          hintStyle: GoogleFonts.notoSans(),
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onChanged: (newValue) {
                          if (newValue.length == 0) {
                            searchResults!.remove();
                            searchResultsProvider.searchResults = [];
                            searchResultsProvider.searchingStarted = false;
                            return;
                          }

                          if (!searchResultsProvider.searchingStarted) {
                            searchResults = showSearchResults(screenSize,
                                usersProvider, searchResultsProvider);
                            Overlay.of(context)?.insert(searchResults!);
                            searchResultsProvider.searchingStarted = true;
                          }

                          searchResultsProvider.searchValue = newValue;
                          searchResultsProvider
                              .generateSearchResults(usersProvider);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () {},
                      hoverColor: Colors.black38,
                      splashRadius: 20,
                      icon: Icon(Icons.notifications),
                      tooltip: "Notification",
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: usersProvider.rowList == null
                    ? Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 5,
                          color: Colors.green,
                        ),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            UserDetails(),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 50, 50, 5),
                              child: Display(),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          addUserScreen(context);
        },
        label: Row(
          children: [
            Selector<SearchResultsProvider, bool>(
              selector: (context, provider) => provider.searchingStarted,
              builder: (context, searchingStarted, child) {
                if (!searchingStarted &&
                    searchResults != null &&
                    searchResults!.mounted) searchResults?.remove();
                return Icon(
                  Icons.add,
                  size: 35,
                );
              },
            ),
            if (screenSize.width > 1000) SizedBox(width: 8),
            if (screenSize.width > 1000) Text('Add user'),
          ],
        ),
      ),
    );
  }
}
