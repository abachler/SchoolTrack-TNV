//%attributes = {}
  // QR_SetUnivers()
  // Por: Alberto Bachler: 06/03/13, 06:09:43
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($0)
C_LONGINT:C283($l_buscarEnSeleccion;$l_numeroTablaPrincipal;$l_numeroTablaRelacionada)
C_POINTER:C301($y_campoPrincipal;$y_campoRelacionado)
C_TEXT:C284($t_metodoBusqueda;$t_TablaPrincipal;$t_tablaRelacionada)

If (False:C215)
	C_LONGINT:C283(QR_SetUnivers ;$1)
	C_LONGINT:C283(QR_SetUnivers ;$2)
	C_LONGINT:C283(QR_SetUnivers ;$0)
End if 

$l_numeroTablaPrincipal:=$1
$l_numeroTablaRelacionada:=$2

If (($l_numeroTablaPrincipal#$l_numeroTablaRelacionada) & ($l_numeroTablaRelacionada#0))
	$t_TablaPrincipal:=XSvs_nombreTablaLocal_Numero ($l_numeroTablaPrincipal)
	$t_tablaRelacionada:=XSvs_nombreTablaLocal_Numero ($l_numeroTablaRelacionada)
	READ ONLY:C145([xShell_Tables_RelatedFiles:243])
	QUERY:C277([xShell_Tables_RelatedFiles:243];[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11;=;$l_numeroTablaPrincipal;*)
	QUERY:C277([xShell_Tables_RelatedFiles:243]; & ;[xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroTabla:1=$l_numeroTablaRelacionada)
	
	If (Records in selection:C76([xShell_Tables_RelatedFiles:243])=0)
		If ([xShell_Reports:54]ExecuteBeforePrinting:4="")
			CD_Dlog (0;Replace string:C233(Replace string:C233(__ ("Los registros de ^1 no tienen relación con la selección de ^0.\r\rPara imprimir un informe desde ^1 es necesario establecer proceduralmente una relación entre ^0 y ^1.")+__ ("\r")+__ ("\rDespués de guardar el informe abra el cuadro de diálogo Propiedades del informe y en la zona Ejecutar antes de imprimir ingrese los comandos que permiten establecer dicha relación.");__ ("^0");$t_TablaPrincipal);__ ("^1");$t_tablaRelacionada))
		End if 
		$0:=1
	Else 
		$t_metodoBusqueda:=[xShell_Tables_RelatedFiles:243]MetodoBusqueda:7
		$y_campoPrincipal:=Field:C253($l_numeroTablaPrincipal;[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroCampo:3)
		$y_campoRelacionado:=Field:C253($l_numeroTablaRelacionada;[xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroCampo:4)
		KRL_RelateSelection ($y_campoRelacionado;$y_campoPrincipal)
		
		If (BLOB size:C605([xShell_Reports:54]AssociatedQuery:21)#0)
			vyQRY_TablePointer:=Table:C252($l_numeroTablaRelacionada)
			$l_buscarEnSeleccion:=1
			QR_ExecQuery (vyQRY_TablePointer;$l_buscarEnSeleccion)
		Else 
			Case of 
				: (($t_metodoBusqueda="Search Editor") | ($t_metodoBusqueda="SearchEditor"))
					vyQRY_TablePointer:=Table:C252($l_numeroTablaRelacionada)
					If (Records in selection:C76(vyQRY_TablePointer->)=0)
						CREATE SET:C116(vyQRY_TablePointer->;"start")
						QRY_QueryEditor 
						CREATE SET:C116(vyQRY_TablePointer->;"found")
						INTERSECTION:C121("start";"found";"found")
						USE SET:C118("found")
						SET_ClearSets ("start";"found";"found")
					End if 
				Else 
					dhQR_SetUnivers ($t_metodoBusqueda;$l_numeroTablaRelacionada)
			End case 
		End if 
		
		Case of 
			: ([xShell_Reports:54]NoRequiereSeleccion:40)
				$0:=OK
			: ((Records in selection:C76(Table:C252($l_numeroTablaRelacionada)->)>0) & (ok=1))
				$0:=OK
			: ((Records in selection:C76(Table:C252($l_numeroTablaRelacionada)->)=0) & (ok=1))
				  //$0:=1
				  //cambio debido a que si no existen registros no se debe ingresar al reporte
				$0:=0
				CD_Dlog (0;__ ("No hay nada para imprimir."))
			Else 
				$0:=0
		End case 
	End if 
Else 
	If (BLOB size:C605([xShell_Reports:54]AssociatedQuery:21)#0)
		vyQRY_TablePointer:=Table:C252($l_numeroTablaPrincipal)
		QR_ExecQuery (vyQRY_TablePointer)
		If (Records in selection:C76(vyQRY_TablePointer->)>0)
			$0:=1
		Else 
			$0:=0
		End if 
	End if 
	$0:=1
End if 