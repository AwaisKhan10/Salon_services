import 'package:get/get.dart';
import '../../../../../../core/enums/view_state.dart';
import '../../../../../../core/model/card.dart';
import '../../../../../../core/others/base_view_model.dart';
import '../../../../../../core/services/auth_service.dart';
import '../../../../../../core/services/database_service.dart';
import '../../../../../../locator.dart';

class CardDetialViewModel extends BaseViewModel{
  final authService =  locator<AuthService>();
  final _dbService = DatabaseService();
  CardDetails card = CardDetails();
  List<CardDetails> cards = [];

  CardDetialViewModel(bool isGetCards){
    if(isGetCards){
      getCards();
    }
  }

  getCards() async{
    setState(ViewState.busy);
    cards = await _dbService.getCards(authService.stylistUser!.id!);
    setState(ViewState.idle);
  }



  addCardDetails(List<CardDetails> cards) async{
    setState(ViewState.busy);
    await _dbService.addCardDetails(card, authService.stylistUser!.id!);
    cards.add(card);
    Get.back(result: cards);
    setState(ViewState.idle);
  }
}