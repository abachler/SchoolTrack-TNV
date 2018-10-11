//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Saul Ponce Ticket Nº 177176
  // Fecha y hora: 17-05-17, 11:58:53
  // ----------------------------------------------------
  // Método: AL_InactivaRegistroRelacionados
  // Descripción: Inactiva la familia y las relaciones familiares del alumno que se está retirando.
  // 
  //
  // Parámetros
  // $1 de tipo texto, accion a realizar.
  // $2 de tipo longint, el número de la familia.
  // 
  // Retorno
  // $0 de tipo boolean, utilizado en las tarea bash para determinar si la tarea se completó y eliminar el registro.
  // ----------------------------------------------------


C_TEXT:C284($vt_accion;$vt_nombre;$vt_accionBash;$vt_texto)
C_BOOLEAN:C305($vb_retorno)
C_LONGINT:C283($vl_famNumero;$z;$vl_numero)
ARRAY LONGINT:C221($al_recNumRelaciones;0)

$vt_accion:=$1

If (Count parameters:C259>=2)
	If (Not:C34($vt_accion="ProcesaBash"))
		$vl_famNumero:=$2
		  //Else 
		  //$vt_texto:=$2->
	End if 
End if 

$vb_retorno:=False:C215

Case of 
	: ($vt_accion="InactivaFamilia")
		
		READ WRITE:C146([Familia:78])
		QUERY:C277([Familia:78];[Familia:78]Numero:1=$vl_famNumero)
		If (Not:C34(Locked:C147([Familia:78])))
			$vt_nombre:=[Familia:78]Nombre_de_la_familia:3
			[Familia:78]Inactiva:31:=True:C214
			SAVE RECORD:C53([Familia:78])
			LOG_RegisterEvt ("Inactivación de la Familia "+$vt_nombre+" (id "+String:C10($vl_famNumero)+"), debido a que no se encontraron alumnos relacionados con estatus Activo.")
			$vb_retorno:=True:C214
		Else 
			BM_CreateRequest ("AL_InactivaRegistroRelacionados";$vt_accion+"."+String:C10($vl_famNumero))
		End if 
		
		
	: ($vt_accion="InactivaPersonasRelacionadas")
		
		C_LONGINT:C283($vl_numPersona)
		C_BOOLEAN:C305($vb_inactivar)
		ARRAY LONGINT:C221($al_personas;0)
		ARRAY LONGINT:C221($al_numFamilias;0)
		
		$vb_inactivar:=False:C215
		
		QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=$vl_famNumero)
		SELECTION TO ARRAY:C260([Familia_RelacionesFamiliares:77]ID_Persona:3;$al_personas)
		
		For ($z;1;Size of array:C274($al_personas))
			
			$vl_numPersona:=$al_personas{$z}
			
			  // busco relaciones familiares de la persona, que no estén en la familia
			QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=$al_personas{$z};*)
			QUERY:C277([Familia_RelacionesFamiliares:77]; & ;[Familia_RelacionesFamiliares:77]ID_Familia:2#$vl_famNumero)
			
			If (Records in selection:C76([Familia_RelacionesFamiliares:77])=0)
				  // la persona NO pertenece a otra familia
				AL_InactivaRegistroRelacionados ("InactivaRelacion";$vl_numPersona)
			Else 
				  // la persona pertenece a otra(s) familia(s), validar el status de los alumnos de esa(s) otra(s) familia(s)
				DISTINCT VALUES:C339([Familia_RelacionesFamiliares:77]ID_Familia:2;$al_numFamilias)
				
				For ($y;1;Size of array:C274($al_numFamilias))
					
					  // desde la familia busco los alumnos
					QUERY:C277([Alumnos:2];[Alumnos:2]Familia_Número:24=$al_numFamilias{$y})
					QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50="activo")
					
					  // si no hay alumnos con estado activo, marco inactivar en true, pero sigo revisando las demás familias
					If (Records in selection:C76([Alumnos:2])=0)
						$vb_inactivar:=True:C214
					Else 
						  // si hay alumnos, marco inactivar en false, y salgo del ciclo porque ya está asociado otra familia con alumnos activos
						If (Records in selection:C76([Alumnos:2])>0)
							$vb_inactivar:=False:C215
							$y:=Size of array:C274($al_numFamilias)
						End if 
					End if 
				End for 
				
				  // dependiendo del resultado de verificación de las familias
				If ($vb_inactivar)
					AL_InactivaRegistroRelacionados ("InactivaRelacion";$vl_numPersona)
				End if 
			End if 
			
		End for 
		
	: ($vt_accion="InactivaRelacion")
		
		C_LONGINT:C283($vl_persona)
		$vl_persona:=$2
		
		READ WRITE:C146([Personas:7])
		QUERY:C277([Personas:7];[Personas:7]No:1=$vl_persona)
		If (Not:C34(Locked:C147([Personas:7])))
			$vt_nombre:=[Personas:7]Apellidos_y_nombres:30
			[Personas:7]Inactivo:46:=True:C214
			SAVE RECORD:C53([Personas:7])
			LOG_RegisterEvt ("Inactivación de la Relación Familiar "+$vt_nombre+" (id "+String:C10($vl_persona)+"), debido a que no se encontraron alumnos relacionados con estatus Activo.")
			$vb_retorno:=True:C214
		Else 
			BM_CreateRequest ("AL_InactivaRegistroRelacionados";$vt_accion+"."+String:C10($vl_persona))
		End if 
		
		
	: ($vt_accion="ProcesaBash")
		
		$vt_accionBash:=ST_GetWord ($vt_texto;1;".")
		$vl_numero:=Num:C11(ST_GetWord ($vt_texto;2;"."))
		$vb_retorno:=AL_InactivaRegistroRelacionados ($vt_accionBash;$vl_numero)
		
End case 

$0:=$vb_retorno