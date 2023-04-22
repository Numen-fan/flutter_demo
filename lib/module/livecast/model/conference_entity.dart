
enum ConferenceStatus {
  ended, //会议已结束
  created, //会议已创建，无人接听
  onGoing, //会议进行中，有人响应
  onGoingWithoutSelf, //会议进行中，没有邀请当前用户。见于旧版本拉取指定讨论组中的会议，可能存在此场景。讨论组解绑后已不存在。网络层遇到此值会直接忽略该会议
  callerCancel, //会议被主叫取消
  allCalleeReject, //会议被所有被叫拒绝
  allMemberLeave, //会议所有成员离开（包括reject和leave）
  selfRemoved, //本用户被移除会议
}

enum MemberState {
  disabled, //没有通话能力
  waiting,  //等待中
  busy,     //忙
  reject,   //拒绝
  inCall,   //通话中
  holding,  //保持（暂无实现，不用）
  leave     //已离开
}

enum LiveRole {
  admin,
  guest,
  participant
}

class ConferenceMember { //会议成员对象
  int uid;
  String headerPath; //头像地址
  String? account; //登录账号
  String displayName; //展示名称
  int? corpId; //企业id
  bool? corpAuthed; //企业身份是否已认证

  MemberState state = MemberState.disabled; //用户在会中状态
  bool isHost = false; //是否主持人
  LiveRole liveRole = LiveRole.guest; //直播中角色：主播、嘉宾、普通参与者
  bool muteAudio = true; //是否静音
  bool muteVideo = true; //是否有视频

  bool isVipTop = false; //是否置顶到主屏
  bool isSharing = false; //是否在共享
  bool hasInvite = false; //直播场景专用：是否已邀请，默认未邀请，角色为嘉宾
  bool isSelf = false; //是否当前用户

  int? flag; //???
  String? plat; //用户所在的端
  String? version; //协议版本号

  ConferenceMember(this.uid, this.headerPath, this.displayName,
      {bool? muteAudio, bool? muteVideo, bool? isVipTop, bool? isSharing,
        MemberState? state, bool? isHost, LiveRole? liveRole, String? account,
        bool? isSelf, int? corpId, bool? corpAuthed, bool? hasInvite}) {
    this.muteAudio = muteAudio ?? this.muteAudio;
    this.muteVideo = muteVideo ?? this.muteVideo;
    this.isVipTop = isVipTop ?? this.isVipTop;
    this.isSharing = isSharing ?? this.isSharing;
    this.state = state ?? this.state;
    this.isHost = isHost ?? this.isHost;
    this.liveRole = liveRole ?? this.liveRole;
    this.account = account;
    this.isSelf = isSelf ?? this.isSelf;
    this.corpId = corpId;
    this.corpAuthed = corpAuthed;
    this.hasInvite = hasInvite ?? this.hasInvite;
  }

  static ConferenceMember fromMap(Map<String, dynamic> map) {
    MemberState state = ConferenceMember.toMemberState(map['state']);
    LiveRole role = ConferenceMember.toLiveRole(map['live_role']);
    ConferenceMember member = ConferenceMember(
        map['uid'],
        map['head'],
        map['display_name'],
        muteAudio:map['mute_audio'],
        muteVideo:map['mute_video'],
        isVipTop:map['vip_top'],
        isSharing:map['sharing'],
        state:state,
        isHost:map['is_host'],
        liveRole:role,
        isSelf:map['is_self']
    );
    return member;
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "displayName": displayName,
        "headPath": headerPath,
        "live_role": 1,
        "isHost": isHost,
      };

  static MemberState toMemberState(int state) {
    switch (state) {
      case 0:
        return MemberState.disabled;
      case 1:
        return MemberState.waiting;
      case 2:
        return MemberState.busy;
      case 3:
        return MemberState.reject;
      case 4:
        return MemberState.inCall;
      case 5:
        return MemberState.holding;
      case 6:
        return MemberState.leave;
      default:
        return MemberState.disabled;
    }
  }

  static LiveRole toLiveRole(int role) {
    switch (role) {
      case 0:
        return LiveRole.admin;
      case 1:
        return LiveRole.guest;
      case 2:
        return LiveRole.participant;
        default:
      return LiveRole.guest;
    }
  }
}

class Conference {
  Conference(this.cid, String? confName, int? meetType, int? oppositeId,
      String? liveId) {
    this.confName = confName;
    this.meetType = meetType ?? this.meetType;
    this.oppositeId = oppositeId ?? this.oppositeId;
    this.liveId = liveId ?? this.liveId;
  }

  int cid;
  String? confName;
  String? liveId; //直播id
  ConferenceStatus? status; //会议状态
  int meetType = 0; //会议类型 0:多人会议  1:双人会议 2:双转多
  int oppositeId = 0; //对方uid，双人会议为另一份uid，多人会议为0
  ConferenceMember? currentMember; //当前用户

  Map<int, ConferenceMember> allMembers = Map<int, ConferenceMember>(); //所有成员
  List<ConferenceMember> joinedMembers = <ConferenceMember>[]; //已入会成员
  List<ConferenceMember> notInMembers = <ConferenceMember>[]; //未在会中成员
  List<ConferenceMember> applyMembers = <ConferenceMember>[]; //申请直播发言观众

  static Conference fromMap(Map<String, dynamic> map) {
    Conference conference = Conference(
        map['cid'],
        map['conf_name'],
        map['meeting_type'],
        map['opposite_id'],
        map['live_id']
    );
    return conference;
  }

  Map<String, dynamic> toJson() => {
    "cid": cid,
    "confName": confName,
    "meetType": meetType,
    "liveId": liveId
  };
}