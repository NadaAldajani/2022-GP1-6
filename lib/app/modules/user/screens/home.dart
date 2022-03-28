import 'package:flutter/material.dart';
import 'package:untitled_design/app/app.dart';
import 'package:untitled_design/styles/styles.dart';
import 'package:untitled_design/utils/utils.dart';
import 'package:untitled_design/widgets/widgets.dart';

class UserHome extends StatelessWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        // extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(Sizes.s8),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildIconCard('userIcon', 'Profile', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserProfile(),
                      ),
                    );
                  }),
                  const Text(
                    'Home',
                    style: TextStyle(
                      color: CustomColors.pageNameAndBorderColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: CustomFonts.sitkaFonts,
                      fontSize: Sizes.sPageName,
                    ),
                  ),
                  _buildIconCard(
                    'menu',
                    'Menu',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserMenu(),
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: Sizes.s112,
                  bottom: Sizes.s24,
                  left: Sizes.s40,
                  right: Sizes.s40,
                ),
                child: Text(
                  'How can we help you with our ambulance services?',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: CustomFonts.sitkaFonts,
                    color: CustomColors.pageContentColor1,
                    fontSize: Sizes.sPageContent,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.s24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ShadowedCard(
                      radius: 10,
                      child: buildCard(() {}, 'helpme', 'Help me'),
                    ),
                    ShadowedCard(
                      radius: 10,
                      child: buildCard(() {}, 'helpthem', 'Help them'),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildIconCard(
                    'map',
                    'Map',
                    () {},
                    10,
                    Sizes.s8 / 3,
                  ),
                  // const Spacer(),
                  _buildIconCard(
                    'chatbot',
                    'Chatbot',
                    () {},
                    10,
                    Sizes.s8 / 3,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  InkWell buildCard(VoidCallback onTap, String icon, String title) {
    const imageSize = Sizes.s64;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          top: Sizes.s16,
          bottom: Sizes.s8,
        ),
        child: SizedBox(
          width: Sizes.s112,
          child: Column(
            children: [
              SizedBox(
                height: imageSize,
                width: imageSize,
                child: Image.asset(icon.png),
              ),
              const SizedBox(height: Sizes.s16),
              Text(
                title,
                style: const TextStyle(
                  fontFamily: CustomFonts.sitkaFonts,
                  fontSize: Sizes.sPageContent,
                  color: CustomColors.pageContentColor2,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconCard(
    String icon,
    String title,
    VoidCallback onTap, [
    double radius = 100,
    double padding = 0,
  ]) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          ShadowedCard(
            radius: radius,
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: ImageIcon(
                AssetImage(icon.png),
                size: Sizes.s40,
                color: CustomColors.pageContentColor1,
              ),
            ),
          ),
          const SizedBox(height: Sizes.s8 / 2),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: CustomFonts.sitkaFonts,
              color: CustomColors.pageContentColor1,
            ),
          ),
        ],
      ),
    );
  }
}
