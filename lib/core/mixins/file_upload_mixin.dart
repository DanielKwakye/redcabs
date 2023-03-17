import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redcabs_mobile/features/shared/presentation/widgets/shared_border_widget.dart';

import '../utils/enums.dart';
import '../utils/functions.dart';
import '../utils/theme.dart';


class FileUploadMixin {

  final ImagePicker _picker = ImagePicker();

  Future<void> displaySelectFileOptions(BuildContext context, { Function(File)? onFilePicked, onlyImage = false, onlyFiles= false}) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          // height: 200,
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            children: <Widget>[
              const ListTile(title: Text("Select source of file", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),),
              // const SizedBox(height: 10,),

              ListTile(
                onTap: () async {
                  //state.onAccountTypeSelected(AccountType.student);
                  // Pick an image
                  goBack(context);

                  FilePickerResult? result;
                  if(onlyImage){
                      // result = await FilePicker.platform.pickFiles(
                      //   type: FileType.custom,
                      //   allowedExtensions: ['jpg', 'jpeg', 'png' 'pdf'],
                      // );
                      final image = await ImagePicker().pickImage(source: ImageSource.gallery,);

                      if (image != null) {
                        File file = File(image.path);
                        onFilePicked!(file);
                        return;
                      }



                  }else if(onlyFiles){
                    result = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['pdf', 'doc', 'docx'],
                    );
                  }
                  else{
                      result = await FilePicker.platform.pickFiles(
                      // type: FileType.custom,
                      // allowedExtensions: ['jpg', 'jpeg', 'png' 'pdf', 'doc', 'docx'],
                      );
                  }


                  if (result != null) {
                    File file = File(result.files.single.path as String);
                    onFilePicked!(file);
                  } else {
                    // User canceled the picker
                  }

                },
                leading: _pageIconWidget(child: const Icon(Icons.attach_file, color: primary,)),
                title: const Text("Select from files"),
                subtitle: const Text("pick already saved files on your phone", style: TextStyle(),),
              ),
              const SharedBorderWidget(),
              if(!onlyFiles)
                ListTile(
                  leading: _pageIconWidget(child: const Icon(Icons.photo_camera, color: primary,)),
                  title: const Text("Take a picture"),
                  subtitle: const Text("this will open camera to capture the image"),
                  onTap: () async {
                    // state.onAccountTypeSelected(AccountType.driver);
                    // Capture a photo
                    goBack(context);

                    final XFile? file = await _picker.pickImage(source: ImageSource.camera);
                    onFilePicked!(File(file!.path));

                  },
                ),

            ],
          ),
        );
      },
    );
  }

  Widget _pageIconWidget({required Icon child}){
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
          border: Border.all(color: primary),
          borderRadius: BorderRadius.circular(20)
      ),
      child: child,
    );
  }


  void displayConfirmImageUpload(BuildContext context, File file, Function()? okTapped){
     showDialog(context: context, builder: (ctx) {
      return AlertDialog(
        title: const Text("Do you want to upload this file ?", style: TextStyle(fontWeight: FontWeight.bold),),
        content: Container(
          decoration: const BoxDecoration(
            // border: Border.all(
          ),
          child: filledFileWidgetInDialog(file),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context, rootNavigator: true).pop();
          }, child: const Text("Cancel", style: TextStyle(color: primary),)),

          TextButton(onPressed: (){
            Navigator.of(context, rootNavigator: true).pop();
            okTapped!();

          }, child: const Text("Upload",)),
        ],
      );

    });
  }

  Widget filledFileWidgetInDialog(File file, {strictlyAsDocument= false}) => Container(
    constraints: const BoxConstraints(maxHeight: 250),
    decoration: const BoxDecoration(
        color: Color(0xffF4F9FF),
    ),
    child: (getFileType(file.path) == ImagePickerFileType.image) && !strictlyAsDocument ?
        Image.file(file, fit: BoxFit.contain,)
        : ListTile(
          // leading: getFileType(file.path) == FileType.image ? ,
          leading: const Icon(Icons.attach_file_outlined),
          title: Text(basename(file.path)),
        ),
  );

  Widget filledFileWidgetInOnWidget(String fileName) => Container(
    constraints: const BoxConstraints(maxHeight: 250),
    decoration: const BoxDecoration(
      color: Color(0xffF4F9FF),
    ),
    child: ListTile(
      // leading: getFileType(file.path) == FileType.image ? ,
      leading: const Icon(Icons.attach_file_outlined),
      title: Text(fileName),
    )
  );


  Widget emptyFileWidget(String content) => ListTile(
    leading: Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(80)
      ),
      child: const Icon(Icons.file_copy_outlined, color: Colors.black,),
    ),
    title: Text(content),
  );


  void showAfterFileUploadDialog(BuildContext context, {String title= "Document Uploaded", String content = "Do you want to upload another document?",  void Function()? okTapped, void Function()? onCancelTapped}){
    showDialog(context: context, builder: (ctx) {
      return AlertDialog(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold),),
        content: Text(content),
        actions: [

          // cancel button
          TextButton(onPressed: (){
            Navigator.of(context).pop();
            onCancelTapped!();
          }, child: const Text("Yes upload another document")),

          // okay button
          TextButton(
              onPressed: () {}, child: const Text("No, upload later"))

        ],
      );
    });

  }


}