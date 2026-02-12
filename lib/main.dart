import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NFC Yes',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.indigo)),
      home: const NfcHomePage(),
    );
  }
}

class NfcHomePage extends StatefulWidget {
  const NfcHomePage({super.key});

  @override
  State<NfcHomePage> createState() => _NfcHomePageState();
}

class _NfcHomePageState extends State<NfcHomePage> {
  bool _isAvailable = false;
  bool _isScanning = false;
  String _status = 'NFC status unknown.';
  String _tagData = '';

  @override
  void initState() {
    super.initState();
    _checkAvailability();
  }

  Future<void> _checkAvailability() async {
    try {
      final isAvailable = await NfcManager.instance.isAvailable();
      setState(() {
        _isAvailable = isAvailable;
        _status = isAvailable ? 'NFC is available.' : 'NFC is not available.';
      });
    } catch (error) {
      setState(() {
        _isAvailable = false;
        _status = 'NFC check failed: $error';
      });
    }
  }

  Future<void> _startSession() async {
    if (!_isAvailable || _isScanning) {
      return;
    }
    setState(() {
      _isScanning = true;
      _status = 'Hold a tag near the device.';
      _tagData = '';
    });
    try {
      await NfcManager.instance.startSession(
        onDiscovered: (NfcTag tag) async {
          final data = jsonEncode(tag.data);
          setState(() {
            _status = 'Tag discovered.';
            _tagData = data;
          });
          await NfcManager.instance.stopSession();
          setState(() {
            _isScanning = false;
          });
        },
      );
    } catch (error) {
      setState(() {
        _status = 'Failed to start session: $error';
        _isScanning = false;
      });
    }
  }

  Future<void> _stopSession() async {
    if (!_isScanning) {
      return;
    }
    await NfcManager.instance.stopSession();
    setState(() {
      _isScanning = false;
      _status = 'Session stopped.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('NFC Scanner'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: ListTile(
                leading: Icon(
                  _isAvailable ? Icons.nfc : Icons.nfc_outlined,
                  color: _isAvailable ? Colors.green : Colors.grey,
                ),
                title: const Text('Device NFC Status'),
                subtitle: Text(_status),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _isAvailable && !_isScanning ? _startSession : null,
              icon: const Icon(Icons.play_arrow),
              label: const Text('Start Scan'),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: _isScanning ? _stopSession : null,
              icon: const Icon(Icons.stop),
              label: const Text('Stop Scan'),
            ),
            const SizedBox(height: 16),
            Text('Tag Data', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black.withValues(alpha: 0.03),
                ),
                child: SingleChildScrollView(
                  child: SelectableText(
                    _tagData.isEmpty
                        ? 'No tag scanned yet.'
                        : const JsonEncoder.withIndent(
                            '  ',
                          ).convert(jsonDecode(_tagData)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
