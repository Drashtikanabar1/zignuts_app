
import 'package:firstapp/resources/string_manager.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Validator{

   static MultiValidator emailValidator = MultiValidator([
    RequiredValidator(errorText:StringManager.emailrequried),
    PatternValidator(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
        errorText: "please enter vaild email")
  ]);
   static  MultiValidator passValidator = MultiValidator([
    RequiredValidator(errorText:StringManager.emailrequried),
    PatternValidator(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
        errorText: "please enter vaild email")
  ]);
  static MultiValidator usernameValidator = MultiValidator([
    RequiredValidator(errorText: StringManager.userrequried),
    MinLengthValidator(4, errorText: StringManager.uservalid),
  ]);
static String? confirmpassworrd(String val,String password) {
                  if (val.isEmpty) {
                    return StringManager.confirmpasswordrequried;
                  }
                  if (val != password) {
                    return StringManager.confirmpasswordvalid;
                  }
                  return null;}
      
 static final cardnoValidator = MultiValidator([
    RequiredValidator(errorText: "card no is required"),
  ]);
static  final nameValidator = MultiValidator([
    RequiredValidator(errorText: "name is requried"),
  ]);
  static final websiteurlValidator = MultiValidator([
    RequiredValidator(errorText: "website url is requried"),
  ]);
  static final notesValidator = MultiValidator([
    RequiredValidator(errorText: "notes is requried"),
  ]);          
}