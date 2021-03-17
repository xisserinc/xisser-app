import 'package:fashionify/message/stream_version.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'routes/routes.dart';

const kStreamApiKey = 'STREAM_API_KEY';
const kStreamUserId = 'STREAM_USER_ID';
const kStreamToken = 'STREAM_TOKEN';
const kDefaultStreamApiKey = '6au9jdk3bz45';

class ChooseUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("choose user pageeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
    final users = <String, User>{
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiSllhU1FEemdPUWE0ZW9KVUFFZWlIbnh0MTg0MiJ9.eIi3Y9E5yRaeLw5gJQuAFZmWWRa3ZOpBf360yxXjBDY':
          User(
        id: 'JYaSQDzgOQa4eoJUAEeiHnxt1842',
        extraData: {
          'name': 'suzana',
          'image':
              'https://firebasestorage.googleapis.com/v0/b/flutter-products-c24f0.appspot.com/o/images%2F22ba13c2-3995-4765-b2aa-de562445d95e-image_cropper_1615418551499.jpg?alt=mediaeqqqetoken=22ba13c2-3995-4765-b2aa-de562445d95e',
        },
      ),
      // 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiU2Ftd2VsIn0.VGo5G3gRGkoXSlaMXPfHJyf9zMiIfFbygEN-vnIJ_YA':
      //     User(
      //   id: 'Samwel',
      //   extraData: {
      //     'name': 'Sahil Kumar',
      //     'image':
      //         'https://ca.slack-edge.com/T02RM6X6B-U01EYU51M89-bbc152b40321-512',
      //   },
      // ),
      // 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiTGF0aWZhIn0.eJOIWUSvz_7Qx6Cl7Am2_hVqNl_Fv_Ps79O9AbyV4kY':
      //     User(
      //   id: 'Latifa',
      //   extraData: {
      //     'name': 'Ben Golden',
      //     'image':
      //         'https://ca.slack-edge.com/T02RM6X6B-U01AXAF23MG-f57403a3cb0d-512',
      //   },
      // ),
      
    };

    return Scaffold(
      backgroundColor: StreamChatTheme.of(context).colorTheme.whiteSnow,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 34,
                bottom: 20,
              ),
              child: Center(
                child: //Image.asset("assets/icon/xisser.jpg")
                SvgPicture.asset(
                 // 'assets/logo.svg',
                  'assets/icon/xisser.jpg',
                  height: 40,
                  color: StreamChatTheme.of(context).colorTheme.accentBlue,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 13.0),
              child: Text(
                'Welcome to Udsm Social Network',
                style: StreamChatTheme.of(context).textTheme.title,
              ),
            ),
            Text(
              'Select users to connect with:',
              style: StreamChatTheme.of(context).textTheme.body,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 32),
                child: ListView.separated(
                  separatorBuilder: (context, i) {
                    return Container(
                      height: 1,
                      color: StreamChatTheme.of(context).colorTheme.greyWhisper,
                    );
                  },
                  itemCount: users.length + 1,
                  itemBuilder: (context, i) {
                    return [
                      ...users.entries.map((entry) {
                        final token = entry.key;
                        final user = entry.value;
                        return ListTile(
                          onTap: () async {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              barrierColor: StreamChatTheme.of(context)
                                  .colorTheme
                                  .overlay,
                              builder: (context) => Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: StreamChatTheme.of(context)
                                        .colorTheme
                                        .white,
                                  ),
                                  height: 100,
                                  width: 100,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              ),
                            );

                            final secureStorage = FlutterSecureStorage();
                            final client = StreamChat.of(context).client;
                            client.apiKey = kDefaultStreamApiKey;
                            await client.setUser(
                              user,
                              token,
                            );

                            secureStorage.write(
                              key: kStreamApiKey,
                              value: kDefaultStreamApiKey,
                            );
                            secureStorage.write(
                              key: kStreamUserId,
                              value: user.id,
                            );
                            secureStorage.write(
                              key: kStreamToken,
                              value: token,
                            );
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              Routes.HOME,
                              ModalRoute.withName(Routes.HOME),
                            );
                          },
                          leading: UserAvatar(
                            user: user,
                            constraints: BoxConstraints.tight(
                              Size.fromRadius(20),
                            ),
                          ),
                          title: Text(
                            user.name,
                            style:
                                StreamChatTheme.of(context).textTheme.bodyBold,
                          ),
                          subtitle: Text(
                            'Stream test account',
                            style: StreamChatTheme.of(context)
                                .textTheme
                                .footnote
                                .copyWith(
                                  color: StreamChatTheme.of(context)
                                      .colorTheme
                                      .grey,
                                ),
                          ),
                          trailing: //Image.asset("assets/icon/xisser.jpg")#######
                          StreamSvgIcon.arrowRight(
                            color: StreamChatTheme.of(context)
                                .colorTheme
                                .accentBlue,
                          ),
                        );
                      }),
                      ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.ADVANCED_OPTIONS);
                        },
                        leading: CircleAvatar(
                          child: StreamSvgIcon.settings(
                            color: StreamChatTheme.of(context).colorTheme.black,
                          ),
                          backgroundColor: StreamChatTheme.of(context)
                              .colorTheme
                              .greyWhisper,
                        ),
                        title: Text(
                          'Advanced Options',
                          style: StreamChatTheme.of(context).textTheme.bodyBold,
                        ),
                        subtitle: Text(
                          'Custom settings',
                          style: StreamChatTheme.of(context)
                              .textTheme
                              .footnote
                              .copyWith(
                                color:
                                    StreamChatTheme.of(context).colorTheme.grey,
                              ),
                        ),
                        trailing: SvgPicture.asset(
                         // 'assets/icon_arrow_right.svg',
                        'assets/icon/xisser.jpg',
                          height: 24,
                          width: 24,
                          clipBehavior: Clip.none,
                        ),
                      ),
                    ][i];
                  },
                ),
              ), 
            ),
            StreamVersion(),
          ],
        ),
      ),
    );
  }
}

