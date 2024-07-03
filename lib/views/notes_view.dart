import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/cubits/cubit/add_card_cubit.dart';
import 'package:notes_app/models/card_model.dart';
import 'package:notes_app/widgets/card_widget.dart';
import 'package:notes_app/widgets/custom_app_bar.dart';
import 'package:notes_app/widgets/text_field1.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class NotesView extends StatelessWidget {
  const NotesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddCardCubit(),
        ),
      ],
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return ModalSheet();
                });
          },
          child: const Icon(Icons.add),
        ),
        appBar: const CustomAppBar(
          title: 'Notes',
          icon: Icons.search,
        ),
        body: Expanded(child: cardsListView()),
      ),
    );
  }
}

Widget cardsListView() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0),
    child: ListView.builder(
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return CardWidget(
            cardEntity: CardModel(
                color: Colors.cyan,
                title: 'Note #1',
                descr: 'This is the fst Note in the app',
                date: DateTime(2019, 1, 30)),
          );
        }),
  );
}

class ModalSheet extends StatefulWidget {
  ModalSheet({super.key});

  @override
  State<ModalSheet> createState() => _ModalSheetState();
}

class _ModalSheetState extends State<ModalSheet> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  final GlobalKey<FormState> formKey = GlobalKey();
  String? title, description;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCardCubit, AddCardState>(
      listener: (context, state) {
        if (state is AddCardFailed) {
          print('failed: ${state.errorMsg}');
        } else if (state is AddCardSucceeded) {
          Navigator.pop();
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is AddCardLoading ? true : false,
          child: Form(
            key: formKey,
            child: Container(
                child: Column(children: [
              const SizedBox(
                height: 25,
              ),
              TextField1(
                hintText: 'Title',
                onSaved: (val) {
                  title = val;
                },
              ),
              // const SizedBox(height: 20),
              TextField1(
                hintText: 'Content',
                maxLines: 5,
                onSaved: (val) {
                  description = val;
                },
              ),
              Expanded(
                  child: Placeholder(
                color: Colors.transparent,
              )),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                width: MediaQuery.of(context).size.width,
                height: 90,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                    } else {
                      autovalidateMode = AutovalidateMode.always;
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(primaryColor)),
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              )
            ])),
          ),
        );
      },
    );
  }
}
