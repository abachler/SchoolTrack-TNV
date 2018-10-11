//%attributes = {}
  //xALCB_XSbm_DateCalculation

  //declare the parameters
C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2;$3;$5;$6)  //These must be declared
C_POINTER:C301($4)  //This must be declared
C_LONGINT:C283($i)
ARRAY REAL:C219($asecs;0)
SELECTION RANGE TO ARRAY:C368($5;$5+$6-1;[xShell_BatchRequests:48]DTS:10;$aDTS)
For ($i;1;$6)
	$dts:=ST_GetWord ($aDTS{$i};1;".")
	$4->{$i}:=DTS_GetDateTimeString ($dts)+": "+ST_GetWord ($aDTS{$i};2;".")
End for 
