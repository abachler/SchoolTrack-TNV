//%attributes = {}
  // BBLreg_RegenerarCodigosDeBarra()
  // Por: Alberto Bachler: 17/09/13, 13:31:15
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283($i_registros)
C_LONGINT:C283($l_IDProgreso)
C_TEXT:C284($t_mensajeProgreso)
C_BOOLEAN:C305($b_RegenerarProtegidos)
ARRAY LONGINT:C221($al_RecNums;0)

If (Count parameters:C259=1)
	$b_RegenerarProtegidos:=$1
End if 

LONGINT ARRAY FROM SELECTION:C647([BBL_Registros:66];$al_RecNums;"")
If (Size of array:C274($al_RecNums)>0)
	$l_IDProgreso:=IT_Progress (1;0;0;__ ("Generando nuevos códigos de barra..."))
	For ($i_registros;1;Size of array:C274($al_RecNums))
		READ WRITE:C146([BBL_Registros:66])
		GOTO RECORD:C242([BBL_Registros:66];$al_RecNums{$i_registros})
		If ($b_RegenerarProtegidos)
			[BBL_Registros:66]Barcode_Protegido:28:=False:C215
		End if 
		If (Not:C34([BBL_Registros:66]Barcode_Protegido:28))
			[BBL_Registros:66]Código_de_barra:20:=""
		End if 
		BBLreg_GeneraCodigoBarra 
		SAVE RECORD:C53([BBL_Registros:66])
		$l_IDProgreso:=IT_Progress (0;$l_IDProgreso;$i_registros/Size of array:C274($al_RecNums);$t_mensajeProgreso)
	End for 
	$l_IDProgreso:=IT_Progress (-1;$l_IDProgreso)
	KRL_UnloadReadOnly (->[BBL_Registros:66])
End if 

