import 'dart:async';

import 'package:fashionify/message/choose_user_page.dart';
import 'package:fashionify/message/simplify/group_info_screen.dart';
import 'package:fashionify/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:stream_chat_persistence/stream_chat_persistence.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'chat_info_screen.dart';
import 'notifications_service.dart';
import 'routes/app_routes.dart';  
import 'routes/routes.dart';
import 'package:fashionify/scoped-models/main.dart';
import 'package:fashionify/API.dart';
import 'dart:convert';

class MyMessage extends StatefulWidget {
  //final List<Product> wishlistProducts;
  final MainModel model;
  final StreamChatClient client;
  MyMessage(this.model,this.client);

  @override
  State<StatefulWidget> createState() {
    return _MyMessageState();
  }
}

class _MyMessageState extends State<MyMessage> {
  //final StreamChatClient client;
//   final apiKey = '6au9jdk3bz45';//await secureStorage.read(key: kStreamApiKey);
//   final userId = 'xisser';
// //   final chatPersistentClient = StreamChatPersistenceClient(
// //   logLevel: Level.INFO,
// //   connectionMode: ConnectionMode.background,
// // );

//  var client;

//  var chatPersistentClient;

 @override
void initState() {

//   WidgetsFlutterBinding.ensureInitialized();
//    chatPersistentClient = StreamChatPersistenceClient(
//   logLevel: Level.INFO,
//   connectionMode: ConnectionMode.background,
// );

//   client = StreamChatClient(
//     apiKey ?? kDefaultStreamApiKey,
//     logLevel: Level.INFO,
//   )..chatPersistenceClient = chatPersistentClient;
//     autoChatSync(/*widget.model.allProducts*/);
    super.initState();
  }

//  void autoChatSync(/*List<Product> products*/) async {
    
//    final SharedPreferences prefs = await SharedPreferences.getInstance();
//    String imageUrl = prefs.getString("imageUrl").replaceAll("&", "eqqqe");
//    String id = prefs.getString("id");
//    String name = prefs.getString("name");
//    print("my detailssssssssssss");
//    print(imageUrl);
//    print(id);
//    print(name);

//    //final apiKey = '6au9jdk3bz45';//await secureStorage.read(key: kStreamApiKey);
//    //final userId = 'xisser';//await secureStorage.read(key: kStreamUserId);

//   //  client = StreamChatClient(
//   //   apiKey ?? kDefaultStreamApiKey,
//   //   logLevel: Level.INFO,
//   // )..chatPersistenceClient = chatPersistentClient;
    
//     //Map<String, String> details = {"id": id, "name": name, "role": "user","image":imageUrl};
//     var url;//.toString();
//      print("looking for more ********************************************************");
//   if (userId != null) {
//     print("looking for more ********************************************************");
//     print(imageUrl);
//     url = 'https://secure-eyrie-88104.herokuapp.com/api?Query={"id":"$id","name":"$name","role":"user","image":"$imageUrl"}';//
//      var data = await getData(url);
//      //{"id":"$id","name":"$name","role":"user","image":"$imageUrl"}
//           print(" data is  $data  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
//        var decodedData = jsonDecode(data);
//     //  print("looking for more #######################################################");
//       print(" decodede data is$decodedData  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
//      // var decodedData = jsonDecode(data);
//       //setState(() {
//      // queryText = decodedData['Query'];
//     // });
//      //final token = decodedData;//'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiU2Ftd2VsIn0.7nBUx0MNKP-NscvSGQ7Ags-ARnR6gmwMTIU_-u-uG6A';
//      final token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiSllhU1FEemdPUWE0ZW9KVUFFZWlIbnh0MTg0MiJ9.eIi3Y9E5yRaeLw5gJQuAFZmWWRa3ZOpBf360yxXjBDY';
//    print("my toooken is $token");
//    print(data);
//     await client.connectUser(
//       User(id: userId),
//       token,
//     );
//   }
//  }

