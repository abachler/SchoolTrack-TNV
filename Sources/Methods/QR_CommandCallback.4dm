//%attributes = {}
  // QR_CommandCallback()
  // Por: Alberto Bachler: 19/02/13, 16:18:41
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_LONGINT:C283($l_ancho;$l_area;$l_columna;$l_oculta;$l_valoresRepetidos;$t_comando)
C_POINTER:C301($y_Nil)
C_TEXT:C284($t_formato;$t_objeto;$t_titulo)

If (False:C215)
	C_LONGINT:C283(QR_CommandCallback )
	C_LONGINT:C283(QR_CommandCallback )
End if 

$l_area:=$1
$t_comando:=$2

Case of 
	: ($t_comando=qr cmd open:K14900:19)
		QR_OpenReport 
		
		
	: ($t_comando=qr cmd save:K14900:20)
		QR_SaveReport 
		
		
	: ($t_comando=qr cmd save as:K14900:21)
		QR_SaveReportAs 
		
		
	: ($t_comando=qr cmd add column:K14900:45)
		If (USR_GetUserID =-111111)
			vt_formula:=""
			WDW_OpenFormWindow ($y_Nil;"EditorFormulas";7;8)
			DIALOG:C40("EditorFormulas")
			CLOSE WINDOW:C154
		Else 
			QR EXECUTE COMMAND:C791($l_area;$t_comando)
		End if 
		
	: ($t_comando=qr cmd edit column:K14900:40)
		If (USR_GetUserID =-111111)
			$l_columna:=QR Get drop column:C747($l_area)
			QR GET INFO COLUMN:C766($l_area;$l_columna;$t_titulo;$t_objeto;$l_oculta;$l_ancho;$l_valoresRepetidos;$t_formato)
			vt_formula:=$t_objeto
			WDW_OpenFormWindow ($y_Nil;"EditorFormulas";7;8)
			DIALOG:C40("EditorFormulas")
			CLOSE WINDOW:C154
		Else 
			QR EXECUTE COMMAND:C791($l_area;$t_comando)
		End if 
		
	Else 
		QR EXECUTE COMMAND:C791($l_area;$t_comando)
End case 