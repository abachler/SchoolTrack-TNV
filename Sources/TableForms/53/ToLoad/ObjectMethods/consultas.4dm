  // [xShell_Queries].ToLoad.Variable1()
  //
  //
  // creado por: Alberto Bachler Klein: 17-03-16, 16:29:18
  // -----------------------------------------------------------
C_LONGINT:C283($l_recNum;$l_ignorar)
C_POINTER:C301($y_consultasNombre;$y_consultasNumero)

$y_consultasNombre:=OBJECT Get pointer:C1124(Object named:K67:5;"consultas_nombre")
$y_consultasNumero:=OBJECT Get pointer:C1124(Object named:K67:5;"consultas_recNum")

If ($y_consultasNumero->>0)
	If (Form event:C388=On Double Clicked:K2:5)
		$l_recNum:=$y_consultasNumero->{$y_consultasNumero->}
		KRL_GotoRecord (->[xShell_Queries:53];$l_recNum)
		If (OK=0)
			$l_ignorar:=CD_Dlog (1;__ (""))
		Else 
			ACCEPT:C269
		End if 
	Else 
		$l_recNum:=$y_consultasNumero->{$y_consultasNumero->}
		KRL_GotoRecord (->[xShell_Queries:53];$l_recNum)
		If (OK=0)
			$l_ignorar:=CD_Dlog (1;__ ("No se encontro la consulta."))
			$y_consultasNumero->:=0
		End if 
	End if 
End if 

OBJECT SET ENABLED:C1123(*;"eliminar";$y_consultasNumero->>0)
OBJECT SET ENABLED:C1123(*;"cargar";$y_consultasNumero->>0)