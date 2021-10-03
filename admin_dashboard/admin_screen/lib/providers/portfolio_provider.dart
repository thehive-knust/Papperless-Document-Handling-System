import 'package:admin_screen/services/requests_to_backend.dart';
import 'package:flutter/material.dart';

class PortfolioProvider with ChangeNotifier {
  Map<String, dynamic>? departments;
  Map<String, dynamic>? portfolios;
  Map<String, dynamic>? faculties;

  bool _departmentsLoading = false;
  bool _portfoliosLoading = false;
  bool _facultiesLoading = false;

  void updateData(category, String? newData) {
    switch (category) {
      case "portfolio":
        portfolios!['selectedPortfolio'] = newData;
        break;
      case "faculty":
        faculties!['selectedFaculty'] = newData;
        break;
      case "department":
        departments!["selectedDepartment"] = newData;
    }
    notifyListeners();
  }

  void initialise() async {
    while (!_departmentsLoading || !_facultiesLoading || !_portfoliosLoading) {
      if (portfolios == null && !_portfoliosLoading) fetchPortfolios();
      if (departments == null && !_departmentsLoading) fetchDepartments();
      if (faculties == null && !_facultiesLoading) fetchFaculties();
      Future.delayed(Duration(seconds: 1));
    }
  }

  Future<void> fetchPortfolios() async {
    _portfoliosLoading = true;
    portfolios = await Api.fetchCategory("portfolios");
    _portfoliosLoading = false;
  }

  Future<void> fetchFaculties() async {
    _facultiesLoading = true;
    faculties = {"faculties": await Api.fetchCategory("faculties")};
    _facultiesLoading = false;
  }

  Future<void> fetchDepartments() async {
    _departmentsLoading = true;
    departments = await Api.fetchCategory("departments");
    _departmentsLoading = false;
  }
}
