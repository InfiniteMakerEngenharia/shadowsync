import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';

class EncryptionService {
  const EncryptionService();

  /// Criptografa um arquivo usando AES-256-CBC com a passphrase fornecida.
  /// O arquivo de saída contém o IV (16 bytes) seguido dos dados criptografados.
  Future<String> encryptFile({
    required String inputFilePath,
    required String outputFilePath,
    required String passphrase,
  }) async {
    final keyBytes = sha256.convert(utf8.encode(passphrase)).bytes;
    final key = Key(Uint8List.fromList(keyBytes));
    final iv = IV.fromSecureRandom(16);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));

    final sourceBytes = await File(inputFilePath).readAsBytes();
    final encrypted = encrypter.encryptBytes(sourceBytes, iv: iv);

    final payload = <int>[...iv.bytes, ...encrypted.bytes];
    await File(outputFilePath).writeAsBytes(payload, flush: true);

    return outputFilePath;
  }

  /// Descriptografa um arquivo AES-256-CBC usando a passphrase fornecida.
  /// Espera que o arquivo de entrada contenha o IV (primeiros 16 bytes) seguido dos dados criptografados.
  Future<String> decryptFile({
    required String inputFilePath,
    required String outputFilePath,
    required String passphrase,
  }) async {
    final keyBytes = sha256.convert(utf8.encode(passphrase)).bytes;
    final key = Key(Uint8List.fromList(keyBytes));

    final encryptedBytes = await File(inputFilePath).readAsBytes();
    
    if (encryptedBytes.length < 16) {
      throw StateError('Arquivo criptografado inválido: muito pequeno');
    }

    // Extrai o IV (primeiros 16 bytes)
    final ivBytes = encryptedBytes.sublist(0, 16);
    final iv = IV(Uint8List.fromList(ivBytes));

    // Extrai os dados criptografados (resto do arquivo)
    final cipherBytes = encryptedBytes.sublist(16);
    final encrypted = Encrypted(Uint8List.fromList(cipherBytes));

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    
    try {
      final decryptedBytes = encrypter.decryptBytes(encrypted, iv: iv);
      await File(outputFilePath).writeAsBytes(decryptedBytes, flush: true);
      return outputFilePath;
    } catch (e) {
      throw StateError('Falha ao descriptografar: senha incorreta ou arquivo corrompido');
    }
  }
}
