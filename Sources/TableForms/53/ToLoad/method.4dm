  // [xShell_Queries].ToLoad()
  // 
  //
  // creado por: Alberto Bachler Klein: 17-03-16, 16:28:05
  // -----------------------------------------------------------
C_LONGINT:C283($l_recNum)
C_POINTER:C301($y_consultasNombre;$y_consultasNumero)

Case of 
	: (Form event:C388=On Load:K2:1)
		$y_consultasNombre:=OBJECT Get pointer:C1124(Object named:K67:5;"consultas_nombre")
		$y_consultasNumero:=OBJECT Get pointer:C1124(Object named:K67:5;"consultas_recNum")
		QUERY:C277([xShell_Queries:53];[xShell_Queries:53]FileNo:5=Table:C252(vyQRY_TablePointer))
		SELECTION TO ARRAY:C260([xShell_Queries:53]Name:2;$y_consultasNombre->;[xShell_Queries:53];$y_consultasNumero->)
		SORT ARRAY:C229($y_consultasNombre->;$y_consultasNumero->;>)
		If (Size of array:C274($y_consultasNombre->)>0)
			$y_consultasNombre->:=1
			$l_recNum:=$y_consultasNumero->{$y_consultasNombre->}
			KRL_GotoRecord (->[xShell_Queries:53];$l_recNum)
		End if 
		OBJECT SET ENABLED:C1123(*;"cargar";$y_consultasNumero->>0)
		OBJECT SET ENABLED:C1123(*;"eliminar";$y_consultasNumero->>0)
		  //WDW_SlideDrawer (Current form table;"ToLoad")
		
		
	: (Form event:C388=On Deactivate:K2:10)
End case 

