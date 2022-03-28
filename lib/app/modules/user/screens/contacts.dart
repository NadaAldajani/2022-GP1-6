import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:untitled_design/styles/styles.dart';
import 'package:untitled_design/widgets/widgets.dart';

import '../../../../controllers/UserController.dart';
import '../../../app.dart';

class Contacts extends StatefulWidget {
  Contacts({Key? key}) : super(key: key);

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  UserController b = new UserController();

  final FormGroup contactForm = FormGroup({
    'name1': FormControl(),
    'phoneNumber1': FormControl<int>(),
    'name2': FormControl(),
    'phoneNumber2': FormControl<int>(),
    'name3': FormControl(),
    'phoneNumber3': FormControl<int>(),
  });

  @override
  _write(String text) async {
    UserController a = new UserController();
    a.index(text);
  }

  Future<String> bringInfo(which) async {
    var re = await b.readInfo('$which');
    print(re.toString() + ",, Contact page Info ");
    if (b.readInfo('$which') != "") return re.toString();
    return "Empty";
  }

  var name1;

  Future<void> name11() async {
    print("Enterd The Set function.");
    name1 = await bringInfo('index');
    print(name1 + "[name1]");
    print(await bringInfo('index') + "[await]");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(Sizes.s8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: CustomColors.pageContentColor1,
                    ),
                  ),
                  const Text(
                    'Contacts',
                    style: TextStyle(
                      fontFamily: CustomFonts.sitkaFonts,
                      color: CustomColors.pageNameAndBorderColor,
                      fontSize: Sizes.sPageName,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.2,
                ),
                child: ReactiveForm(
                  formGroup: contactForm,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      CustomCardTile(
                        icon: 'person',
                        title: bringInfo('Contact_1').toString(),
                        iconData: bringInfo('Contact_1').toString() == "Empty"
                            ? Icons.control_point_outlined
                            : Icons.edit_outlined,
                        onTap: () {
                          _write('1');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddEditContact(
                                title:
                                bringInfo('Contact_1').toString() == "Empty"
                                    ? 'Edit Contact'
                                    : 'Add Contact',
                                name:
                                contactForm.control('name1') as FormControl,
                                phoneNumber: contactForm.control('phoneNumber1')
                                as FormControl,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: Sizes.s24),
                      CustomCardTile(
                        icon: 'person',
                        title: bringInfo('Contact_2').toString(),
                        iconData: bringInfo('Contact_2').toString() == "Empty"
                            ? Icons.control_point_outlined
                            : Icons.edit_outlined,
                        onTap: () {
                          _write('2');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddEditContact(
                                title:
                                bringInfo('Contact_2').toString() == "Empty"
                                    ? 'Edit Contact'
                                    : 'Add Contact',
                                name:
                                contactForm.control('name2') as FormControl,
                                phoneNumber: contactForm.control('phoneNumber2')
                                as FormControl,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: Sizes.s24),
                      CustomCardTile(
                        icon: 'person',
                        title: bringInfo('Contact_3').toString(),
                        iconData: bringInfo('Contact_3').toString() == "Empty"
                            ? Icons.control_point_outlined
                            : Icons.edit_outlined,
                        onTap: () {
                          _write('3');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddEditContact(
                                title:
                                bringInfo('Contact_3').toString() == "Empty"
                                    ? 'Edit Contact'
                                    : 'Add Contact',
                                name:
                                contactForm.control('name3') as FormControl,
                                phoneNumber: contactForm.control('phoneNumber3')
                                as FormControl,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
