//%attributes = {}
  // BBLdbu_RebuildStatistics()
  // Por: Alberto Bachler: 15/11/13, 16:38:10
  //  ---------------------------------------------
  //  ---------------------------------------------
_O_C_INTEGER:C282($i_registros)
C_LONGINT:C283($l_proceso;$l_registros)
C_DATE:C307($d_InicioPrestamoSiguiente)
ARRAY DATE:C224($ad_fechaDevolucion;0)
ARRAY DATE:C224($ad_fechaUltimoPrestamo;0)
ARRAY DATE:C224($ad_PrestadoDesde;0)
ARRAY DATE:C224($ad_PrestadoHasta;0)
ARRAY INTEGER:C220($ai_diasAtraso;0)
ARRAY INTEGER:C220($ai_duracionPrestamo;0)
ARRAY INTEGER:C220($ai_NumeroPrestamos;0)
ARRAY LONGINT:C221($al_recNums;0)
BBL_LeeConfiguracion 
MESSAGES OFF:C175
If (False:C215)
	  // este código puede haber servido para corregir un error que hacía que las devoluciones no quedaran registradas
	  // marca como devueltos todos los registros que tenían prestamos posteriores a un prestamo sin devolucion
	  // (asumiendo que un registro no puede ser presatdo si no ha sido devuelto anteriormente)
	QUERY:C277([BBL_Prestamos:60];[BBL_Prestamos:60]Fecha_de_devolución:5=!00-00-00!)
	KRL_RelateSelection (->[BBL_Registros:66]ID:3;->[BBL_Prestamos:60]Número_de_registro:1;"")
	SELECTION TO ARRAY:C260([BBL_Registros:66];$al_recNums)
	For ($i_registros;1;Size of array:C274($al_recNums))
		READ WRITE:C146([BBL_Prestamos:60])
		GOTO RECORD:C242([BBL_Registros:66];$al_recNums{$i_registros})
		QUERY:C277([BBL_Prestamos:60];[BBL_Prestamos:60]Número_de_registro:1=[BBL_Registros:66]ID:3;*)
		QUERY:C277([BBL_Prestamos:60]; & [BBL_Prestamos:60]Fecha_de_devolución:5=!00-00-00!)
		If (Records in selection:C76([BBL_Prestamos:60])>1)
			ORDER BY:C49([BBL_Prestamos:60];[BBL_Prestamos:60]Fecha_de_devolución:5;<)
			$d_InicioPrestamoSiguiente:=[BBL_Prestamos:60]Desde:3-1
			NEXT RECORD:C51([BBL_Prestamos:60])
			While (Not:C34(End selection:C36([BBL_Prestamos:60])))
				If ($d_InicioPrestamoSiguiente<[BBL_Prestamos:60]Hasta:4)
					[BBL_Prestamos:60]Fecha_de_devolución:5:=$d_InicioPrestamoSiguiente
				Else 
					[BBL_Prestamos:60]Fecha_de_devolución:5:=[BBL_Prestamos:60]Hasta:4
				End if 
				$d_InicioPrestamoSiguiente:=[BBL_Prestamos:60]Desde:3-1
				SAVE RECORD:C53([BBL_Prestamos:60])
				NEXT RECORD:C51([BBL_Prestamos:60])
			End while 
		End if 
	End for 
End if 
  // Calculo de la duración de préstamos
