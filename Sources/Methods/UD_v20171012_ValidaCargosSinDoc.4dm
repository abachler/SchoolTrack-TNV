//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Saúl Ponce
  // Fecha y hora: 12/10/17, 16:51:31
  // ----------------------------------------------------
  // Método: UD_v20171012_ValidaCargosSinDoc
  //
  // Descripción
  // En el Ticket 188310, encontramos un problema durante la emisión de cargos cuando la cuenta corriente tiene asignados descuentos por cuenta
  // y asociada a un tercero. Algunos cargos del apoderado quedaban sin id de documento de cargo. Este método pretende eliminar todos aquellos
  // cargos que quedaron como registros "basura" y que no son eliminables por la eliminación de cargos proyectados.
  //
  // Parámetros
  // No utiliza parámetros.
  // ----------------------------------------------------

TRACE:C157

C_TEXT:C284($vt_dato)
C_TIME:C306($vt_hora)
C_LONGINT:C283($z;$vl_eliminado;$p)
C_TEXT:C284($t_Encabezado;$t_descripcion;$t_UUID;$vt_nombre;$vt_ruta)


ARRAY LONGINT:C221($al_recNumCar;0)
ARRAY TEXT:C222($at_periodoCar;0)
ARRAY DATE:C224($ad_fechaCar;0)
ARRAY TEXT:C222($at_glosaCar;0)
ARRAY TEXT:C222($at_cursoCar;0)
ARRAY TEXT:C222($at_nombreAlu;0)
ARRAY TEXT:C222($at_monedaCar;0)
ARRAY TEXT:C222($ab_afectoCar;0)
ARRAY TEXT:C222($at_responsableCar;0)


$vl_eliminado:=0

$p:=IT_UThermometer (1;0;"Validando relaciones entre cargos y documentos de cargo...")
CREATE EMPTY SET:C140([ACT_Cargos:173];"$carUsar")


READ WRITE:C146([ACT_Cargos:173])
ALL RECORDS:C47([ACT_Cargos:173])
CREATE SET:C116([ACT_Cargos:173];"$allCargos")

KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")

CREATE SET:C116([ACT_Cargos:173];"$carConDoc")
DIFFERENCE:C122("$allCargos";"$carConDoc";"$carUsar")


USE SET:C118("$carUsar")
If (Records in set:C195("$carUsar")>0)
	
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
	SELECTION TO ARRAY:C260([ACT_Cargos:173];$al_recNumCar)
	For ($z;1;Size of array:C274($al_recNumCar))
		
		KRL_GotoRecord (->[ACT_Cargos:173];$al_recNumCar{$z})
		
		If (Records in selection:C76([ACT_Cargos:173])=1)
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Cargos:173]ID_CuentaCorriente:2)
			
			APPEND TO ARRAY:C911($at_periodoCar;String:C10([ACT_Cargos:173]Mes:13;"00")+String:C10([ACT_Cargos:173]Año:14;"0000"))
			APPEND TO ARRAY:C911($at_glosaCar;[ACT_Cargos:173]Glosa:12)
			$vt_dato:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]curso:20)
			APPEND TO ARRAY:C911($at_cursoCar;$vt_dato)
			$vt_dato:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]apellidos_y_nombres:40)
			APPEND TO ARRAY:C911($at_nombreAlu;$vt_dato)
			APPEND TO ARRAY:C911($at_monedaCar;[ACT_Cargos:173]Moneda:28)
			$vt_dato:="No"
			If ([ACT_Cargos:173]Monto_IVA:20>0)
				$vt_dato:="Si"
			End if 
			APPEND TO ARRAY:C911($ab_afectoCar;$vt_dato)
			If ([ACT_Cargos:173]ID_Apoderado:18#0)
				$vt_dato:=KRL_GetTextFieldData (->[Personas:7]No:1;->[ACT_Cargos:173]ID_Apoderado:18;->[Personas:7]Apellidos_y_nombres:30)
			Else 
				QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]Id:1=[ACT_Cargos:173]ID_Tercero:54)
				If ([ACT_Terceros:138]Es_empresa:2)
					$vt_dato:=[ACT_Terceros:138]Razon_Social:3
				Else 
					$vt_dato:=KRL_GetTextFieldData (->[ACT_Terceros:138]Id:1;->[ACT_Cargos:173]ID_Tercero:54;->[Personas:7]Apellidos_y_nombres:30)
				End if 
			End if 
			APPEND TO ARRAY:C911($at_responsableCar;$vt_dato)
			
			ACTcc_EliminaCargosLoop 
			
			$vl_eliminado:=($vl_eliminado+1)
		End if 
		
	End for 
	
	AT_Initialize (->$al_recNumCar)
	
End if 

SET_ClearSets ("$allCargos";"$carConDoc";"$carUsar")


ALL RECORDS:C47([ACT_Cargos:173])
CREATE SET:C116([ACT_Cargos:173];"$carTodos")

QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_Documento_de_Cargo:3=0;*)
QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!;*)
QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23=0)

CREATE SET:C116([ACT_Cargos:173];"$carNoRela")

