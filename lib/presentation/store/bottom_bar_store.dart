import 'package:states_rebuilder/states_rebuilder.dart';

enum Page {
  Loan,
  History,
}

class BottomBarStore extends StatesRebuilder {
  Page currentPage = Page.Loan;

  setPage(Page page) {
    currentPage = page;
    rebuildStates();
  }
}
