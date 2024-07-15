import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:moorky/dashboardscreen/model/campaigndetailmodel.dart';
import 'package:moorky/dashboardscreen/model/campaignmodel.dart';
import 'package:moorky/dashboardscreen/model/chatlistmodel.dart';
import 'package:moorky/dashboardscreen/model/eventmodellist.dart';
import 'package:moorky/dashboardscreen/model/filterListModel.dart';
import 'package:moorky/dashboardscreen/model/ghostmodel.dart';
import 'package:moorky/dashboardscreen/model/remainderListModel.dart';
import 'package:moorky/dashboardscreen/model/userModel.dart';
import 'package:moorky/dashboardscreen/model/userModel.dart' as Im;
import 'package:moorky/dashboardscreen/model/userschatListModel.dart';
import 'package:moorky/dashboardscreen/model/youractivityListModel.dart';
import 'package:moorky/dashboardscreen/repository/dashboardrepository.dart';
import 'package:moorky/profilecreate/model/lookingformodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../calender/neat_and_clean_calendar_event.dart';

enum LoadMoreStatus { LOADING, STABLE }

class DashboardProvider extends ChangeNotifier {
  int totalPages = 0;

  int matchtotalPages = 0;

  int chattotalpage = 0;
  String anotherusername = "";
  ScrollController scrollController =
      ScrollController(initialScrollOffset: 0, keepScrollOffset: false);

  int currentCard = 0;
  int showCaseCount = 0;

  scrollUp() {
    scrollController.jumpTo(0);
  }

  LoadMoreStatus _loadMoreStatus = LoadMoreStatus.STABLE;
  getLoadMoreStatus() => _loadMoreStatus;

  UserModel? _userList;
  UserModel? get userList => _userList;

  ChatListModel? _chatList;
  ChatListModel? get chatList => _chatList;

  List<ChatData> allchatlist = [];

  List<NeatCleanCalendarEvent> event = <NeatCleanCalendarEvent>[];

  EventModelList? _eventModelList;
  EventModelList? get eventModelList => _eventModelList;

  GhostModel? _ghostModel;
  GhostModel? get ghostModel => _ghostModel;

  RemainderListModel? _remainderListModel;
  RemainderListModel? get remainderListModel => _remainderListModel;

  List<UserDatum>? _matchuserList;
  List<UserDatum>? get matchuserList => _matchuserList;

  List<UserDatum>? _searchuserList;
  List<UserDatum>? get searchuserList => _searchuserList;

  List<UserDatum> userModelList = [];
  int undo_count = 0;
  int qindex = 0;

  bool noUserdata = true;

  CampaignModel? _campaignList;
  CampaignModel? get campaignList => _campaignList;

  CampaignDetailModel? _campaigndetails;
  CampaignDetailModel? get campaigndetails => _campaigndetails;

  List<UserDatum>? _likeuserList;
  List<UserDatum>? get likeuserList => _likeuserList;

  FilterListModel? _filterListModel;
  FilterListModel? get filterListModel => _filterListModel;

  UsersChatListModel? _usersChatListModel;
  UsersChatListModel? get userChatListModel => _usersChatListModel;

  final imageController = PageController();

  YourActivitylistModel? _yourActivitylistModel;
  YourActivitylistModel? get yourActivitylistModel => _yourActivitylistModel;

  DashboardRepository? profileRepository;
  DashboardProvider() {
    initStream();
  }
  void resetalldashboardlist() {
    totalPages = 0;
    matchtotalPages = 0;
    _userList = null;
    _eventModelList = null;
    _ghostModel = null;
    event = [];
    // _matchuserList=null;
    _campaignList = null;
    _campaigndetails = null;
    _likeuserList = null;
    _filterListModel = null;
    _usersChatListModel = null;
    _yourActivitylistModel = null;
    _remainderListModel = null;
    userModelList = [];
    allchatlist = [];
    noUserdata = false;
    undo_count = 0;
    _searchuserList = null;
    notifyListeners();
  }