  @override
  Widget build(BuildContext context) {
    print("{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{${widget.client} ");
    return FutureBuilder<StreamingSharedPreferences>(
      future: StreamingSharedPreferences.instance,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SizedBox();
        }
        return //Container(color: Colors.blue,);
        PreferenceBuilder<int>(
          preference: snapshot.data.getInt(
            'theme',
            defaultValue: 0,
          ),
          builder: (context, snapshot) => MaterialApp(
            builder: (context, child) {
              return //Container(color: Colors.blue,);
              StreamChat(
                client: widget.client,
                onBackgroundEventReceived: (e) =>
                    showLocalNotification(e, widget.client.state.user.id),
                child: Builder( 
                  builder: (context) => AnnotatedRegion<SystemUiOverlayStyle>(
                    child: child,
                    value: SystemUiOverlayStyle(
                      systemNavigationBarColor:
                          StreamChatTheme.of(context).colorTheme.white,
                      systemNavigationBarIconBrightness:
                          Theme.of(context).brightness == Brightness.dark
                              ? Brightness.light
                              : Brightness.dark,
                    ),
                  ),
                ),
              );
            },
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: {
              -1: ThemeMode.dark,
              0: ThemeMode.system,
              1: ThemeMode.light,
            }[snapshot],
            onGenerateRoute: AppRoutes.generateRoute,
            initialRoute:
                widget.client.state.user == null ? Routes.CHOOSE_USER : Routes.HOME,
          ),
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final user = StreamChat.of(context).user;
    return Scaffold(
      backgroundColor: StreamChatTheme.of(context).colorTheme.whiteSnow,
      appBar: ChannelListHeader(
        onNewChatButtonTap: () {
          Navigator.pushNamed(context, Routes.NEW_CHAT);
        },
        preNavigationCallback: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
      ),
      drawerEdgeDragWidth: 50,
      
      body: ChannelListPage(),
    );
  }
}

class ChannelListPage extends StatefulWidget {
  @override
  _ChannelListPageState createState() => _ChannelListPageState();
}

class _ChannelListPageState extends State<ChannelListPage> {
  TextEditingController _controller;

  String _channelQuery = '';

  bool _isSearchActive = false;

  Timer _debounce;

  void _channelQueryListener() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      if (mounted) {
        setState(() {
          _channelQuery = _controller.text;
          _isSearchActive = _channelQuery.isNotEmpty;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()..addListener(_channelQueryListener);
  }

  @override
  void dispose() {
    _controller?.removeListener(_channelQueryListener);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = StreamChat.of(context).user;
    return WillPopScope(
      onWillPop: () async {
        if (_isSearchActive) {
          _controller.clear();
          setState(() => _isSearchActive = false);
          return false;
        }
        return true;
      },
      child: ChannelsBloc(
        child:ChannelListView(
                        onStartChatPressed: () {
                          Navigator.pushNamed(context, Routes.NEW_CHAT);
                        },
                        swipeToAction: true,
                        filter: {
                          'members': {
                            r'$in':[user.id],
                          },
                        },
                        options: {
                          'presence': true,
                        },
                        pagination: PaginationParams(
                          limit: 20,
                        ),
                        channelWidget: ChannelPage(),
                        onViewInfoTap: (channel) {
                          if (channel.memberCount == 2 && channel.isDistinct) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StreamChannel(
                                  channel: channel,
                                  child: ChatInfoScreen(
                                    user: channel.state.members.first.user,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StreamChannel(
                                  channel: channel,
                                  child: GroupInfoScreen(),
                                ),
                              ),
                            );
                          }
                        },
                      ),
      ),
    );
  }
}

class ChannelPageArgs {
  final Channel channel;
  final Message initialMessage;

  const ChannelPageArgs({
    this.channel,
    this.initialMessage,
  });
}

class ChannelPage extends StatefulWidget {
  final int initialScrollIndex;
  final double initialAlignment;
  final bool highlightInitialMessage;

