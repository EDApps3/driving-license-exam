
import 'package:flutter/material.dart';

class SelectionSquare extends StatelessWidget {
  final String text;
  final bool isSelected,isContinue,fullWidth;
  final Function onTap;
  final TextAlign? textAlign;
  final Color? selectedColor;
  final double? fontSize;

  const SelectionSquare({
    super.key,
    required this.text,
    this.isSelected = false,
    this.isContinue = false,
    required this.onTap,
    this.fullWidth = false,
    this.textAlign,
    this.selectedColor,
    this.fontSize,
  });

  Color getSelectedColor() {
    return (selectedColor!=null)?selectedColor!: (
        (isSelected)?Colors.blue:Colors.black
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ConstrainedBox(
          constraints:BoxConstraints(
            minWidth:(isContinue==true)?50:150,
            minHeight:(isContinue==true)?50: 50,
          ),
          child: Container(
            width: (fullWidth)?MediaQuery.of(context).size.width: null,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color:getSelectedColor(),
                width: 2.0,
              ),
            ),
            child:Padding(
              padding:  EdgeInsets.all(
                  (isContinue==true)?3:15.0
              ),
              child:(isContinue==true)?Icon(
                Icons.arrow_forward,
              ):Text(
                text,
                textAlign:(textAlign!=null)?textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize:fontSize?? 16.0,
                  color: getSelectedColor(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
