//%attributes = {}
  // BBLci_RegistraDevolucion()
  // Por: Alberto Bachler: 08/11/13, 18:20:44
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$d_fecha:=Current date:C33(*)
Case of 
	: (Count parameters:C259=2)
		$l_recNum_Prestamo:=$1
		$d_fecha:=$2
	: (Count parameters:C259=1)
		$l_recNum_Prestamo:=$1
	Else 
		$l_recNum_Prestamo:=Record number:C243([BBL_Prestamos:60])
End case 

KRL_GotoRecord (->[BBL_Prestamos:60];$l_recNum_Prestamo;True:C214)
If (Record number:C243([BBL_Lectores:72])=No current record:K29:2)
	KRL_FindAndLoadRecordByIndex (->[BBL_Lectores:72]ID:1;->[BBL_Prestamos:60]Número_de_lector:2;True:C214)
End if 
If (Record number:C243([BBL_Registros:66])=No current record:K29:2)
	KRL_FindAndLoadRecordByIndex (->[BBL_Registros:66]ID:3;->[BBL_Prestamos:60]Número_de_registro:1;True:C214)
End if 

If (OK=1)
	[BBL_Prestamos:60]Devolución_registrada_por:10:=<>lUSR_CurrentUserID
	[BBL_Prestamos:60]Fecha_de_devolución:5:=Current date:C33(*)
	[BBL_Prestamos:60]Duración:6:=[BBL_Prestamos:60]Fecha_de_devolución:5-[BBL_Prestamos:60]Desde:3+1
	If ([BBL_Prestamos:60]Hasta:4<[BBL_Prestamos:60]Fecha_de_devolución:5)
		  // Modificado por: Saúl Ponce (28-12-2016) Ticket N° 168701. Al tener una fecha de devolución, no se deben calcular los días de atraso.
		  //MONO: descomento esta linea por que el caso está resuelto en SN3_SendPrestamosXML con respecto a los dias de atraso, ademas si quedan en 0 aquí en el llamado que hay de BBLci_Devolucion no se activan las multas.
		[BBL_Prestamos:60]Días_de_atraso:15:=DT_GetWorkingDays ([BBL_Prestamos:60]Hasta:4;[BBL_Prestamos:60]Fecha_de_devolución:5)-1
		  //[BBL_Prestamos]Días_de_atraso:=0
	End if 
	  // almaceno el registro de préstamo
	SAVE RECORD:C53([BBL_Prestamos:60])
	
	  // marco el registro como disponible y almaceno fecha de devolución prevista e incremento el total de dias en prestamo en el registro
	[BBL_Registros:66]StatusID:34:=Disponible
	[BBL_Registros:66]Fecha_de_devolución:15:=[BBL_Prestamos:60]Fecha_de_devolución:5
	[BBL_Registros:66]Días_en_prestamo:23:=[BBL_Registros:66]Días_en_prestamo:23+[BBL_Prestamos:60]Duración:6
	SAVE RECORD:C53([BBL_Registros:66])
	
	  // actualizo el registro del item con la información de la devolución
	[BBL_Items:61]Copias_disponibles:43:=[BBL_Items:61]Copias_disponibles:43+1
	SAVE RECORD:C53([BBL_Items:61])
	
	  //actualizo el registro del lector  con la información de la devolución
	[BBL_Lectores:72]Préstamos_actuales:9:=[BBL_Lectores:72]Préstamos_actuales:9-1
	If ([BBL_Prestamos:60]Hasta:4<Current date:C33(*))
		If ([BBL_Lectores:72]Atrasos:24>0)
			[BBL_Lectores:72]Atrasos:24:=[BBL_Lectores:72]Atrasos:24-1
		End if 
	End if 
	SAVE RECORD:C53([BBL_Lectores:72])
End if 


$t_lector:=[BBL_Lectores:72]BarCode_SinFormato:38+" "+[BBL_Lectores:72]NombreCompleto:3
$t_registro:=[BBL_Registros:66]Código_de_barra:20+" "+[BBL_Items:61]Primer_título:4+" (c. "+String:C10([BBL_Registros:66]Número_de_copia:2)+")"
Case of 
	: ([BBL_Lectores:72]ID:1>0)
		$t_glosa:="devuelto el "+String:C10(Current date:C33;Internal date abbreviated:K1:6)
		BBLci_registroEnLog (Devolucion;Record number:C243([BBL_Lectores:72]);Record number:C243([BBL_Registros:66]);Record number:C243([BBL_Items:61]);$t_glosa)
	: ([BBL_Lectores:72]ID:1<0)
		$r_multa:=0
		BBLci_registroEnLog (Cambio De Estado;-1;Record number:C243([BBL_Registros:66]);Record number:C243([BBL_Items:61]);__ ("Disponible"))
End case 
