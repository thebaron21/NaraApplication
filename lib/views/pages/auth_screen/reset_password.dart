import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp3/config/LocaleLang.dart';
import 'package:myapp3/config/pallete.dart';
import 'package:myapp3/core/bloc/auth/authenticationo_bloc.dart';
import 'package:myapp3/core/controller/control.dart';
import 'package:myapp3/views/widgets/row_product.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'widgets/box_button.dart';
import 'widgets/box_input_field.dart';

class ResetScreen extends StatefulWidget {
  String email;
  ResetScreen({this.email});

  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController password = TextEditingController();

  final TextEditingController confirmPassword = TextEditingController();

  final TextEditingController code = TextEditingController();
  bool isLoading = false;
  String title = "Verification Code";
  String subTitle = "please enter the OTP sent to your\n device";

  /// Return Title label
  get _getTitleText {
    return new Text(
      title,
      textAlign: TextAlign.left,
      style: new TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
    );
  }

  /// Return subTitle label
  get _getSubtitleText {
    return new Text(
      subTitle,
      textAlign: TextAlign.left,
      style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _heightSeperator = 22;
    // RestPasswordEvent
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          AppLocale.of(context).getTranslated("reset_pass"),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        bloc: AuthenticationBloc(),
        listener: (context, state) {
          if (state is AuthenticationRestPassword) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text( "Verification Code"  ),
                    content: Text('Code entered is $code'),
                  );
                });
            print("Successfully : ${state.isSuccess}");
            setState(() => isLoading = false);
            // Getx.of(context).toGet();
          } else if (state is AuthenticationRestPasswordError) {
            print("is Changed Password! : ${state.error}");
            setState(() => isLoading = false);
          }
        },
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: _heightSeperator,
                      ),
                      _getTitleText,
                      _getSubtitleText,
                      OtpTextField(
                        numberOfFields: 4,
                        borderColor: kcPrimaryColor,
                        showFieldAsBox:
                            true, //set to true to show as box or false to show as dash
                        onCodeChanged: (String cod) {
                          setState(() => code.text = cod);
                        }, // end onSubmit
                      ),
                      SizedBox(
                        height: _heightSeperator,
                      ),
                      SizedBox(
                        height: 40,
                        child: Center(
                          child: BoxInputField(
                            controller: password,
                            placeholder: 'كلمه المرور',
                            password: true,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: _heightSeperator,
                      ),
                      BoxInputField(
                        controller: confirmPassword,
                        placeholder: 'تاكييد كلمه المرور',
                        password: true,
                      ),
                      SizedBox(
                        height: _heightSeperator * 3,
                      ),
                      isLoading == false
                          ? BoxButton(
                              title: 'حفظ التغييرات',
                              onTap: () {
                                setState(() => isLoading = true);
                                context
                                    .read<AuthenticationBloc>()
                                    .add(RestPasswordEvent(
                                      widget.email,
                                      password.text,
                                      code.text,
                                      confirmPassword.text,
                                    ));

                                setState(() => isLoading = false);
                              },
                            )
                          : Center(
                              child: CircularProgressIndicator(
                              backgroundColor: kcPrimaryColor,
                            )),
                    ],
                  ),
                )
                //   ],
                // ),
                ),
          ),
        ),
      ),
    );
  }
}
