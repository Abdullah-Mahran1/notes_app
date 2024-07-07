import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/cubits/add_cards_cubit/add_card_cubit.dart';
import 'package:notes_app/cubits/read_cards_cubit/read_cards_cubit.dart';
import 'package:notes_app/models/card_model.dart';
import 'package:notes_app/widgets/card_widget.dart';
import 'package:notes_app/widgets/custom_app_bar.dart';
import 'package:notes_app/widgets/text_field1.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

List colors = [0xffFFB703, 0xffFB8500, 0xff219EBC, 0xff8ECAE6];

class NotesView extends StatelessWidget {
  const NotesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor.withOpacity(0.5),
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return ModalSheet();
              });
        },
        child: const Icon(
          Icons.add,
          size: 36,
          color: Colors.white,
        ),
      ),
      appBar: CustomAppBar(
        title: 'Notes',
        iconButton:
            IconButton(icon: const Icon(Icons.search), onPressed: () {}),
      ),
      body: cardsListView(),
    );
  }
}

Widget cardsListView() {
  return BlocBuilder<ReadCardsCubit, ReadCardsState>(
    builder: (context, state) {
      List<CardModel> cards =
          BlocProvider.of<ReadCardsCubit>(context).fetchAll() ?? [];
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: ListView.builder(
            itemCount: cards.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return CardWidget(cardModel: cards[index]);
            }),
      );
    },
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
          debugPrint('failed: ${state.errorMsg}');
        } else if (state is AddCardSucceeded) {
          BlocProvider.of<ReadCardsCubit>(context).fetchAll();
          debugPrint('printed successfully}');
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: ModalProgressHUD(
            inAsyncCall: state is AddCardLoading ? true : false,
            child: Form(
              key: formKey,
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * 3 / 5,
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
                    ColorsListView(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 8),
                      width: MediaQuery.of(context).size.width,
                      height: 90,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            CardModel cardModel = CardModel(
                                color: Colors.orangeAccent.value,
                                title: title!,
                                descr: description!,
                                date: DateTime.now().toString().split(' ')[0]);
                            BlocProvider.of<AddCardCubit>(context)
                                .addNote(cardModel);
                          } else {
                            autovalidateMode = AutovalidateMode.always;
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(primaryColor)),
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),
                    )
                  ])),
            ),
          ),
        );
      },
    );
  }
}

class ColorsListView extends StatefulWidget {
  const ColorsListView({
    super.key,
  });

  @override
  State<ColorsListView> createState() => _ColorsListViewState();
}

class _ColorsListViewState extends State<ColorsListView> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(
      child: ListView.builder(
          shrinkWrap: true,
          // padding: EdgeInsets.symmetric(
          // horizontal: MediaQuery.of(context).size.width /
          //     (2 * colors.length - 1)),
          itemCount: colors.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return ColorWidget(
                bgColor: colors[index],
                isSelected: selectedIndex == index,
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                });
          }),
    )
        //   child: Placeholder(
        // color: Colors.transparent,
        );
  }
}

class ColorWidget extends StatelessWidget {
  const ColorWidget(
      {super.key, required this.bgColor, required this.isSelected, this.onTap});
  final int bgColor;
  final bool isSelected;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Center(
          child: isSelected
              ? CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 16,
                  child: InkWell(
                    onTap: onTap,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 16,
                      child: CircleAvatar(
                        backgroundColor: Color(bgColor),
                        radius: 14,
                      ),
                    ),
                  ),
                )
              : CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 16,
                  child: InkWell(
                    onTap: onTap,
                    child: CircleAvatar(
                      backgroundColor: Color(bgColor),
                      radius: 16,
                    ),
                  ))),
    );
  }
}
