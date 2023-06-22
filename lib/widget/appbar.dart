import 'package:audio_kumbh/constants/asset_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonAppbar extends StatefulWidget {
  final Widget? leading;

  const CommonAppbar({super.key, this.leading});

  @override
  State<CommonAppbar> createState() => _CommonAppbarState();
}

class _CommonAppbarState extends State<CommonAppbar> {

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      leading: Builder(
        builder: (context) {
          return IconButton(
            color: Colors.white10,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: SvgPicture.asset(AssetConstant.drawerIcon,
                height: 15, width: 20, fit: BoxFit.fill),
          );
        },
      ),
      centerTitle: false,
      actions: [
        IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: SvgPicture.asset(AssetConstant.bellicon,
              height: 21,
              width: 21,
              fit: BoxFit.fill),
        ),
      ],
      title: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white),
            borderRadius:  const BorderRadius.all(
              Radius.circular(8),
            ),
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 0.2,
                  blurRadius: 1,
                  blurStyle: BlurStyle.outer)
            ]
        ),
        height: 47,
        width: double.infinity,
          child: const TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Type here "Geet"',
              hintStyle: TextStyle(
              fontFamily: 'f1',
                fontWeight: FontWeight.w500,
              color: Colors.brown
            ),
              icon: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.search,
                  color: Colors.brown,
                  size: 21,
                ),
              ),
            ),
            autofocus: false,
            cursorColor: Colors.brown,
            textAlign: TextAlign.start,
          ),
        ),
      );
  }
}
