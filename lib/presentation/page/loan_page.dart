import 'package:code_test/core/theme_style.dart';
import 'package:code_test/presentation/store/loan_api_store.dart';
import 'package:code_test/presentation/store/loan_forrm_store.dart';
import 'package:code_test/presentation/view/error_message.dart';
import 'package:code_test/presentation/view/loading_indicator.dart';
import 'package:code_test/presentation/view/loan_text_field.dart';
import 'package:code_test/presentation/view/success_message.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class LoanPage extends StatefulWidget {
  @override
  _LoanPageState createState() => _LoanPageState();
}

class _LoanPageState extends State<LoanPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<LoanItem> _loanItems;
  List<Widget> _listItems;

  @override
  void initState() {
    super.initState();

    final ReactiveModel<LoanFormStore> loanService = Injector.getAsReactive();
    _setup(loanService.state);
  }

  @override
  void dispose() {
    super.dispose();

    for (final LoanItem loanItem in _loanItems) {
      loanItem.editingController.dispose();
      loanItem.focusNode.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Loan'),
      ),
      body: Form(
        key: _formKey,
        child: WhenRebuilder<LoanApiStore>(
          models: [ReactiveModel<LoanApiStore>()],
          onIdle: () => _getForm(),
          onWaiting: () => LoadingIndicator(),
          onError: (error) => ErrorMessage(error, _submitApplication),
          onData: (store) => _buildSuccessMessage(),
        ),
      ),
    );
  }

  void _setup(LoanFormStore loanFormStore) {
    loanFormStore.loadItem(_onChanged);
    _loanItems = loanFormStore.loanItems;

    _listItems = _loanItems
        .map((loanItem) => LoanTextField(
              loanItem.placeholder,
              loanItem.editingController,
              loanItem.focusNode,
              loanItem.nextFocusNode,
              loanItem.textInputType,
              loanItem.validator,
              loanItem.inputFormatters,
              loanItem.onChanged,
            ))
        .cast<Widget>()
        .toList();
  }

  void _onChanged(String value) {
    final ReactiveModel<LoanFormStore> loanService = Injector.getAsReactive();
    loanService.setState((store) => store.isFormValidated());
  }

  Widget _getForm() {
    return StateBuilder<LoanFormStore>(
      models: [ReactiveModel<LoanFormStore>()],
      builder: (_, builder) => _getListView(builder.state.isFormValidated()),
    );
  }

  Widget _getListView(bool isEnabled) {
    final listItems = List<Widget>.from(_listItems);
    listItems.add(_getSubmitButton(isEnabled));

    return ListView.separated(
        padding: const EdgeInsets.all(kMargin20),
        itemBuilder: (_, index) => listItems[index],
        separatorBuilder: (_, index) => const Divider(height: kMargin12, color: Colors.transparent),
        itemCount: listItems.length);
  }

  Widget _getSubmitButton(bool isEnabled) {
    return SizedBox(
      height: kButtonHeight,
      child: RaisedButton(
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Color(0xff000000), width: 0, style: BorderStyle.none),
          borderRadius: BorderRadius.all(Radius.circular(kMargin8)),
        ),
        onPressed: isEnabled ? _submitApplication : null,
        child: const Text('Submit'),
      ),
    );
  }

  void _submitApplication() {
    final ReactiveModel<LoanFormStore> loanService = Injector.getAsReactive();
    final ReactiveModel<LoanApiStore> loanApiService = Injector.getAsReactive();
    if (!loanService.state.isFormValidated()) {
      return;
    }

    loanApiService.setState(
      (store) => store.submitApplication(loanService.state.getApplicationFromForm()),
    );
  }

  Widget _buildSuccessMessage() {
    return SuccessMessage('Thanks for your application!', () {
      final ReactiveModel<LoanApiStore> loanApiService = Injector.getAsReactive();
      final ReactiveModel<LoanFormStore> loanService = Injector.getAsReactive();
      loanApiService.resetToIdle();
      setState(loanService.state.reset);
    });
  }
}
