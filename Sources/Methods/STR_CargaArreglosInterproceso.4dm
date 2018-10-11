//%attributes = {}
  //STR_CargaArreglosInterproceso

C_TEXT:C284(theText)
C_LONGINT:C283(iDay1;iDay2;iDay3;iDay4;iDay5;iDay6;iDay7;iDay8;iDay9;iDay10;iDay11;iDay12;iDay13;iDay14;iDay15;iDay16;iDay17;iDay18;iDay19)
C_LONGINT:C283(iDay20;iDay21;iDay22;iDay23;iDay24;iDay25;iDay26;iDay27;iDay28;iDay29)
C_LONGINT:C283(iDay30;iDay31;iDay32;iDay33;iDay34;iDay35;iDay36;iDay37;iDay38;iDay39)
C_LONGINT:C283(iDay40;iDay41;iDay42)

  //creación de arreglos y popups estructurales
  //==================================

ARRAY TEXT:C222(<>aLicencias;5)
LIST TO ARRAY:C288("STR_TiposLicencias";<>aLicencias)

ARRAY TEXT:C222(<>popIntLoc;0)
ARRAY TEXT:C222(<>popIntLoc2;0)
LOC_LoadList2Array ("STR_Interlocutores";-><>popIntLoc)
COPY ARRAY:C226(<>popIntLoc;<>popIntLoc2)

  //MONO Ticket 174967 Status Alumnos
C_OBJECT:C1216($ob_status)
ARRAY TEXT:C222(<>at_StatusAlumno;0)
ARRAY TEXT:C222(<>at_StatusAlumnoAlias;0)
ARRAY BOOLEAN:C223(<>ab_StatusAlumnoVisible;0)
ARRAY TEXT:C222($at_ObStatusChildNodes;0)
C_TEXT:C284($t_alias)
C_BOOLEAN:C305($b_visible)
  //$ob_status:=OB_Create 
$ob_status:=PREF_fGetObject (0;"PrefObj_StatusAlumno";$ob_status)
If (OB_GetSize ($ob_status)=0)
	ST_StatusAlumnoPrefSet 
	$ob_status:=PREF_fGetObject (0;"PrefObj_StatusAlumno";$ob_status)
End if 
OB_GetChildNodes ($ob_status;->$at_ObStatusChildNodes)

For ($i;1;Size of array:C274($at_ObStatusChildNodes))
	
	OB_GET ($ob_status;->$t_alias;$at_ObStatusChildNodes{$i}+".alias")
	OB_GET ($ob_status;->$b_visible;$at_ObStatusChildNodes{$i}+".visible")
	
	APPEND TO ARRAY:C911(<>at_StatusAlumno;$at_ObStatusChildNodes{$i})
	APPEND TO ARRAY:C911(<>at_StatusAlumnoAlias;$t_alias)
	APPEND TO ARRAY:C911(<>ab_StatusAlumnoVisible;$b_visible)
	
End for 
  //ARRAY TEXT(<>aStatus;8)
  //<>aStatus{1}:="Activo"
  //<>aStatus{2}:="Retirado temporalmente"
  //<>aStatus{3}:="Retirado"
  //<>aStatus{4}:="Promovido anticipadamente"
  //<>aStatus{5}:="Oyente"
  //<>aStatus{6}:="En trámite"
  //<>aStatus{7}:="-"
  //<>aStatus{8}:="Egresado"

ARRAY TEXT:C222(<>aSexSel;3)
<>aSexSel{1}:="Ambos sexos"
<>aSexSel{2}:="Femenino"
<>aSexSel{3}:="Masculino"

ARRAY TEXT:C222(<>aParentesco;0)
LIST TO ARRAY:C288("STR_Parentescos";<>aParentesco)

ARRAY TEXT:C222(<>at_ConnectionsType;0)
LIST TO ARRAY:C288("STR_Conexiones";<>at_ConnectionsType)

ARRAY POINTER:C280(<>aDaysPtr;42)
For ($i;1;42)
	<>aDaysPtr{$i}:=Get pointer:C304("iDay"+String:C10($i))
End for 


ARRAY TEXT:C222(<>aEvStyleType;3)
<>aEvStyleType{1}:="Estilo oficial del nivel"
<>aEvStyleType{2}:="Estilo interno del nivel"
<>aEvStyleType{3}:="Estilo de la asignatura"
<>aEvStyleType:=1
<>vi_lastEvStyleType:=1

If (Not:C34(<>vb_esBaseDeDatosNueva))
	NIV_LoadArrays 
	CU_LoadArrays 
	INIT_LoadSubsectores 
End if 



