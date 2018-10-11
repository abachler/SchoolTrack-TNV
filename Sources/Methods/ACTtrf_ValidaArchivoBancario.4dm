//%attributes = {}
  // Método: ACTtrf_ValidaArchivoBancario
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 07-09-10, 16:39:43
  // ---------------------------------------------
  // Descripción: 
  // se usa para validar que en v11 existan declaradas las variables $1, $2 y $3 para exportadores y $1 para importadores

  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_TEXT:C284($code;$vt_codAgregado)
C_LONGINT:C283($vl_recNum;$offset)

  // Código principal

$vl_recNum:=Record number:C243([xxACT_ArchivosBancarios:118])
READ WRITE:C146([xxACT_ArchivosBancarios:118])
GOTO RECORD:C242([xxACT_ArchivosBancarios:118];$vl_recNum)
If ([xxACT_ArchivosBancarios:118]CreadoPorAsistente:9=False:C215)
	$code:=BLOB to text:C555([xxACT_ArchivosBancarios:118]xData:2;Mac text without length:K22:10;$offset;32000)
	If ([xxACT_ArchivosBancarios:118]ImpExp:5=False:C215)
		$vt_codAgregado:="C_TEXT($1;$2;$3)"
	Else 
		$vt_codAgregado:="C_TEXT($1)"
	End if 
	If (Position:C15($vt_codAgregado;$code)>0)
		$vt_codAgregado:=""
	Else 
		$vt_codAgregado:=$vt_codAgregado+"\r\r"
	End if 
	$code:=$vt_codAgregado+$code
	SET BLOB SIZE:C606([xxACT_ArchivosBancarios:118]xData:2;0)
	TEXT TO BLOB:C554($code;[xxACT_ArchivosBancarios:118]xData:2;Mac text without length:K22:10)
	SAVE RECORD:C53([xxACT_ArchivosBancarios:118])
End if 
KRL_UnloadReadOnly (->[xxACT_ArchivosBancarios:118])
KRL_GotoRecord (->[xxACT_ArchivosBancarios:118];$vl_recNum)