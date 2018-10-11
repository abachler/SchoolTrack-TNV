//%attributes = {}
  //SN3_SendPrestamosXML

  //`======
  // Modified by: abachler (5/2/10)
vb_ConstantesModificadas:=True:C214
  //`======


C_BOOLEAN:C305($1;$2;$todos;$useArrays)
C_TIME:C306($refXMLDoc)
C_LONGINT:C283($l_diasAtraso)

$todos:=True:C214
$useArrays:=False:C215
Case of 
	: (Count parameters:C259=1)
		$todos:=$1
	: (Count parameters:C259=2)
		$todos:=$1
		$useArrays:=$2
End case 

$currentErrorHandler:=SN3_SetErrorHandler ("set")

SN3_BuildSelections (SN3_DTi_Prestamos;$todos;$useArrays)
If (Records in selection:C76([BBL_Prestamos:60])>0)
	PERIODOS_LoadData (0;-2)
	
	ARRAY LONGINT:C221($arrayLong;0)
	ARRAY LONGINT:C221($recNums;0)
	SELECTION TO ARRAY:C260([BBL_Prestamos:60];$recNums;[BBL_Prestamos:60]Número_de_Transacción:8;$arrayLong)
	
	$size:=Size of array:C274($recNums)
	
	$vt_FileName:=SN3_CreateFile2Send ("crear";"";SN3_MT_Prestamos;"sax";->$refXMLDoc)
	SN3_BuildFileHeader ($refXMLDoc;SN3_MT_Prestamos;"prestamos";$todos;$useArrays)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($size)+__ (" registros de préstamos en biblioteca..."))
	For ($indice;1;$size)
		KRL_GotoRecord (->[BBL_Prestamos:60];$recNums{$indice};False:C215)
		SAX_CreateNode ($refXMLDoc;"prestamo")
		QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]ID:1=[BBL_Prestamos:60]Número_de_lector:2)
		QUERY:C277([BBL_Items:61];[BBL_Items:61]Numero:1=[BBL_Prestamos:60]Número_de_Item:11)
		SAX_CreateNode ($refXMLDoc;"id";True:C214;String:C10([BBL_Prestamos:60]Número_de_Transacción:8))
		SAX_CreateNode ($refXMLDoc;"idalumno";True:C214;String:C10([BBL_Lectores:72]Número_de_alumno:6))
		SAX_CreateNode ($refXMLDoc;"idpersona";True:C214;String:C10([BBL_Lectores:72]Número_de_Persona:31))
		SAX_CreateNode ($refXMLDoc;"titulo";True:C214;[BBL_Items:61]Primer_título:4;True:C214)
		SAX_CreateNode ($refXMLDoc;"autor";True:C214;[BBL_Items:61]Primer_autor:6;True:C214)
		SAX_CreateNode ($refXMLDoc;"desde";True:C214;SN3_MakeDateInmune2LocalFormat ([BBL_Prestamos:60]Desde:3))
		SAX_CreateNode ($refXMLDoc;"hasta";True:C214;SN3_MakeDateInmune2LocalFormat ([BBL_Prestamos:60]Hasta:4))
		SAX_CreateNode ($refXMLDoc;"devolucion";True:C214;SN3_MakeDateInmune2LocalFormat ([BBL_Prestamos:60]Fecha_de_devolución:5))
		
		  // Modificado por: Saúl Ponce (28-12-2016) Ticket N° 168701.
		  // SAX_CreateNode ($refXMLDoc;"diasdeatraso";True;String([BBL_Prestamos]Días_de_atraso)) // así se armaba el XML antes de modificar 
		
		  // Los días de atraso en la tabla podían no estar actualizados o con cantidades erróneas.
		  // Igualé la manera de determinar los días de atraso basado en el método: BBLitm_LeePrestamos()
		  // la declaración de $l_diasAtraso, está al iniciar...
		
		If ([BBL_Prestamos:60]Fecha_de_devolución:5>[BBL_Prestamos:60]Hasta:4)
			$l_diasAtraso:=DT_GetWorkingDays ([BBL_Prestamos:60]Hasta:4;[BBL_Prestamos:60]Fecha_de_devolución:5)-1
		Else 
			If ([BBL_Prestamos:60]Fecha_de_devolución:5=!00-00-00!) & ([BBL_Prestamos:60]Hasta:4>Current date:C33(*))
				$l_diasAtraso:=DT_GetWorkingDays ([BBL_Prestamos:60]Hasta:4;Current date:C33(*))-1
			Else 
				$l_diasAtraso:=0
			End if 
		End if 
		If ([BBL_Prestamos:60]Fecha_de_devolución:5=!00-00-00!) & ([BBL_Prestamos:60]Hasta:4<Current date:C33(*))
			$l_diasAtraso:=DT_GetWorkingDays ([BBL_Prestamos:60]Hasta:4;Current date:C33(*))-1
		Else 
			$l_diasAtraso:=0
		End if 
		
		SAX_CreateNode ($refXMLDoc;"diasdeatraso";True:C214;String:C10($l_diasAtraso))
		
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size)
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
	If (Error=0)
		SN3_ManejaReferencias ("eliminar";SN3_MT_Prestamos;0;SNT_Accion_Actualizar;->$arrayLong)
		SN3_RegisterLogEntry (SN3_Log_FileGeneration;"Generación del documento con "+String:C10($size)+" registros de préstamos en biblioteca.")
	Else 
		SN3_RegisterLogEntry (SN3_Log_Error;"El documento con registros de préstamos en biblioteca no pudo ser generado.";Error)
	End if 
End if 

SN3_SetErrorHandler ("clear";$currentErrorHandler)