  void resetSearchUser() {
    _searchuserList = null;
    notifyListeners();
  }

  // List<String>? newImage=[];
  // List<String>filtrImages(List<Im.Images> ?images) {
  //   newImage?.clear();
  //
  //   for (int i = 1; i < (images??[]).length; i++) {
  //     if (images?.elementAt(i).image != "") {
  //       newImage?.add(images?.elementAt(i).image);
  //     }
  //   }
  //   notifyListeners();
  //   print("newImage?.length");
  //   print(newImage?.length);
  //   notifyListeners();
  //   return newImage??[];
  // }

  bool isLikeLoading = false;
  bool isDisLikeLoading = false;
  bool isHideLoading = false;

  showLoaderOnLike(bool value) {
    isLikeLoading = value;
    notifyListeners();
  }

  updateQindex(value) {
    qindex = value;
    notifyListeners();
  }

  showLoaderOnReport(bool value) {
    isHideLoading = value;
    notifyListeners();
  }

  updatePageControllerValue() {
    imageController.jumpToPage(1);
    notifyListeners();
  }

  showLoaderOnDisLike(bool value) {
    isDisLikeLoading = value;
    notifyListeners();
  }

  removeUserFromIndex({required int index}) {
    userModelList.removeAt(index);
    //updateCurrentCard();
    print("hererere");
    scrollUp();
    notifyListeners();
  }

  void addSearchUser(List<UserDatum>? searchlist) {
    _searchuserList = searchlist;
    notifyListeners();
  }

  void initStream() {
    profileRepository = new DashboardRepository();
    _campaigndetails = null;
    _userList = null;
    userModelList = [];
    allchatlist = [];
    noUserdata = false;
    notifyListeners();
  }

  void allchatlistremove() {
    allchatlist = [];
    notifyListeners();
  }

  void chatreset() {
    _chatList = null;
  }

  void resetFilter() {
    _filterListModel = null;
  }

  updateCurrentCard(int cardIndex) {
    currentCard = cardIndex;
  }

  clearCurrentCard() {
    currentCard = 0;
    notifyListeners();
  }

  void resetStreams() {
    initStream();
  }

  void resetEventList() {
    _eventModelList = null;
  }

  void resetInitStreamLike() {
    _likeuserList = null;
  }

  void resetChatlist() {
    _usersChatListModel = null;
    notifyListeners();
  }

  void resetLikeUserList() {
    _likeuserList = null;
    // _matchuserList=null;
    _yourActivitylistModel = null;
    _ghostModel = null;
    notifyListeners();
  }

  void reserMatchuserlist() {
    // _matchuserList=null;
    notifyListeners();
  }

  void addmatchuser(List<UserDatum>? matchlist) {
    // _matchuserList=matchlist;
    notifyListeners();
  }

  void filterUser() {
    _filterListModel = null;
    _filterListModel = filterListModel;
  }

  void addUser() {
    _userList = null;
    _userList = userList;

    notifyListeners();
  }

  void addLikeUser() {
    _likeuserList = likeuserList;
    notifyListeners();
  }

  void addChat(ChatListModel? model) {
    _chatList = model;
  }

