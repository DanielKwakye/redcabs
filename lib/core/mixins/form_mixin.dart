
import 'package:flutter/cupertino.dart';

class FormMixin {

  String? required(String? value){
    if(value == ''){
      return 'Required';
    }
    return null;
  }

  bool validateAndSaveOnSubmit(BuildContext ctx) {
    final form = Form.of(ctx);
    if(!form.validate()){
      return false;
    }

    form.save();
    return true;


  }

}