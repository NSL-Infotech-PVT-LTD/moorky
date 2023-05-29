import 'package:flutter/cupertino.dart';
import 'package:moorky/profilecreate/model/lookingformodel.dart';
import 'package:moorky/quizscreens/model/languagemodel.dart';
import 'package:moorky/quizscreens/model/questionlistmodel.dart';
import 'package:moorky/quizscreens/model/quizcommonmodel.dart';
import 'package:moorky/quizscreens/repository/quizrepository.dart';

class QuizProvider extends ChangeNotifier{

  QuizCommonModel? _sexualorientationList;
  QuizCommonModel? get sexualorientationList => _sexualorientationList;

  QuizCommonModel? _drinkList;
  QuizCommonModel? get drinkList => _drinkList;

  QuizCommonModel? _smokeList;
  QuizCommonModel? get smokeList => _smokeList;

  QuizCommonModel? _kidsList;
  QuizCommonModel? get kidsList => _kidsList;

  QuizCommonModel? _educationList;
  QuizCommonModel? get educationList => _educationList;

  QuizCommonModel? _introextroList;
  QuizCommonModel? get introextroList => _introextroList;

  QuizCommonModel? _starsignList;
  QuizCommonModel? get starsignList => _starsignList;

  QuizCommonModel? _petsList;
  QuizCommonModel? get petsList => _petsList;

  QuizCommonModel? _religionList;
  QuizCommonModel? get religionList => _religionList;

  QuizCommonModel? _heightList;
  QuizCommonModel? get heightList => _heightList;

  QuestionListModel? _questionList;
  QuestionListModel? get questionList => _questionList;

  LanguageListModel? _languageList;
  LanguageListModel? get languageList => _languageList;

  LanguageListModel? _applanguageList;
  LanguageListModel? get applanguageList => _applanguageList;


  QuizRepository? quizRepository;

  void resetAllquizlist(){
    _drinkList=null;
    _languageList=null;
    _questionList=null;
    _heightList=null;
    _religionList=null;
    _petsList=null;
    _starsignList=null;
    _introextroList=null;
    _educationList=null;
    _kidsList=null;
    _smokeList=null;
    _sexualorientationList=null;
    notifyListeners();
  }
  QuizProvider(){
    initStream();
  }
  void initStream() {
    quizRepository=new QuizRepository();
    _questionList=null;
    notifyListeners();
  }
  void resetStreams() {
    initStream();
    notifyListeners();
  }
  void clerquestionlist(){
    _questionList=null;
    notifyListeners();
  }
  fetchSexualorientationList(String accessToken)
  async{
    QuizCommonModel? sexualorientationList = await QuizRepository.getsexualorientationList(accessToken);
    if (_sexualorientationList == null) {
      _sexualorientationList = sexualorientationList;
    }
    notifyListeners();
  }
  fetchHeightList(String accessToken)
  async{
    QuizCommonModel? heightList = await QuizRepository.getHeightList(accessToken);
    if (_heightList == null) {
      _heightList = heightList;
    }
    notifyListeners();
  }

  fetchDrinkList(String accessToken)
  async{
    QuizCommonModel? drinkList = await QuizRepository.getdrinklist(accessToken);
    if (_drinkList == null) {
      _drinkList = drinkList;
    }
    notifyListeners();
  }
  fetchSmokeList(String accessToken)
  async{
    _smokeList = null;
    QuizCommonModel? smokeList = await QuizRepository.getsmokelist(accessToken);
    if (_smokeList == null) {
      _smokeList = smokeList;
    }
    notifyListeners();
  }
  fetchKidsList(String accessToken)
  async{
    QuizCommonModel? kidsList = await QuizRepository.getfeelkidslist(accessToken);
    if (_kidsList == null) {
      _kidsList = kidsList;
    }
    notifyListeners();
  }
  fetchEducationList(String accessToken)
  async{
    QuizCommonModel? educationList = await QuizRepository.geteducationlist(accessToken);
    if (_educationList == null) {
      _educationList = educationList;
    }
    notifyListeners();
  }

  fetchIntroExtroList(String accessToken)
  async{
    QuizCommonModel? introextroList = await QuizRepository.getintroextrolist(accessToken);
    if (_introextroList == null) {
      _introextroList = introextroList;
    }
    notifyListeners();
  }

  fetchStarSignList(String accessToken)
  async{
    QuizCommonModel? starsignList = await QuizRepository.getstarsignlist(accessToken);
    if (_starsignList == null) {
      _starsignList = starsignList;
    }
    notifyListeners();
  }

  fetchPetsList(String accessToken)
  async{
    QuizCommonModel? petsList = await QuizRepository.getpetslist(accessToken);
    if (_petsList == null) {
      _petsList= petsList;
    }
    notifyListeners();
  }

  fetchReligionList(String accessToken)
  async{
    QuizCommonModel? religionList = await QuizRepository.getreligionlist(accessToken);
    if (_religionList == null) {
      _religionList = religionList;
    }
    notifyListeners();
  }

  fetchQuestionList(String accessToken)
  async{
    QuestionListModel? questionList = await QuizRepository.getquestionList(accessToken);
    if (_questionList == null) {
      _questionList = questionList;
    }
    notifyListeners();
  }
  fetchLanguageList(String accessToken)
  async{
    LanguageListModel? languageList = await QuizRepository.getlanguageList(accessToken);
    if (_languageList == null) {
      _languageList = languageList;
    }
    notifyListeners();
  }
  fetchappLanguageList(String accessToken)
  async{
    LanguageListModel? applanguageList = await QuizRepository.getapplanguageList(accessToken);
    if (_applanguageList == null) {
      _applanguageList = applanguageList;
    }
    notifyListeners();
  }

}