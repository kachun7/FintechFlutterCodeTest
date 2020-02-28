import 'package:injectable/injectable.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

enum Page {
  Loan,
  History,
}

@injectable
class BottomBarStore extends StatesRebuilder {
  Page currentPage = Page.Loan;

  setPage(Page page) {
    currentPage = page;
    rebuildStates();
  }
}
