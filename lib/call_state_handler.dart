import 'package:phone_state_background/phone_state_background.dart';

callStateHandler(
  PhoneStateBackgroundEvent event,
  String number,
  int duration,){
  if(event == PhoneStateBackgroundEvent.incomingend
    || event == PhoneStateBackgroundEvent.outgoingend){
      
      return;
    }
}