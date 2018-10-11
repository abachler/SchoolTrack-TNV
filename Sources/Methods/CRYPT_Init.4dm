//%attributes = {}
  // Method: CRYPT_Init
  //==============================================================
  //
  // Converted from C by Serge Thibault <logiciels.magellan@netaxis.qc.ca>
  // Optimized by Bruno Legay <blegay@pobox.com>
  //
  // Comments by Serge Thibault:
  // I converted the TEA C encryption/decryption algorythm to 4D some time
  // ago. It work very well. So here is the code. Perhaps you or somebody else
  // could be interested in using these plain 4D encryption/decryption routine.
  // This algorytm produce 32 bit encryption instead of 40 bit encryption (as
  // far as I can understand it. I'm not an encryption expert.)
  //
  // Bibliography:
  // "TEA, a Tiny Encryption Algorithm"
  // David Wheeler, Roger Needham
  // ftp://ftp.cl.cam.ac.uk/papers/djw-rmn/djw-rmn-tea.html
  //==============================================================

  // CONSTANT_INIT_ENCRYPTION
  // Initialisation of default Key constants

C_LONGINT:C283(<>vl_CRYPT_kEncryptMax;<>vl_CRYPT_kEncryptKey0;<>vl_CRYPT_kEncryptKey1;<>vl_CRYPT_kEncryptKey2;<>vl_CRYPT_kEncryptKey3)

<>vl_CRYPT_kEncryptKey0:=62463  // use any long value you want
<>vl_CRYPT_kEncryptKey1:=48653  // use any long value you want
<>vl_CRYPT_kEncryptKey2:=5241  // use any long value you want
<>vl_CRYPT_kEncryptKey3:=4325  // use any long value you want

<>vl_CRYPT_kEncryptMax:=15  // Minimum for ◊kEncryptMax is 4. This can also be changed
  // Comments by Serge Thibault and Bruno Legay:
  // The maximum string length that can be handled
  // is fixed by the variable <>kEncryptMax.
  // Of course, this length can be changed.
  // The length of the encrypted text will be 
  // between  (length of the source text) and (length of the source text +7)
  // Minimum for ◊kEncryptMax is 4