  showNextShowCase() async {
    showCaseCount = showCaseCount + 1;
    print(showCaseCount);
    notifyListeners();
    if (showCaseCount! < 6) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences?.setBool("visited", true);
    }
  }
  clearShowCase(){
    showCaseCount=0;
    notifyListeners();
  }

  Future<bool> fetchUserList(
      String accessToken,
      int page,
      int limit,
      String age_from,
      String age_to,
      String date_with,
      String only_premium,
      String type,
      String search,
      String maritals,
      String looking_fors,
      String sexual_orientation,
      String start_tall_are_you,
      String end_tall_are_you,
      String do_you_drink,
      String do_you_smoke,
      String feel_about_kids,
      String education,
      String introvert_or_extrovert,
      String star_sign,
      String have_pets,
      String religion,
      String languages,
      String refresh) async {
    UserModel? userList = await DashboardRepository.getUserList(
        accessToken,
        page,
        limit,
        age_from,
        age_to,
        date_with,
        only_premium,
        type,
        search,
        maritals,
        looking_fors,
        sexual_orientation,
        start_tall_are_you,
        end_tall_are_you,
        do_you_drink,
        do_you_smoke,
        feel_about_kids,
        education,
        introvert_or_extrovert,
        star_sign,
        have_pets,
        religion,
        languages,
        refresh);
print("userList.data?[0].toJson()");
log(userList.data?[0].toJson().toString()??"");
    if (_userList == null) {
      _userList = userList;
      undo_count = _userList!.undo_count;
      userModelList.addAll(_userList!.data!);
      if (userModelList.isNotEmpty &&
          (userModelList.elementAt(0).images ?? []).isNotEmpty) {
        // filtrImages((userModelList.elementAt(0).images ?? []));
      }
      if (_userList!.message.toString().contains("Users not found")) {
        print(_userList!.message.toString());
        noUserdata = true;
        undo_count = 0;
        print(noUserdata);
        notifyListeners();
      }
      print("the data is$undo_count");
      _userList = null;

      //print(_userList!.data!.elementAt(0).id);
    } else {
      print(_userList!.data!.length);
      print("jhgsjhfgjhfs");
    }
    notifyListeners();
    return true;
  }

  // removeUserFromDeck(int index){
  //   userModelList.removeAt(index);
  //   notifyListeners();
  // }
  fetchSearcUserList(
      String accessToken, String user_id, int page, int limit) async {
    UserModel? userList = await DashboardRepository.getSaecrhUserList(
        accessToken, page, limit, "all", user_id);

    if (_userList == null) {
      _userList = userList;
      undo_count = _userList!.undo_count;
      userModelList.addAll(_userList!.data!);
      if (_userList!.message.toString().contains("Users not found")) {
        print(_userList!.message.toString());
        noUserdata = true;
        undo_count = 0;
        print(noUserdata);
        notifyListeners();
      }
      print("the data is");
      _userList = null;

      //print(_userList!.data!.elementAt(0).id);
    } else {
      print(_userList!.data!.length);
      print("jhgsjhfgjhfs");
    }
    notifyListeners();
  }

  bool isMatchLoading = false;
  fetchMatchesUserList(
      String accessToken, int page, int limit, String type) async {
    isMatchLoading = true;
    notifyListeners();
    // List<UserDatum>?    newMatchuserList = await DashboardRepository.getLikeUserList(accessToken,page,limit,type);
    List<UserDatum>? matchuserList = await DashboardRepository.getLikeUserList(
        accessToken, page, limit, type);
    print('======matchuserList$matchuserList');
    isMatchLoading = false;
    if ((matchuserList ?? []).isNotEmpty) {
      _matchuserList = matchuserList;
      // }
      notifyListeners();
    } else {
      _matchuserList = [];
    }
    notifyListeners();
  }

  fetchSearchUserList(String accessToken, String user_id, String type) async {
    List<UserDatum>? searchuserList =
        await DashboardRepository.getSearchUserList(accessToken, type, user_id);

    if (_searchuserList == null) {
      _searchuserList = searchuserList;
    }
    notifyListeners();
  }

  fetchFilterList(String accessToken) async {
    FilterListModel? filterListModel =
        await DashboardRepository.getFilterList(accessToken);
    // if (_filterListModel == null) {
    _filterListModel = filterListModel;
    //}
    notifyListeners();
  }

  fetchChatLists(String accessToken, String user_id) async {
    ChatListModel? chatList =
        await DashboardRepository.chatList(accessToken, user_id);
    if (_chatList == null) {
      _chatList = chatList;

      //anotherusername=_chatList!.data!.elementAt(0).receiverData!.name.toString();
    }
    notifyListeners();
  }

  fetchRemainderList(String accessToken) async {
    _remainderListModel=null;
    RemainderListModel? remainderListModel =
        await DashboardRepository.getRemainderList(accessToken);
    if (_remainderListModel == null) {
      _remainderListModel = remainderListModel;
    }
    notifyListeners();
  }

  fetchEventList(String accessToken, String userId) async {
    EventModelList? eventModelList =
        await DashboardRepository.getEventList(accessToken, userId);
    if (_eventModelList == null) {
      _eventModelList = eventModelList;
      List<NeatCleanCalendarEvent> ev = [];

      for (int i = 0; i < eventModelList.data!.length; i++) {
        print("asdfdhgad");
        print(i);
        print(eventModelList.data!.elementAt(i).date);
        var inputFormat = DateFormat('yyyy-MM-dd');
        var inputDate = inputFormat
            .parse(eventModelList.data!.elementAt(i).date.toString());
        var neat = NeatCleanCalendarEvent(
            eventModelList.data!.elementAt(i).title,
            description: eventModelList.data!.elementAt(i).description,
            startTime: DateTime(inputDate.year, inputDate.month, inputDate.day),
            endTime: DateTime(inputDate.year, inputDate.month, inputDate.day),
            color: Colors.indigo);
        ev.add(neat);
      }
      event = ev;
      print("this is event");
      print(event);
    }
    notifyListeners();
  }

  fetchGhostStickerList(String accessToken) async {
    GhostModel? ghostModel =
        await DashboardRepository.getGhostStickerList(accessToken);
    if (_ghostModel == null) {
      _ghostModel = ghostModel;
    }
    notifyListeners();
  }

  fetchChatList(String accessToken) async {
    print("sjhdcjhdcdsc");
    UsersChatListModel? usersChatListModel =
        await DashboardRepository.getChatList(accessToken);
    if (_usersChatListModel == null) {
      _usersChatListModel = usersChatListModel;
    }
    notifyListeners();
  }

  fetchUserActivity(String accessToken) async {
    YourActivitylistModel? yourActivitylistModel =
        await DashboardRepository.getUserAcitvity(accessToken);
    if (_yourActivitylistModel == null) {
      _yourActivitylistModel = yourActivitylistModel;
    }
    notifyListeners();
  }

  fetchLikeUserList(
      String accessToken, int page, int limit, String type) async {
    if ((totalPages == 0) || page <= totalPages) {
      List<UserDatum>? likeuserList = await DashboardRepository.getLikeUserList(
          accessToken, page, limit, type);
      if (_likeuserList == null) {
        totalPages = liketotalpage;
        _likeuserList = likeuserList;
        //_orderList = new List<OrderModel>.empty(growable: true);
      } else {
        _likeuserList!.addAll(likeuserList!);
        _likeuserList = _likeuserList;

        // One load more is done will make it status as stable.
        setLoadingState(LoadMoreStatus.STABLE);
      }
    }
    notifyListeners();
    if (page > totalPages) {
      // One load more is done will make it status as stable.
      setLoadingState(LoadMoreStatus.STABLE);
      notifyListeners();
    }
  }

  setLoadingState(LoadMoreStatus loadMoreStatus) {
    _loadMoreStatus = loadMoreStatus;
    notifyListeners();
  }

  fetchCampaignList(String accessToken) async {
    CampaignModel? campaignList =
        await DashboardRepository.getCampignList(accessToken);
    if (_campaignList == null) {
      _campaignList = campaignList;
    }
    notifyListeners();
  }

  fetchCampaignDetails(String accessToken, int id) async {
    CampaignDetailModel? campaigndetails =
        await DashboardRepository.getCampignDetails(accessToken, id);
    if (_campaigndetails == null) {
      _campaigndetails = campaigndetails;
    }
    notifyListeners();
  }

  notify() {
    notifyListeners();
  }
}
