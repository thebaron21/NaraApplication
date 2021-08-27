import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp3/config/LocaleLang.dart';
import 'package:myapp3/config/pallete.dart';
import 'package:myapp3/core/bloc/auth/authenticationo_bloc.dart';
import 'package:myapp3/core/bloc/rxdartBloc/profile_rxdart_bloc.dart';
import 'package:myapp3/core/controller/control.dart';
import 'package:myapp3/core/model/user_model.dart';
import 'package:myapp3/core/repoitorites/user_repoitory.dart';
import 'package:myapp3/core/response/authentication_reponse.dart';
import 'package:myapp3/main.dart';
import 'package:myapp3/views/pages/drawer/about_us_page.dart';
import 'package:myapp3/views/pages/drawer/call_us_page.dart';
import 'package:myapp3/views/pages/drawer/quation_page.dart';
import 'package:myapp3/views/pages/drawer/order_page.dart';
import 'package:myapp3/views/pages/favorities/favorities_page.dart';
import 'package:myapp3/views/widgets/drawer_app.dart';
import 'package:myapp3/views/widgets/network_widget.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../nara_app.dart';
import 'edit_profile.dart';
import 'login_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String _image = "assets/images/frosted-glass-texture.jpg";
  get _imageProfile =>
      (Size size, String image, String username, UserProfile user) {
        return Center(
          child: Container(
            width: size.width,
            height: size.height * 0.25,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.red.withOpacity(0.5),
                  Colors.teal.withOpacity(0.5),
                ],
              ),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: FlatButton(
                    onPressed: () async {
                      SharedPreferences obj =
                          await SharedPreferences.getInstance();
                      print(obj.getString("token"));
                      await obj.remove("token");
                      String to = obj.getString("token");
                      print(to);
                      Getx.of(context).toGetNotBack(NaraApp());
                    },
                    child: Text(AppLocale.of(context).getTranslated("logout"),
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  ),
                ),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(400),
                    child: CustomeNetWork(
                      image: user.image,
                    ),
                  ),
                ),
                _sizeBetweenText(size),
                Align(
                  alignment: Alignment.center,
                  child: FlatButton(
                    onPressed: () {
                      Getx.of(context).toGet(EditProfilePage(
                        user: user,
                      ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${AppLocale.of(context).getTranslated("welcome")} $username",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      };

  /// [Logic] of Page
  AuthenticationResponse _bloc = AuthenticationResponse();
  @override
  void initState() {
    super.initState();
    profileRxDart.getProfile();
  }

  @override
  void dispose() {
    super.dispose();
    profileRxDart.close();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backColor,
      // appBar: appBar(title: ),

      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          AppLocale.of(context).getTranslated("my_account"),
          style: TextStyle(color: Colors.black),
        ),
        leading: FlatButton(
          child: Icon(Icons.arrow_back_ios, color: Color(0xFF333333)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: StreamBuilder(
        stream: profileRxDart.subjectProfile.stream,
        // ignore: missing_return
        builder: (context, AsyncSnapshot<ProfileUserRespoitory> state) {
          if (state.hasData) {
            if (state.data.exception != null) {
              print("Page ${state.data.exception}");
              Getx.of(context).toGet(LoginScreen());
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.data.error != null &&
                state.data.exception == null) {
              return Center(child: Text("${state.data.error}"));
            }
            return Column(
              children: [
                _imageProfile(size, state.data.user.image, state.data.user.name,
                    state.data.user),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) => line,
                    itemCount: listMenu(context).length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () async {
                          SharedPreferences obj =
                              await SharedPreferences.getInstance();
                          if (listMenu(context)[index].onTap is LanguagePage) {
                            var lang = obj.getString("lang");
                            var token = obj.getString("token");
                            if (lang == "en") {
                              obj.setString("lang", "ar");
                              Getx.of(context).toGetNotBack(MyApp(
                                token: token,
                                locale: Locale('${lang}', ''),
                              ));
                            } else if (lang == "ar") {
                              obj.setString("lang", "en");
                              Getx.of(context).toGetNotBack(MyApp(
                                token: token,
                                locale: Locale('${lang}', ''),
                              ));
                            }

                            print("Language : $lang");
                          } else if (listMenu(context)[index].onTap != null) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    listMenu(context)[index].onTap(),
                              ),
                            );
                          }
                        },
                        child: ListTile(
                          title: Text("${listMenu(context)[index].text}"),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state.hasError) {
            return Center(
              child: Text("${state.error}"),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  get line =>
      Divider(thickness: 0.5, height: 1, color: Colors.black.withOpacity(0.4));

  /// [Size] help Bwtween
  get _sizeBetween => (Size size) => SizedBox(height: size.height * 0.05);
  get _sizeBetweenText => (Size size) => SizedBox(height: size.height * 0.025);
}

class MeunList {
  final String text;
  final Function onTap;

  MeunList({this.onTap, this.text});
}
