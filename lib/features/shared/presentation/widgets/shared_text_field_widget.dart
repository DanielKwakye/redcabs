import 'package:flutter/material.dart';

class SharedTextFieldWidget extends StatefulWidget {

  final String label;
  final String placeHolder;
  final Color? labelColor;
  final Color? placeHolderColor;
  final String? initialValue;
  final bool? readOnly;
  final bool? disabled;
  final void Function()? onTap;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String?)? onChange;
  final void Function(String?)? onSaved;
  final Widget? prefixIcon;
  final Widget? prefix;
  final Function(bool?)? onFocusChanged;
  final TextInputType? inputType;
  final bool? obscureText;
  final bool? isPassword;
  final bool? isPhone;
  final int? maxLines;
  final FocusNode? focusNode;
  final String? errorText;
  final Widget? suffix;
  final ValueChanged? onSubmitted;
  final Color? borderColor;


  const SharedTextFieldWidget({Key? key,
    this.maxLines = 1,
    this.initialValue,
    this.readOnly = false,
    this.disabled = false,
    this.onTap,
    this.controller,
    this.validator,
    this.onSaved,
    this.prefixIcon,
    this.prefix,
    this.onChange,
    required this.label,
    required this.placeHolder,
    this.onFocusChanged,
    this.inputType = TextInputType.text,
    this.obscureText = false,
    this.isPassword = false,
    this.isPhone = false,
    this.focusNode,
    this.errorText,
    this.suffix,
    this.labelColor,
    this.placeHolderColor,
    this.onSubmitted,
    this.borderColor
  }) : super(key: key);

  @override
  State<SharedTextFieldWidget> createState() => _SharedTextFieldWidgetState();
}

class _SharedTextFieldWidgetState extends State<SharedTextFieldWidget> {

  bool _hideText = true;
  bool hasReceivedFocus = false;
  final double radius = 5;

  @override
  Widget build(BuildContext context) {

    bool readOnly = widget.readOnly!;

    final theme = Theme.of(context);
    if(widget.disabled != null && widget.disabled!){
      readOnly = true;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,
          style: TextStyle(color: widget.labelColor ?? theme.colorScheme.onSurface, fontWeight: FontWeight.w500),),
        const SizedBox(height: 10,),
        Focus(
          child: TextFormField(
            controller: widget.controller,
            keyboardType: widget.inputType,
            initialValue: widget.initialValue,
            readOnly: readOnly,
            focusNode: widget.focusNode,
            onTap: widget.onTap,
            onFieldSubmitted: widget.onSubmitted,
            maxLines: widget.maxLines,
            validator: widget.validator,
            obscureText:  widget.isPassword! ?_hideText : widget.obscureText!,
            onSaved:  widget.onSaved,
            onChanged: widget.onChange,
            cursorColor: widget.labelColor ?? theme.colorScheme.onBackground.withOpacity(0.5),
            style: TextStyle(color: widget.labelColor ?? theme.colorScheme.onBackground),
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              // labelText: widget.label,
                filled: true,
                // isDense: true,

                errorText: widget.errorText,
                fillColor:  (widget.disabled != null && widget.disabled!)? theme.colorScheme.outline : Colors.transparent,
                hintText: widget.placeHolder,
                hintStyle: TextStyle(color:  widget.placeHolderColor ?? theme.colorScheme.onBackground.withOpacity(0.5)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: widget.borderColor ?? theme.colorScheme.outline, width: 1),
                  borderRadius: BorderRadius.circular(radius),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: widget.borderColor ?? theme.colorScheme.outline, width: 1),
                  borderRadius: BorderRadius.circular(radius),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: widget.borderColor ?? theme.colorScheme.outline, width: 1),
                  borderRadius: BorderRadius.circular(radius),
                ),
                suffixIcon:  widget.isPassword! ? IconButton(onPressed: () => setState(() => _hideText = !_hideText), icon: Icon(_hideText ? Icons.visibility_outlined: Icons.visibility_off_outlined)) : widget.suffix ,
                prefixIcon: widget.prefixIcon,
                prefix:  widget.prefix,

            ),
          ),
          onFocusChange: (value) {
            setState(() {
              hasReceivedFocus = value;
              if(widget.onFocusChanged != null){
                widget.onFocusChanged!(value);
              }
            });

          },
        )

      ],
    );
  }
}