INTERSECTION:C121("$carTodos";"$carNoRela";"$carNoRela")

USE SET:C118("$carNoRela")
If (Records in set:C195("$carNoRela")>0)
	
	SELECTION TO ARRAY:C260([ACT_Cargos:173];$al_recNumCar)
	For ($z;1;Size of array:C274($al_recNumCar))
		
		KRL_GotoRecord (->[ACT_Cargos:173];$al_recNumCar{$z})
		
		If (Records in selection:C76([ACT_Cargos:173])=1)
			
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Cargos:173]ID_CuentaCorriente:2)
			QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=[ACT_Cargos:173]ID_Documento_de_Cargo:3)
			
			If (Records in selection:C76([ACT_Documentos_de_Cargo:174])=0)
				
				APPEND TO ARRAY:C911($at_periodoCar;String:C10([ACT_Cargos:173]Mes:13;"00")+String:C10([ACT_Cargos:173]Año:14;"0000"))
				APPEND TO ARRAY:C911($at_glosaCar;[ACT_Cargos:173]Glosa:12)
				$vt_dato:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]curso:20)
				APPEND TO ARRAY:C911($at_cursoCar;$vt_dato)
				$vt_dato:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]apellidos_y_nombres:40)
				APPEND TO ARRAY:C911($at_nombreAlu;$vt_dato)
				APPEND TO ARRAY:C911($at_monedaCar;[ACT_Cargos:173]Moneda:28)
				$vt_dato:="No"
				If ([ACT_Cargos:173]Monto_IVA:20>0)
					$vt_dato:="Si"
				End if 
				APPEND TO ARRAY:C911($ab_afectoCar;$vt_dato)
				If ([ACT_Cargos:173]ID_Apoderado:18#0)
					$vt_dato:=KRL_GetTextFieldData (->[Personas:7]No:1;->[ACT_Cargos:173]ID_Apoderado:18;->[Personas:7]Apellidos_y_nombres:30)
				Else 
					QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]Id:1=[ACT_Cargos:173]ID_Tercero:54)
					If ([ACT_Terceros:138]Es_empresa:2)
						$vt_dato:=[ACT_Terceros:138]Razon_Social:3
					Else 
						$vt_dato:=KRL_GetTextFieldData (->[ACT_Terceros:138]Id:1;->[ACT_Cargos:173]ID_Tercero:54;->[Personas:7]Apellidos_y_nombres:30)
					End if 
				End if 
				APPEND TO ARRAY:C911($at_responsableCar;$vt_dato)
				ACTcc_EliminaCargosLoop 
				
				$vl_eliminado:=($vl_eliminado+1)
				
			End if 
			
		End if 
	End for 
	
	SET_ClearSets ("$carTodos";"$carNoRela")
	
End if 

KRL_UnloadReadOnly (->[ACT_Cargos:173])

IT_UThermometer (-2;$p)

If ($vl_eliminado>0)
	$p:=IT_UThermometer (1;0;"Exportando Validación de Cargos...")
	
	If (SYS_IsWindows )
		USE CHARACTER SET:C205("windows-1252";0)
	Else 
		USE CHARACTER SET:C205("MacRoman";0)
	End if 
	
	$vt_nombre:="Cargos_Eliminados_["+DTS_MakeFromDateTime +"].txt"
	$vt_ruta:=ACTabc_CreaRutaCarpetas ("Cargos"+Folder separator:K24:12)
	CREATE FOLDER:C475($vt_ruta;*)
	$vt_hora:=ACTabc_CreaArchivo ("Cargos";$vt_nombre;"Cargos")
	
	If ($vt_hora#?00:00:00?)
		
		IO_SendPacket ($vt_hora;"Periodo\tGlosa\tCurso\tNombre cuenta\tMoneda cargo\tAfecto iva\tResponsable\n")
		For ($z;1;Size of array:C274($at_periodoCar))
			IO_SendPacket ($vt_hora;$at_periodoCar{$z}+"\t"+$at_glosaCar{$z}+"\t"+$at_cursoCar{$z}+"\t"+$at_nombreAlu{$z})
			IO_SendPacket ($vt_hora;"\t"+$at_monedaCar{$z}+"\t"+$ab_afectoCar{$z}+"\t"+$at_responsableCar{$z}+"\n")
		End for 
		
		CLOSE DOCUMENT:C267($vt_hora)
		IT_UThermometer (-2;$p)
		USE CHARACTER SET:C205(*;0)
		
		$t_Encabezado:="Eliminación de cargos sin documentos de cargo relacionado."
		$t_descripcion:="Para conservar la integridad de la base de datos algunos cargos fueron eliminados,"
		$t_descripcion:=$t_descripcion+" debido a que no se encontraban relacionados a documentos de cargo."
		$t_descripcion:=$t_descripcion+"\n\n\nPodrá encontrar el detalle de los cargos eliminados en la ruta:\n\n"+vtACT_document+"."
		
		$t_UUID:=NTC_CreaMensaje ("AccountTrack";__ ("Actualización de Base de Datos");$t_Encabezado)
		NTC_Mensaje_Texto ($t_UUID;$t_descripcion)
		
	End if 
	
End if 