ALL RECORDS:C47([BBL_Prestamos:60])
SELECTION TO ARRAY:C260([BBL_Prestamos:60]Duración:6;$ai_duracionPrestamo;[BBL_Prestamos:60]Desde:3;$ad_PrestadoDesde;[BBL_Prestamos:60]Días_de_atraso:15;$ai_diasAtraso;[BBL_Prestamos:60]Hasta:4;$ad_PrestadoHasta;[BBL_Prestamos:60]Fecha_de_devolución:5;$ad_fechaDevolucion)
$l_proceso:=IT_Progress (1;0;0;__ ("Calculando la duración de préstamos…"))
For ($i_registros;1;Size of array:C274($ai_duracionPrestamo))
	If ($ad_fechaDevolucion{$i_registros}#!00-00-00!)
		$ai_duracionPrestamo{$i_registros}:=$ad_fechaDevolucion{$i_registros}-$ad_PrestadoDesde{$i_registros}+1
		  // Modificado por: Saúl Ponce (28-12-2016) Ticket Nº 168701
		  // Cuando la copia tiene fecha de devolución no se deben calcular los días de atraso
		  //If ($ad_fechaDevolucion{$i_registros}>$ad_PrestadoHasta{$i_registros})
		  //$ai_diasAtraso{$i_registros}:=DT_GetWorkingDays ($ad_PrestadoHasta{$i_registros};$ad_fechaDevolucion{$i_registros})
		  //Else 
		$ai_diasAtraso{$i_registros}:=0
		  //End if 
	Else 
		If (Current date:C33(*)>$ad_PrestadoHasta{$i_registros})
			$ai_duracionPrestamo{$i_registros}:=Current date:C33(*)-$ad_PrestadoDesde{$i_registros}+1
			$ai_diasAtraso{$i_registros}:=DT_GetWorkingDays ($ad_PrestadoHasta{$i_registros}+1;Current date:C33(*))
		Else 
			$ai_diasAtraso{$i_registros}:=0
		End if 
	End if 
	$l_proceso:=IT_Progress (0;$l_proceso;$i_registros/Size of array:C274($ai_duracionPrestamo))
End for 
READ WRITE:C146([BBL_Prestamos:60])
ARRAY TO SELECTION:C261($ai_duracionPrestamo;[BBL_Prestamos:60]Duración:6;$ai_diasAtraso;[BBL_Prestamos:60]Días_de_atraso:15)
$l_proceso:=IT_Progress (-1;$l_proceso)
ALL RECORDS:C47([BBL_Lectores:72])
SELECTION TO ARRAY:C260([BBL_Lectores:72];$al_recNums)
$l_proceso:=IT_Progress (1;0;0;__ ("Reconstruyendo estadísticas para lectores…"))
For ($i_registros;1;Size of array:C274($al_recNums))
	KRL_GotoRecord (->[BBL_Lectores:72];$al_recNums{$i_registros};True:C214)
	  //total de prestamos registrados
	QUERY:C277([BBL_Prestamos:60];[BBL_Prestamos:60]Número_de_lector:2=[BBL_Lectores:72]ID:1)
	CREATE SET:C116([BBL_Prestamos:60];"PRESTAMOS")
	[BBL_Lectores:72]Total_de_préstamos:8:=Records in selection:C76([BBL_Prestamos:60])
	  //último uso
	ORDER BY:C49([BBL_Prestamos:60];[BBL_Prestamos:60]Desde:3;<)
	FIRST RECORD:C50([BBL_Prestamos:60])
	[BBL_Lectores:72]Ultimo_préstamo:20:=[BBL_Prestamos:60]Desde:3
	  //prestamos vigentes en este momento
	USE SET:C118("PRESTAMOS")
	QUERY SELECTION:C341([BBL_Prestamos:60];[BBL_Prestamos:60]Fecha_de_devolución:5=!00-00-00!)
	[BBL_Lectores:72]Préstamos_actuales:9:=Records in selection:C76([BBL_Prestamos:60])
	  //devoluciones atrasadas
	QUERY SELECTION:C341([BBL_Prestamos:60];[BBL_Prestamos:60]Hasta:4<Current date:C33(*))
	[BBL_Lectores:72]Atrasos:24:=Records in selection:C76([BBL_Prestamos:60])
	If ((Current date:C33(*)>[BBL_Lectores:72]Fecha_Suspención:45) & ([BBL_Lectores:72]Fecha_Suspención:45#!00-00-00!))
		[BBL_Lectores:72]Fecha_Suspención:45:=!00-00-00!
	End if 
	SAVE RECORD:C53([BBL_Lectores:72])
	$l_proceso:=IT_Progress (0;$l_proceso;$i_registros/Size of array:C274($al_RecNums))
End for 
$l_proceso:=IT_Progress (-1;$l_proceso)
ALL RECORDS:C47([BBL_Registros:66])
SELECTION TO ARRAY:C260([BBL_Registros:66];$al_recNums)
$l_proceso:=IT_Progress (1;0;0;__ ("Reconstruyendo estadísticas para registros…"))
For ($i_registros;1;Size of array:C274($al_recNums))
	KRL_GotoRecord (->[BBL_Registros:66];$al_recNums{$i_registros};True:C214)
	If ([BBL_Registros:66]StatusID:34=Prestado)
		[BBL_Registros:66]StatusID:34:=Disponible
	End if 
	QUERY:C277([BBL_Prestamos:60];[BBL_Prestamos:60]Número_de_registro:1=[BBL_Registros:66]ID:3)
	CREATE SET:C116([BBL_Prestamos:60];"PRESTAMOS")
	[BBL_Registros:66]Número_de_préstamos:22:=Records in selection:C76([BBL_Prestamos:60])
	SELECTION TO ARRAY:C260([BBL_Prestamos:60]Duración:6;$ai_duracionPrestamo;[BBL_Prestamos:60]Desde:3;$ad_fechaUltimoPrestamo)
	SORT ARRAY:C229($ad_PrestadoDesde;<)
	If (Size of array:C274($ai_duracionPrestamo)>0)
		[BBL_Registros:66]Días_en_prestamo:23:=AT_GetSumArray (->$ai_duracionPrestamo)
		[BBL_Registros:66]Ultimo_préstamo:21:=$ad_PrestadoDesde{1}
		USE SET:C118("PRESTAMOS")
		CLEAR SET:C117("PRESTAMOS")
		QUERY SELECTION:C341([BBL_Prestamos:60];[BBL_Prestamos:60]Fecha_de_devolución:5=!00-00-00!)
		ORDER BY:C49([BBL_Prestamos:60];[BBL_Prestamos:60]Hasta:4;<)
		If (Records in selection:C76([BBL_Prestamos:60])>0)
			Case of 
				: ([BBL_Prestamos:60]Número_de_lector:2=-1)
					[BBL_Registros:66]StatusID:34:=Perdido
					[BBL_Registros:66]Prestado_hasta:14:=!00-00-00!
				: ([BBL_Prestamos:60]Número_de_lector:2=-2)
					[BBL_Registros:66]StatusID:34:=Dado de baja
					[BBL_Registros:66]Prestado_hasta:14:=!00-00-00!
				: ([BBL_Prestamos:60]Número_de_lector:2=-3)
					[BBL_Registros:66]StatusID:34:=Uso Interno
				: ([BBL_Prestamos:60]Número_de_lector:2=-4)
					[BBL_Registros:66]StatusID:34:=En Reparacion
				: ([BBL_Prestamos:60]Número_de_lector:2=-5)
					[BBL_Registros:66]StatusID:34:=Pedido
				: ([BBL_Prestamos:60]Número_de_lector:2=-6)
					[BBL_Registros:66]StatusID:34:=Archivado
					[BBL_Prestamos:60]Hasta:4:=!00-00-00!
				Else 
					[BBL_Registros:66]StatusID:34:=Prestado
					QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]ID:1=[BBL_Prestamos:60]Número_de_lector:2)
					[BBL_Registros:66]Ultimo_lector:18:=[BBL_Lectores:72]NombreCompleto:3
			End case 
		End if 
	Else 
		[BBL_Registros:66]StatusID:34:=Disponible
	End if 
	$l_elemento:=Find in array:C230(<>aCpyStatusId;[BBL_Registros:66]StatusID:34)
	If ($l_elemento>0)
		[BBL_Registros:66]Status:10:=<>aCpyStatus{$l_elemento}
	End if 
	SAVE RECORD:C53([BBL_Registros:66])
	$l_proceso:=IT_Progress (0;$l_proceso;$i_registros/Size of array:C274($al_RecNums))
End for 
$l_proceso:=IT_Progress (-1;$l_proceso)
ALL RECORDS:C47([BBL_Items:61])
SELECTION TO ARRAY:C260([BBL_Items:61];$al_recNums)
$l_proceso:=IT_Progress (1;0;0;__ ("Reconstruyendo estadísticas de uso para items…"))
For ($i_registros;1;Size of array:C274($al_recNums))
	KRL_GotoRecord (->[BBL_Items:61];$al_recNums{$i_registros};True:C214)
	QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Número_de_item:1=[BBL_Items:61]Numero:1)
	SELECTION TO ARRAY:C260([BBL_Registros:66]Número_de_préstamos:22;$ai_NumeroPrestamos;[BBL_Registros:66]Días_en_prestamo:23;$ai_duracionPrestamo;[BBL_Items:61]Fecha_ultimo_prestamo:42;$ad_fechaUltimoPrestamo)
	KRL_GotoRecord (->[BBL_Items:61];$al_recNums{$i_registros};True:C214)
	SORT ARRAY:C229($ad_fechaUltimoPrestamo;<)
	If (Size of array:C274($ai_NumeroPrestamos)>0)
		[BBL_Items:61]Use_number:40:=AT_GetSumArray (->$ai_NumeroPrestamos)
		[BBL_Items:61]Días_de_utilización:39:=AT_GetSumArray (->$ai_duracionPrestamo)
		[BBL_Items:61]Fecha_ultimo_prestamo:42:=$ad_fechaUltimoPrestamo{1}
	End if 
	[BBL_Items:61]Copias:24:=Records in selection:C76([BBL_Registros:66])
	SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registros)
	QUERY SELECTION:C341([BBL_Registros:66];[BBL_Registros:66]StatusID:34=Disponible)
	[BBL_Items:61]Copias_disponibles:43:=$l_registros
	QUERY SELECTION:C341([BBL_Registros:66];[BBL_Registros:66]StatusID:34=Reservado)
	[BBL_Items:61]Copias_reservadas:44:=$l_registros
	SET QUERY DESTINATION:C396(0)
	SAVE RECORD:C53([BBL_Items:61])
	$l_proceso:=IT_Progress (0;$l_proceso;$i_registros/Size of array:C274($al_RecNums))
End for 
$l_proceso:=IT_Progress (-1;$l_proceso)
KRL_UnloadReadOnly (->[BBL_Items:61])
KRL_UnloadReadOnly (->[BBL_Registros:66])
KRL_UnloadReadOnly (->[BBL_Lectores:72])
KRL_UnloadReadOnly (->[BBL_Prestamos:60])