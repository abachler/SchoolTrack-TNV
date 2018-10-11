//%attributes = {}
  // BBLusr_PrestamosTransacciones()
  // Por: Alberto Bachler: 16/11/13, 17:47:11
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


  //historial de préstamos
AL_UpdateArrays (xALP_Prestamos;0)
READ ONLY:C145([BBL_Prestamos:60])
QUERY:C277([BBL_Prestamos:60];[BBL_Prestamos:60]Número_de_lector:2=[BBL_Lectores:72]ID:1)
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
SELECTION TO ARRAY:C260([BBL_Prestamos:60]Desde:3;adBBL_PrestamosDesde;[BBL_Prestamos:60]Hasta:4;$adMustRetournOn;[BBL_Prestamos:60]Fecha_de_devolución:5;$adReturnDate;[BBL_Prestamos:60]Duración:6;aiBBL_PrestamosDuracion;[BBL_Prestamos:60]Días_de_atraso:15;alBBL_PrestamosAtraso;[BBL_Items:61]Clasificacion:2;atBBL_PrestamosCallNumber;[BBL_Items:61]Primer_título:4;atBBL_PrestamosTitulo;[BBL_Items:61]Primer_autor:6;atBBL_PrestamosAutor;[BBL_Registros:66]Barcode_SinFormato:26;atBBL_PrestamosBarcode)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
AL_UpdateArrays (xALP_Prestamos;-2)
ALP_SetDefaultAppareance (xALP_Prestamos)

  // Modificado por: Saúl Ponce (28-12-2016) Ticket Nº 168701
  // Igualar los cálculos a como están en BBLitm_LeePrestamos()

  //For ($i;1;Size of array(adBBL_PrestamosDesde))
  //If ($adReturnDate{$i}=!00-00-00!)
  //aiBBL_PrestamosDuracion{$I}:=Current date(*)-adBBL_PrestamosDesde{$i}+1
  //If (Current date(*)>$adMustRetournOn{$i})
  //  //alBBL_PrestamosAtraso{$I}:=DT_GetWorkingDays ($adMustRetournOn{$i}+1;Current date(*))
  //alBBL_PrestamosAtraso{$I}:=DT_GetWorkingDays ($adMustRetournOn{$i};Current date(*))-1  //20140609 ASM para dejar el mismo calculo que en el metodo BBLitm_LeePrestamos (linea 48)
  //AL_SetRowStyle (xALP_Prestamos;$i;5)
  //Else 
  //AL_SetRowStyle (xALP_Prestamos;$i;1)
  //End if 
  //End if 
  //End for 

For ($i;1;Size of array:C274(adBBL_PrestamosDesde))
	If ($adReturnDate{$i}=!00-00-00!)
		aiBBL_PrestamosDuracion{$i}:=(Current date:C33(*)-adBBL_PrestamosDesde{$i})+1
		AL_SetRowStyle (xALP_Prestamos;$i;5)
	Else 
		aiBBL_PrestamosDuracion{$i}:=$adReturnDate{$i}-adBBL_PrestamosDesde{$i}+1
	End if 
	If ($adReturnDate{$i}>$adMustRetournOn{$i})
		alBBL_PrestamosAtraso{$i}:=DT_GetWorkingDays ($adMustRetournOn{$i};$adReturnDate{$i})-1
	Else 
		If ($adReturnDate{$i}=!00-00-00!) & ($adMustRetournOn{$i}>Current date:C33(*))
			alBBL_PrestamosAtraso{$i}:=DT_GetWorkingDays ($adMustRetournOn{$i};Current date:C33(*))-1
			AL_SetRowStyle (xALP_Prestamos;$i;1)
		Else 
			alBBL_PrestamosAtraso{$i}:=0
		End if 
	End if 
	If ($adReturnDate{$i}=!00-00-00!) & ($adMustRetournOn{$i}<Current date:C33(*))
		alBBL_PrestamosAtraso{$i}:=DT_GetWorkingDays ($adMustRetournOn{$i};Current date:C33(*))-1
	Else 
		alBBL_PrestamosAtraso{$i}:=0
	End if 
End for 

AL_UpdateArrays (xALP_Prestamos;-2)
AL_SetSort (xALP_Prestamos;-4)

  // transacciones
AL_UpdateArrays (xALP_Transacciones;0)
READ ONLY:C145([BBL_Transacciones:59])
QUERY:C277([BBL_Transacciones:59];[BBL_Transacciones:59]ID_User:4=[BBL_Lectores:72]ID:1)
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
SELECTION TO ARRAY:C260([BBL_Transacciones:59]Fecha:3;adBBL_TransaccionesFecha;[BBL_Transacciones:59]Glosa:6;atBBL_TransaccionesGlosa;[BBL_Transacciones:59]Monto:2;arBBL_TransaccionesMonto)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
AL_UpdateArrays (xALP_Transacciones;-2)
AL_SetSort (xALP_Transacciones;-1)
ALP_SetDefaultAppareance (xALP_Transacciones)