  const ChannelPage({
    Key key,
    this.initialScrollIndex,
    this.initialAlignment,
    this.highlightInitialMessage = false,
  }) : super(key: key);

  @override
  _ChannelPageState createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  Message _quotedMessage;
  FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _reply(Message message) {
    setState(() => _quotedMessage = message);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StreamChatTheme.of(context).colorTheme.whiteSnow,
      appBar: ChannelHeader(
        showTypingIndicator: false,
        onImageTap: () async {
          var channel = StreamChannel.of(context).channel;

          if (channel.memberCount == 2 && channel.isDistinct) {
            final currentUser = StreamChat.of(context).user;
            final otherUser = channel.state.members.firstWhere(
              (element) => element.user.id != currentUser.id,
              orElse: () => null,
            );
            if (otherUser != null) {
              final pop = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StreamChannel(
                    child: ChatInfoScreen(
                      user: otherUser.user,
                    ),
                    channel: channel,
                  ),
                ),
              );

              if (pop == true) {
                Navigator.pop(context);
              }
            }
          } else {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StreamChannel(
                  child: GroupInfoScreen(),
                  channel: channel,
                ),
              ),
            );
          }
        },   
      ),
      body: Column(
        children: <Widget>[
          Expanded(
           
           child: Stack(
              children: <Widget>[
                MessageListView(
                  initialScrollIndex: widget.initialScrollIndex,
                  initialAlignment: widget.initialAlignment,
                  highlightInitialMessage: widget.highlightInitialMessage,
                  onMessageSwiped: _reply,
                  onReplyTap: _reply,
                  threadBuilder: (_, parentMessage) {
                    return ThreadPage(
                      parent: parentMessage,
                    );
                  },
                  onShowMessage: (m, c) async {
                    final client = StreamChat.of(context).client;
                    final message = m;
                    final channel = client.channel(
                      c.type,
                      id: c.id,
                    );
                    if (channel.state == null) {
                      await channel.watch();
                    }
                    Navigator.pushReplacementNamed(
                      context,
                      Routes.CHANNEL_PAGE,
                      arguments: ChannelPageArgs(
                        channel: channel,
                        initialMessage: message,
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    color: StreamChatTheme.of(context)
                        .colorTheme
                        .whiteSnow
                        .withOpacity(.9),
                    child: TypingIndicator(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      style: StreamChatTheme.of(context)
                          .textTheme
                          .footnote
                          .copyWith(
                              color:
                                  StreamChatTheme.of(context).colorTheme.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
          MessageInput(
            focusNode: _focusNode,
            quotedMessage: _quotedMessage,
            onQuotedMessageCleared: () {
              setState(() => _quotedMessage = null);
              _focusNode.unfocus();
            },
           ),
         ],
      ),
    );
  }
}

class ThreadPage extends StatefulWidget {
  final Message parent;
  final int initialScrollIndex;
  final double initialAlignment;

  ThreadPage({
    Key key,
    this.parent,
    this.initialScrollIndex,
    this.initialAlignment,
  }) : super(key: key);

  @override
  _ThreadPageState createState() => _ThreadPageState();
}

class _ThreadPageState extends State<ThreadPage> {
  Message _quotedMessage;
  FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _reply(Message message) {
    setState(() => _quotedMessage = message);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StreamChatTheme.of(context).colorTheme.whiteSnow,
      appBar: ThreadHeader(
        parent: widget.parent,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: MessageListView(
              parentMessage: widget.parent,
              initialScrollIndex: widget.initialScrollIndex,
              initialAlignment: widget.initialAlignment,
              onMessageSwiped: _reply,
              onReplyTap: _reply,
            ),
          ),
          if (widget.parent.type != 'deleted')
            MessageInput(
              parentMessage: widget.parent,
              focusNode: _focusNode,
              quotedMessage: _quotedMessage,
              onQuotedMessageCleared: () {
                setState(() => _quotedMessage = null);
                _focusNode.unfocus();
              },
            ),
        ],
      ),
    );
  }
}
