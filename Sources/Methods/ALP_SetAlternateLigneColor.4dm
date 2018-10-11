//%attributes = {}
  // ALP_SetAlternateLigneColor()
  // Por: Alberto Bachler: 22/03/13, 16:19:22
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)

$l_referenciaAreaList:=$1
<>vl_AltBackground_Red:=243  //237
<>vl_AltBackground_Green:=246  //243
<>vl_AltBackground_Blue:=250  //254
<>vl_FixBackground_Red:=255
<>vl_FixBackground_Green:=255
<>vl_FixBackground_Blue:=255
<>vl_FooterBackground_Red:=255
<>vl_FooterBackground_Green:=255
<>vl_FooterBackground_Blue:=255
AL_SetBackRGBColor ($l_referenciaAreaList;0;0;0;0;<>vl_FixBackground_Red;<>vl_FixBackground_Green;<>vl_FixBackground_Blue;<>vl_FooterBackground_Red;<>vl_FooterBackground_Green;<>vl_FooterBackground_Blue)
AL_SetAltRowColor ($l_referenciaAreaList;<>vl_AltBackground_Red;<>vl_AltBackground_Green;<>vl_AltBackground_Blue;1)

