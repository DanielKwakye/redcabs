import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info/package_info.dart';
import 'package:redcabs_mobile/app/routing/route_constants.dart';
import 'package:redcabs_mobile/core/utils/widget_view.dart';
import 'package:redcabs_mobile/features/users/data/models/user_model.dart';

import '../../../../core/storage/app_storage.dart';
import '../../../../core/utils/functions.dart';
import '../../../../core/utils/theme.dart';
import '../../../home/presentation/widgets/shared_logout_button_widget.dart';
import '../../../shared/presentation/widgets/shared_sliver_app_bar.dart';

class SettingsHomePage extends StatefulWidget {
  const SettingsHomePage({Key? key}) : super(key: key);

  @override
  SettingsHomePageController createState() => SettingsHomePageController();
}

////////////////////////////////////////////////////////
/// View is dumb, and purely declarative.
/// Easily references values on the controller and widget
////////////////////////////////////////////////////////

class _SettingsHomePageView
    extends WidgetView<SettingsHomePage, SettingsHomePageController> {
  const _SettingsHomePageView(SettingsHomePageController state) : super(state);

  @override
  Widget build(BuildContext context) {
    final theme = themeOf(context);
    final UserModel? user = AppStorage.currentUserSession;


    return Scaffold(
        body: CustomScrollView(
      slivers: [
        const SharedSliverAppBar(
          pageTitle: '',
          pinned: true,
          centerTitle: false,
        ),
        SliverFillRemaining(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 20, bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Your Account',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  context.push(editProfilePageRoute);
                },
                child: ListTile(
                  leading:  CircleAvatar(
                    backgroundColor: ash,
                    child: Text(
                      "${user?.name != null?user?.name![0]:'A'}${user?.otherNames !=null ? user?.otherNames![0]:'' }",
                      style:  TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: theme.colorScheme.onBackground),
                    ),
                  ),
                  title:  RichText(
                    text: TextSpan(
                        text: '${user?.name} ${user?.otherNames??''}',
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(height: 1.4,fontSize: 18),
                        ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      RichText(
                        text: TextSpan(
                            text: '${user?.email}',
                            style: theme.textTheme.bodySmall
                                ?.copyWith(height: 1.4,color: theme.colorScheme.onBackground),
                            children:  const [
                              // TextSpan(text: '${user?.phone}'),
                              // TextSpan(text: 'Sat, Feb 12th'),
                            ]),
                      ),
                      RichText(
                        text: TextSpan(
                            text: '${user?.phone}',
                            style: theme.textTheme.bodySmall
                                ?.copyWith(height: 1.4, color: theme.colorScheme.onBackground),
                            children: const [
                              // TextSpan(text: ' - '),
                              // TextSpan(text: 'Sat, Feb 12th'),
                            ]),
                      ),
                    ],
                  ),
                  trailing: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: kAppGreen,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        width: 50,
                        height: 25,
                        child: const Align(
                          alignment: Alignment.center,
                            child: Text('Edit',style: TextStyle(
                              color: kAppWhite,
                              fontWeight: FontWeight.w500

                            ),)),
                      ),
                    ],
                  )
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 20, bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'General',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
               ListTile(
                onTap: (){
                  context.push(changePasswordPageRoute);
                },
                leading: const CircleAvatar(
                  backgroundColor: ash,
                  child: Icon(
                    Icons.lock,
                    size: 20,
                    color: kAppWhite,
                  ),
                ),
                title: const Text(
                  "Change Password",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 17,
                ),
              ),

              ListTile(
                onTap: (){
                  context.go(chatPageRoute);
                },
                leading: const CircleAvatar(
                  backgroundColor: ash,
                  child: Icon(
                    Icons.message,
                    size: 20,
                    color: kAppWhite,
                  ),
                ),
                title: const Text(
                  "Chat Admin",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 17,
                ),
              ),
              const SharedLogoutButtonWidget(),
              const SizedBox(
                height: 10,
              ),
               ListTile(
                title: Text(
                  "Version ${state.appVersion}",
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}

////////////////////////////////////////////////////////
/// Controller holds state, and all business logic
////////////////////////////////////////////////////////

class SettingsHomePageController extends State<SettingsHomePage> {
  dynamic invoiceList = List.generate(10, (index) => index);
  late String appVersion ='';

  @override
  Widget build(BuildContext context) => _SettingsHomePageView(this);

  @override
  void initState() {
    super.initState();
    getAppInfo();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version;
    });

  }

}
