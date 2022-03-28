import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:untitled_design/app/modules/user/screens/contacts.dart';
import 'package:untitled_design/styles/styles.dart';
import 'package:untitled_design/widgets/elevated_button.dart';
import 'package:untitled_design/widgets/text_field.dart';
import 'package:untitled_design/controllers/UserController.dart';
import 'package:get/get.dart';
//For File reading :
import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';

//import 'package:path_provider/path_provider.dart';
UserController b = new UserController();

class AddEditContact extends StatelessWidget {
  const AddEditContact({
    required this.title,
    required this.name,
    required this.phoneNumber,
    Key? key,
  }) : super(key: key);
  final FormControl name, phoneNumber;
  final String title;
  @override
  Future<String> _read() async {
    String text = "";
    UserController a = new UserController();
    text = await a.readIndex();

    if (text != null)
      return text;
    else
      print("Error in Contact Operations.. [2]");
    return "1";
  }

  @override
  Future<String> bringInfo(which, index) async {
    print("************");
    print(which);
    print(index);
    which = which.toString() + index.toString();
    print(which);
    String re = await b.readInfo('$which');
    print(re + "name* edit add");
    if (b.readInfo('$which') != "") return re;
    return "not set";
  }

  @override
  Future<String> bringInfoPhone(which, index) async {
    which = which.toString() + index.toString();
    print(which + ", *********");
    String re = await b.readInfoPhone('$which');
    print(re + ":phone*");
    if (b.readInfo('$which') != "") return re;
    return "not set";
  }

  @override
  Widget build(BuildContext context) {
    String index = _read().toString(); //NEED AWAIT
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: CustomColors.backgroundColor,
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
                  Text(
                    title,
                    style: const TextStyle(
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
                padding: EdgeInsets.symmetric(
                  horizontal: Sizes.s32,
                  vertical: MediaQuery.of(context).size.height * 0.23,
                ),
                child: Column(
                  children: [
                    CustomTextField(
                      label: bringInfo("Contact_", index) != "not set"
                          ? bringInfo("Contact_", index).toString()
                          : 'contact name',
                      formControl: name,
                    ),
                    const SizedBox(height: Sizes.s24),
                    CustomTextField(
                      label: bringInfoPhone("Contact_", index) != "not set"
                          ? bringInfoPhone("Contact_", index).toString()
                          : 'contact phone number',
                      formControl: phoneNumber,
                    ),
                    const SizedBox(height: Sizes.s24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomElevatedButton(
                          title: 'Cancel',
                          onPressed: () => Navigator.pop(context),
                        ),
                        CustomElevatedButton(
                          title: 'Done',
                          onPressed: () async {
                            name.updateValue(name.value);
                            phoneNumber.updateValue(phoneNumber.value);
                            FocusScope.of(context).unfocus();

                            UserController userController = Get.find();
                            String ind = await _read();
                            userController.DoContact(
                                context, ind, name.value, phoneNumber.value);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
