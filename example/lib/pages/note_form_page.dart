import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lemsa_nav_kit/lemsa_nav_kit.dart';
import 'package:flutter_nav_kit_example/session.dart';
import 'package:flutter_page_kit/flutter_page_kit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class NoteFormPage extends ConsumerStatefulWidget {
  const NoteFormPage({
    @PathParam('noteId') this.noteId = 'new',
    super.key,
  });

  final String noteId;

  @override
  ConsumerState<NoteFormPage> createState() => _NoteFormPageState();
}

class _NoteFormPageState extends ConsumerState<NoteFormPage>
    with PageData<NoteFormPage>, _NoteFormData {
  @override
  PageNavigator get nav => AutoPageNavigator(context.router);

  @override
  Notices get notices => ref.read(noticesProvider);

  @override
  Widget build(BuildContext context) {
    return PageScope(
      data: this,
      child: FormPage(
        title: widget.noteId == 'new' ? 'New note' : 'Note ${widget.noteId}',
        actions: actions,
        failure: failure,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: title.controller,
            decoration: InputDecoration(
              labelText: 'Title',
              errorText: showFieldErrors ? title.errorCode : null,
            ),
          ),
        ),
      ),
    );
  }
}

mixin _NoteFormData on State<NoteFormPage>, PageData<NoteFormPage> {
  PageNavigator get nav;
  Notices get notices;

  late final FieldText title = text();

  @override
  List<Validatable> get validated => [title];

  List<PageAction> get actions => [
    PageAction(
      id: 'save',
      label: 'Save',
      busyKey: 'save',
      isPrimary: true,
      onPressed: submit,
    ),
  ];

  Future<void> submit() => run(
    key: 'save',
    action: () async {
      if (!await validateForm()) {
        return;
      }
      notices.success('Saved');
      nav.pop<void>();
    },
  );
}
