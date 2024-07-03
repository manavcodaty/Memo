import 'package:flutter/material.dart';
import 'package:Memo/models/flash_card_info.dart';
import 'package:Memo/utils/db_helper.dart';

class CardsViewEditPage extends StatefulWidget {
  final FlashCardInfo flashCardInfo;
  final List<FlashCardInfo> flashCardsInfo;

  const CardsViewEditPage(
    this.flashCardInfo, {
    super.key,
    required this.flashCardsInfo,
  });

  @override
  State<CardsViewEditPage> createState() => _CardsViewEditPageState();
}

class _CardsViewEditPageState extends State<CardsViewEditPage> {
  late FlashCardInfo editedFlashCardInfo;

  @override
  void initState() {
    super.initState();
    editedFlashCardInfo = FlashCardInfo.from(widget.flashCardInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const Text('Edit Card'), centerTitle: true),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: TextFormField(
                    initialValue: editedFlashCardInfo.question,
                    decoration: const InputDecoration(labelText: 'Question'),
                    onChanged: (value) => {
                          setState(() {
                            editedFlashCardInfo.question = value;
                          })
                        }),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: TextFormField(
                    initialValue: editedFlashCardInfo.answer,
                    decoration: const InputDecoration(labelText: 'Answer'),
                    onChanged: (value) => {
                          setState(() {
                            editedFlashCardInfo.answer = value;
                          })
                        }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    child: const Text('Save'),
                    onPressed: () async {
                      await DBHelper().update('cards', editedFlashCardInfo);
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop(editedFlashCardInfo);
                    },
                  ),
                  TextButton(
                    child: const Text('Delete'),
                    onPressed: () async {
                      await DBHelper()
                          .delete('cards', editedFlashCardInfo.cardid!);
                      setState(() {
                        widget.flashCardsInfo.remove(editedFlashCardInfo);
                      });

                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop(editedFlashCardInfo);
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
