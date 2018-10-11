//%attributes = {}
  // Método: 4D_GetMethodTextByID
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 20/01/10, 10:07:35
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_TEXT:C284($0;$vt_MethodText;$vt_LineText)
C_LONGINT:C283($1;$vl_MethodID;$vl_ResID;$vl_Error;$vl_Offset)
C_LONGINT:C283($vl_MethodSize;$vl_LineSize;$vl_LogicalLineSize;$vl_LineNum)
C_BLOB:C604($vx_Resource;$vx_LineTokens)
$vl_ResID:=$1
$vt_MethodText:=""

  // Código principal
$vl_Error:=API Get Resource ("CC4D";$vl_ResID;$vx_Resource)
If ($vl_Error=0)
	$vl_MethodSize:=BLOB size:C605($vx_Resource)-13
	$vl_Offset:=10
	$vl_LineNum:=0  // just for fun
	$vt_MethodText:=""
	
	While ($vl_Offset<$vl_MethodSize)
		$vl_LineNum:=$vl_LineNum+1
		$vl_LineSize:=BLOB to integer:C549($vx_Resource;Native byte ordering:K22:1;$vl_Offset)
		$vl_Offset:=$vl_Offset+2
		$vl_LogicalLineSize:=BLOB to integer:C549($vx_Resource;Native byte ordering:K22:1;$vl_Offset)
		$vl_Offset:=$vl_Offset-4
		COPY BLOB:C558($vx_Resource;$vx_LineTokens;$vl_Offset;0;$vl_LineSize)
		$vl_Offset:=$vl_Offset+$vl_LineSize
		
		Case of 
			: ($vl_LogicalLineSize<2)
				$vt_MethodText:=$vt_MethodText+Char:C90(Carriage return:K15:38)
			Else 
				$vl_Error:=API Detokenize ($vx_LineTokens;$vt_LineText)
				If ($vl_Error#0)
					$vl_Offset:=$vl_MethodSize  // bail out on error
				Else 
					$vt_MethodText:=$vt_MethodText+$vt_LineText+Char:C90(Carriage return:K15:38)
				End if 
		End case 
	End while 
End if 
$0:=$vt_MethodText

