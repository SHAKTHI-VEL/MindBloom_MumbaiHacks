import 'dart:developer';
import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:deepgram_speech_to_text/deepgram_speech_to_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mindbloom/features/Home/widgets/micInput.dart';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'dart:io' show Directory, File, Platform;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<types.Message> _messages = [];

  final AudioRecorder _audioRecorder = AudioRecorder();
  bool _isRecording = false;
  String? _recordingPath;
  bool _hasMicPermission = false;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _checkAndRequestPermissions();
  }

  void sendMessage() async {
    try {
      var url = "http://10.1.212.188:5000/chat";
      var client = http.Client();
      final headers = {'Content-Type': 'application/json'};
      var response = await client.post(Uri.parse('$url'),
          headers: headers,
          body: ({
            "message": "I'm feeling great today",
            "user_name": "Shakthivel"
          }));
      var decodeResponse = jsonDecode(response.body);
      log(decodeResponse.toString());
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _checkAndRequestPermissions() async {
    if (Platform.isIOS) {
      final status = await Permission.microphone.status;

      if (status.isDenied) {
        // Request permission
        final result = await Permission.microphone.request();
        setState(() {
          _hasMicPermission = result.isGranted;
        });

        if (!result.isGranted) {
          // Show alert to help user enable permissions
          if (!mounted) return;
          _showPermissionDialog();
        }
      } else if (status.isPermanentlyDenied) {
        // Show settings dialog
        if (!mounted) return;
        _showSettingsDialog();
      } else {
        setState(() {
          _hasMicPermission = status.isGranted;
        });
      }
    }
  }

  Future<void> _showPermissionDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Microphone Permission Required'),
          content: const Text(
            'This app needs microphone access to record audio messages. '
            'Please grant microphone permission in your device settings.',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Open Settings'),
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showSettingsDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permission Required'),
          content: const Text(
            'Microphone access is required for voice messages. '
            'Please enable it in your device settings.',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Open Settings'),
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
            ),
          ],
        );
      },
    );
  }

  // User configurations
  final _user = const types.User(
      id: '82091008-a484-4a89-ae75-a22bf8d6f3ac', firstName: 'Sidessh');

  final _aiAgent = const types.User(
      id: 'ai-agent-id',
      firstName: 'AI Assistant',
      imageUrl: 'https://your-ai-avatar-url.com' // Optional: Add AI avatar
      );

  final AudioRecorder audioRecorder = AudioRecorder();

  // bool _isRecording = false;
  bool _isLoading = false;
  String? recordingPath;
  final TextEditingController _textController = TextEditingController();

  void _addMessage(String text, types.User author) {
    log('Adding message to chat: $text');

    final message = types.TextMessage(
      author: author,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: text,
    );

    setState(() {
      _messages.insert(0, message);
    });
  }

  Future<void> _getAIResponse(String userMessage) async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Replace with your API endpoint
      final response = await http.post(
        Uri.parse("http://10.1.212.211:8080/chat"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'message': userMessage, 'user_name': "Sidessh"}),
      );

      final data = jsonDecode(response.body);
      log(data.toString());
      final aiResponse = data['response'];
      _addMessage(aiResponse.toString(), _aiAgent);
    } catch (e) {
      log(e.toString());
      _addMessage('Sorry, I encountered an error. Please try again.', _aiAgent);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _handleSendPressed(types.PartialText message) async {
    _addMessage(message.text, _user);
    _textController.clear();
    await _getAIResponse(message.text);
  }

  void _handleTextSubmitted(String text) async {
    if (text.trim().isNotEmpty) {
      _addMessage(text, _user);
      _textController.clear();
      await _getAIResponse(text);
    }
  }

  Future<void> _handleMicPressed() async {
    if (!await Permission.microphone.isGranted) {
      final status = await Permission.microphone.request();
      if (!status.isGranted) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Microphone permission is required'),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }
    }

    try {
      if (!_isRecording) {
        // Start Recording
        final Directory appDir = await getApplicationDocumentsDirectory();
        final String filePath =
            '${appDir.path}/recording_${DateTime.now().millisecondsSinceEpoch}.m4a';

        log('Starting recording at path: $filePath');

        final config = RecordConfig(
          encoder: AudioEncoder.aacLc,
          bitRate: 128000,
          sampleRate: 44100,
          numChannels: 1,
        );

        await _audioRecorder.start(config, path: filePath);

        setState(() {
          _isRecording = true;
          _recordingPath = filePath;
        });

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Recording started...'),
            duration: Duration(seconds: 1),
          ),
        );
      } else {
        // Stop Recording
        setState(() {
          _isProcessing = true;
        });

        final path = await _audioRecorder.stop();
        log('Recording stopped. Path: $path');

        setState(() {
          _isRecording = false;
        });

        if (path != null) {
          final file = File(path);
          if (await file.exists()) {
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Processing audio...'),
                duration: Duration(seconds: 2),
              ),
            );

            try {
              log('Starting Deepgram transcription');

              final deepgram = Deepgram(
                '',
                baseQueryParams: {
                  'model': 'nova-2-general',
                  'detect_language': true,
                  'punctuation': true,
                  'filler_words': false,
                },
              );

              final result = await deepgram.transcribeFromFile(file);
              log('Deepgram response received: ${result.toString()}');

              if (result.transcript != null && result.transcript!.isNotEmpty) {
                log('Transcript: ${result.transcript}');

                // Add message to chat
                setState(() {
                  _addMessage(
                    result.transcript!,
                    _user,
                  );
                });

                // Optionally get AI response
                await _getAIResponse(result.transcript!);
              } else {
                log('Empty transcript received');
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('No speech detected in the recording'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            } catch (e) {
              log('Transcription error: $e');
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error processing audio: $e'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          } else {
            log('Recording file not found at path: $path');
          }
        } else {
          log('No recording path received from stop()');
        }

        setState(() {
          _isProcessing = false;
        });
      }
    } catch (e) {
      log('Recording error: $e');
      setState(() {
        _isRecording = false;
        _isProcessing = false;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Recording error: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // @override
  // void dispose() {
  //   _textController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                children: [
                  Text(
                    '👋 Hi Sidessh!',
                    style: TextStyle(
                      fontSize: screenWidth * 0.055,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'How are you \nfeeling?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenWidth * 0.08,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Chat(
                messages: _messages,
                onSendPressed: _handleSendPressed,
                user: _user,
                theme: const DefaultChatTheme(
                  inputBackgroundColor: Colors.white,
                  primaryColor: Color(0xff87A2FF),
                  secondaryColor: Colors.white70,
                ),
                customBottomWidget: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          decoration: InputDecoration(
                            hintText: 'Type your message here...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                          ),
                          onSubmitted: _handleTextSubmitted,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: _isProcessing ? null : _handleMicPressed,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: _isRecording
                                ? Colors.red
                                : _isProcessing
                                    ? Colors.grey
                                    : const Color(0xff87A2FF),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _isRecording
                                ? Icons.stop
                                : _isProcessing
                                    ? Icons.hourglass_bottom
                                    : Icons.mic,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // PDF Button
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xff87A2FF),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.history,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Existing Mic Button
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _audioRecorder.dispose();
    _textController.dispose();
    super.dispose();
  }
}
