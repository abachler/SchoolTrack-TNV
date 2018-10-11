//%attributes = {}
  // BBLpat_RegenerarCodigosDeBarra()
  // Por: Alberto Bachler: 17/09/13, 13:29:34
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_RegenerarProtegidos)
_O_C_INTEGER:C282($i_lectores)
C_LONGINT:C283($l_IDProgreso)
C_TEXT:C284($t_mensajeProgreso)

ARRAY LONGINT:C221($al_RecNums;0)

If (Count parameters:C259=1)
	$b_RegenerarProtegidos:=$1
End if 

LONGINT ARRAY FROM SELECTION:C647([BBL_Lectores:72];$al_RecNums;"")
If (Size of array:C274($al_RecNums)>0)
	$l_IDProgreso:=IT_Progress (1;0;0;__ ("Generando nuevos códigos de barra..."))
	For ($i_lectores;1;Size of array:C274($al_RecNums))
		READ WRITE:C146([BBL_Lectores:72])
		GOTO RECORD:C242([BBL_Lectores:72];$al_RecNums{$i_lectores})
		If ($b_RegenerarProtegidos)
			[BBL_Lectores:72]Barcode_Protegido:39:=False:C215
		End if 
		If (Not:C34([BBL_Lectores:72]Barcode_Protegido:39))
			[BBL_Lectores:72]Código_de_barra:10:=""
			[BBL_Lectores:72]BarCode_SinFormato:38:=""
		End if 
		BBLpat_GeneraCodigoBarra 
		SAVE RECORD:C53([BBL_Lectores:72])
		$l_IDProgreso:=IT_Progress (0;$l_IDProgreso;$i_lectores/Size of array:C274($al_RecNums);$t_mensajeProgreso)
	End for 
	$l_IDProgreso:=IT_Progress (-1;$l_IDProgreso)
	KRL_UnloadReadOnly (->[BBL_Lectores:72])
End if 

