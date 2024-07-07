import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubits/add_cards_cubit/add_card_cubit.dart';
import 'package:notes_app/cubits/read_cards_cubit/read_cards_cubit.dart';
import 'package:notes_app/models/card_model.dart';
import 'package:notes_app/views/notes_view.dart';
import 'package:notes_app/widgets/custom_app_bar.dart';
import 'package:notes_app/widgets/text_field1.dart';

class NoteEditView extends StatefulWidget {
  const NoteEditView({super.key, required this.card});
  final CardModel card;

  @override
  State<NoteEditView> createState() => _NoteEditViewState();
}

class _NoteEditViewState extends State<NoteEditView> {
  late String title, descr;
  late int selectedColor;

  @override
  void initState() {
    super.initState();
    title = widget.card.title;
    descr = widget.card.descr;
    selectedColor = widget.card.color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Note Edit',
        iconButton: IconButton(
          icon: const Icon(Icons.check),
          onPressed: () {
            widget.card.title = title;
            widget.card.descr = descr;
            widget.card.color = selectedColor;
            widget.card.save();
            BlocProvider.of<ReadCardsCubit>(context).fetchAll();
            Navigator.pop(context);
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                maxHeight: constraints.maxHeight + 180,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: 16.0,
                  left: 16.0,
                  right: 16.0,
                  bottom: 16.0 + MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 30),
                    TextField1(
                      initialText: title,
                      onChanged: (val) {
                        title = val ?? '';
                      },
                    ),
                    const SizedBox(height: 20),
                    TextField1(
                      initialText: descr,
                      onChanged: (val) {
                        descr = val ?? '';
                      },
                      maxLines: 10,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 50,
                      child: ColorsListView(
                        selectedColor: selectedColor,
                        onColorSelected: (color) {
                          setState(() {
                            selectedColor = color;
                          });
                        },
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ColorsListView extends StatefulWidget {
  final int selectedColor;
  final Function(int) onColorSelected;
  const ColorsListView({
    super.key,
    required this.selectedColor,
    required this.onColorSelected,
  });

  @override
  State<ColorsListView> createState() => _ColorsListViewState();
}

class _ColorsListViewState extends State<ColorsListView> {
  late int selectedColor;

  @override
  void initState() {
    super.initState();
    selectedColor = widget.selectedColor;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: colors.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return ColorWidget(
            bgColor: colors[index],
            isSelected: colors[index] == selectedColor,
            onTap: () {
              setState(() {
                selectedColor = colors[index];
              });
              widget.onColorSelected(selectedColor);
            },
          );
        },
      ),
    );
  }
}

class ColorWidget extends StatelessWidget {
  const ColorWidget({
    super.key,
    required this.bgColor,
    required this.isSelected,
    this.onTap,
  });
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
                ),
              ),
      ),
    );
  }
}
