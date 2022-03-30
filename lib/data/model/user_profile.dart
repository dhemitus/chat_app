import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String? nama,
      namaBelakang,
      tempatLahir,
      alamatKtp,
      alamatDomisili,
      email,
      namaBank,
      cabangBank,
      namaNasabah,
      fotoDiri,
      fotoKtp;
  final String? nomorKtp, nomorHp, rekening;
  final String? tanggalLahir;
  final File? fotoFile;

  UserProfile(
      {this.nama,
        this.namaBelakang,
        this.nomorKtp,
        this.tempatLahir,
        this.tanggalLahir,
        this.alamatKtp,
        this.alamatDomisili,
        this.email,
        this.nomorHp,
        this.rekening,
        this.namaBank,
        this.cabangBank,
        this.namaNasabah,
        this.fotoDiri,
        this.fotoKtp,
        this.fotoFile});

  UserProfile copyWith({
    String? nama,
    String? namaBelakang,
    String? nomorKtp,
    String? tempatLahir,
    String? tanggalLahir,
    String? alamatKtp,
    String? alamatDomisili,
    String? email,
    String? nomorHp,
    String? rekening,
    String? namaBank,
    String? cabangBank,
    String? namaNasabah,
    String? fotoDiri,
    String? fotoKtp,
    File? fotoFile
  }) =>
      UserProfile(
          nama: nama ?? this.nama,
          namaBelakang: namaBelakang ?? this.namaBelakang,
          nomorKtp: nomorKtp ?? this.nomorKtp,
          tempatLahir: tempatLahir ?? this.tempatLahir,
          tanggalLahir: tanggalLahir ?? this.tanggalLahir,
          alamatKtp: alamatKtp ?? this.alamatKtp,
          alamatDomisili: alamatDomisili ?? this.alamatDomisili,
          email: email ?? this.email,
          nomorHp: nomorHp ?? this.nomorHp,
          rekening: rekening ?? this.rekening,
          namaBank: namaBank ?? this.namaBank,
          cabangBank: cabangBank ?? this.cabangBank,
          namaNasabah: namaNasabah ?? this.namaNasabah,
          fotoDiri: fotoDiri ?? this.fotoDiri,
          fotoKtp: fotoKtp ?? this.fotoKtp,
          fotoFile: fotoFile ?? this.fotoFile
      );

  Map<String, dynamic> toKtp() => {'no_ktp': nomorKtp};

  Map<String, dynamic> toEmail() => {'email': email};

  Map<String, dynamic> toHp() => {'no_hp': nomorHp};

  Map<String, dynamic> toRekening() => {'no_rekening': rekening};

  Map<String, dynamic> toBank() => {
    'no_rekening': rekening,
    'nama_bank': namaBank,
    'cabang_bank': cabangBank,
    'nama_nasabah': namaNasabah
  };

  Map<String, dynamic> toMap() => {
    'nama_depan': nama,
    'nama_belakang': namaBelakang,
    'no_ktp': nomorKtp,
    'tempat_lahir': tempatLahir,
    'tanggal_lahir': tanggalLahir!,
    'alamat_ktp': alamatKtp,
    'alamat_domisili': alamatDomisili,
    'email': email,
    'no_hp': nomorHp,
    'no_rekening': rekening,
    'nama_bank': namaBank,
    'cabang_bank': cabangBank,
    'nama_nasabah': namaNasabah,
    'foto_diri': fotoDiri,
    'foto_ktp': fotoKtp
  };

  factory UserProfile.fromMap(Map<String, dynamic> map) => UserProfile(
      nama: map['nama_depan'] ?? '',
      namaBelakang: map['nama_belakang'] ?? '',
      nomorKtp: map['no_ktp'] ?? '',
      tempatLahir: map['tempat_lahir'] ?? '',
      tanggalLahir: map['tanggal_lahir'] ?? '',
      alamatKtp: map['alamat_ktp'] ?? '',
      alamatDomisili: map['alamat_domisili'] ?? '',
      email: map['email'] ?? '',
      nomorHp: map['no_hp'] ?? '',
      rekening: map['no_rekening'] ?? '',
      namaBank: map['nama_bank'] ?? '',
      cabangBank: map['cabang_bank'] ?? '',
      namaNasabah: map['nama_nasabah'] ?? '',
      fotoDiri: map['foto_diri'] ?? '',

      fotoKtp: map['foto_ktp'] ?? '');

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
    nomorKtp,
    tempatLahir,
    tanggalLahir,
    alamatKtp,
    alamatDomisili,
    email,
    nomorHp,
    rekening,
    namaBank,
    cabangBank,
    namaNasabah,
    fotoDiri,
    fotoKtp,
    fotoFile
  ];
}
