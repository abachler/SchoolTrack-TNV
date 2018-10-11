//%attributes = {}
  //ACTpgs_CargaDatosAdicionales
C_LONGINT:C283($vl_numTabla)
C_TEXT:C284($vt_accion;$1)
$vt_accion:=$1
Case of 
	: ($vt_accion="DeclaraVars")
		ACTpgs_CargaDatosAdicionales ("ArraysProt")
		ACTpgs_CargaDatosAdicionales ("ArraysObs")
		ACTpgs_CargaDatosAdicionales ("ArraysST")
		ACTpgs_CargaDatosAdicionales ("Contadores")
		
	: ($vt_accion="ArraysProt")
		ARRAY DATE:C224(adACT_FechaPagoProt;0)
		ARRAY DATE:C224(adACT_FechaDctoProt;0)
		ARRAY TEXT:C222(atACT_EstadoProt;0)
		ARRAY TEXT:C222(atACT_MotivoProt;0)
		ARRAY TEXT:C222(atACT_ColoresProt;0)
		
	: ($vt_accion="ArraysObs")
		ARRAY TEXT:C222(atACT_TipoObs;0)
		ARRAY DATE:C224(adACT_FechaObs;0)
		ARRAY TEXT:C222(atACT_Obs;0)
		ARRAY TEXT:C222(atACT_ColorObs;0)
		
	: ($vt_accion="ArraysST")
		ARRAY TEXT:C222(atACT_NombresAl;0)
		ARRAY TEXT:C222(atACT_ObsAl;0)
		ARRAY TEXT:C222(atACT_ColorAl;0)
		
	: ($vt_accion="Contadores")
		C_LONGINT:C283(vl_protVig;vl_protTot;vl_TotalCartera;vl_ObsAp;vl_ObsCta;vl_TotalObs;vl_Promovidos;vl_Repitentes;vl_Condicionales)
		vl_protVig:=0
		vl_protTot:=0
		vl_TotalCartera:=0
		vl_ObsAp:=0
		vl_ObsCta:=0
		vl_TotalObs:=0
		vl_Promovidos:=0
		vl_Repitentes:=0
		vl_Condicionales:=0
		
	: ($vt_accion="UpdateArrays0")
		AL_UpdateArrays (xALP_Documentos;0)
		AL_UpdateArrays (xALP_Obs;0)
		AL_UpdateArrays (xALP_DatosAcad;0)
		
	: ($vt_accion="UpdateArrays2")
		AL_UpdateArrays (xALP_Documentos;-2)
		AL_UpdateArrays (xALP_Obs;-2)
		AL_UpdateArrays (xALP_DatosAcad;-2)
		
	: ($vt_accion="SetColor")
		For ($i;1;Size of array:C274(atACT_ColoresProt))
			AL_SetRowColor (xALP_Documentos;$i;atACT_ColoresProt{$i};0)
		End for 
		For ($i;1;Size of array:C274(atACT_ColorObs))
			AL_SetRowColor (xALP_Obs;$i;atACT_ColorObs{$i};0)
		End for 
		For ($i;1;Size of array:C274(atACT_ColorAl))
			AL_SetRowColor (xALP_DatosAcad;$i;atACT_ColorAl{$i};0)
		End for 
		
	: ($vt_accion="CargaDatos")
		ACTpgs_CargaDatosAdicionales ("ArraysProt")
		ACTpgs_CargaDatosAdicionales ("ArraysObs")
		ACTpgs_CargaDatosAdicionales ("ArraysST")
		ACTpgs_CargaDatosAdicionales ("Contadores")
		
		ACTpgs_CargaDatosAdicionales ("UpdateArrays0")
		ACTpgs_CargaDatosAdicionales ("CargaProt")
		ACTpgs_CargaDatosAdicionales ("CargaObs")
		ACTpgs_CargaDatosAdicionales ("CargaST")
		ACTpgs_CargaDatosAdicionales ("UpdateArrays2")
		ACTpgs_CargaDatosAdicionales ("SetColor")
		
		AL_SetLine (xALP_Documentos;0)
		AL_SetLine (xALP_Obs;0)
		AL_SetLine (xALP_DatosAcad;0)
		REDRAW WINDOW:C456
		
	: ($vt_accion="CargaProt")
		ARRAY LONGINT:C221($al_recNumDoc;0)
		READ ONLY:C145([ACT_Documentos_en_Cartera:182])
		If (btn_apdo=1)
			QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]ID_Apoderado:2=[Personas:7]No:1)
		Else 
			QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]ID_Tercero:18=[ACT_Terceros:138]Id:1)
		End if 
		SELECTION TO ARRAY:C260([ACT_Documentos_en_Cartera:182]Fecha_Doc:5;adACT_FechaDctoProt;[ACT_Documentos_en_Cartera:182]Estado:9;atACT_EstadoProt;[ACT_Documentos_en_Cartera:182]MotivoProtesto:16;atACT_MotivoProt;[ACT_Documentos_en_Cartera:182];$al_recNumDoc)
		For ($i;1;Size of array:C274($al_recNumDoc))
			GOTO RECORD:C242([ACT_Documentos_en_Cartera:182];$al_recNumDoc{$i})
			APPEND TO ARRAY:C911(adACT_FechaPagoProt;KRL_GetDateFieldData (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;->[ACT_Documentos_de_Pago:176]FechaPago:4))
			APPEND TO ARRAY:C911(atACT_ColoresProt;"blue")
			If ([ACT_Documentos_en_Cartera:182]Ch_Protestadoel:11#!00-00-00!)
				vl_protTot:=vl_protTot+1
				If (Not:C34([ACT_Documentos_en_Cartera:182]Reemplazado:14))
					vl_protVig:=vl_protVig+1
					atACT_ColoresProt{Size of array:C274(atACT_ColoresProt)}:="red"
				End if 
			End if 
			If (Not:C34([ACT_Documentos_en_Cartera:182]Reemplazado:14))
				vl_TotalCartera:=vl_TotalCartera+1
			End if 
		End for 
		
	: ($vt_accion="CargaObs")
		ARRAY LONGINT:C221($al_recNumsObs;0)
		C_TEXT:C284($vt_tipo)
		READ ONLY:C145([ACT_CuentasCorrientes:175])
		vl_ObsAp:=0
		vl_ObsCta:=0
		vl_TotalObs:=0
		$vt_tipo:="Cuenta"
		$vt_color:="blue"
		QUERY WITH ARRAY:C644([ACT_CuentasCorrientes:175]ID_Alumno:3;alACT_IdsAlumnos)
		KRL_RelateSelection (->[ACT_Cuentas_Observaciones:102]ID_Registro:2;->[ACT_CuentasCorrientes:175]ID:1;"")
		QUERY SELECTION:C341([ACT_Cuentas_Observaciones:102];[ACT_Cuentas_Observaciones:102]Numero_Tabla_Asoc:10=Table:C252(->[ACT_CuentasCorrientes:175]))
		SELECTION TO ARRAY:C260([ACT_Cuentas_Observaciones:102]Fecha:3;adACT_FechaObs;[ACT_Cuentas_Observaciones:102]Observacion:4;atACT_Obs)
		AT_RedimArrays (Size of array:C274(adACT_FechaObs);->atACT_TipoObs;->atACT_ColorObs)
		AT_Populate (->atACT_TipoObs;->$vt_tipo)
		AT_Populate (->atACT_ColorObs;->$vt_color)
		vl_ObsCta:=Size of array:C274(atACT_TipoObs)
		
		If (btn_apdo=1)
			$vl_numTabla:=Table:C252(->[Personas:7])
			$vl_id_registro:=[Personas:7]No:1
			ACTobs_OpcionesObservaciones ("CargaRegistros";->$vl_numTabla;->$vl_id_registro)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Pagares:184];$al_recNumsObs;"")
			For ($i;1;Size of array:C274($al_recNumsObs))
				GOTO RECORD:C242([ACT_Pagares:184];$al_recNumsObs{$i})
				APPEND TO ARRAY:C911(atACT_TipoObs;"Apoderado")
				APPEND TO ARRAY:C911(adACT_FechaObs;[ACT_Pagares:184]unused3:3)
				APPEND TO ARRAY:C911(atACT_Obs;[ACT_Pagares:184]unused4:4)
				APPEND TO ARRAY:C911(atACT_ColorObs;"blue")
			End for 
		End if 
		vl_ObsAp:=Size of array:C274($al_recNumsObs)
		vl_TotalObs:=vl_ObsCta+vl_ObsAp
		AT_MultiLevelSort ("<>>";->adACT_FechaObs;->atACT_TipoObs;->atACT_Obs;->atACT_ColorObs)
		
	: ($vt_accion="CargaST")
		C_TEXT:C284($key)
		C_BOOLEAN:C305($condicionalidadActivada)
		C_DATE:C307($condicionalidadHasta)
		C_TEXT:C284($condicionalidadMotivo)
		
		READ ONLY:C145([Alumnos:2])
		vl_Promovidos:=0
		vl_Repitentes:=0
		vl_Condicionales:=0
		For ($i;1;Size of array:C274(alACT_IdsAlumnos))
			$vt_condicional:="."
			$index:=Find in field:C653([Alumnos:2]numero:1;alACT_IdsAlumnos{$i})
			If ($index#-1)
				GOTO RECORD:C242([Alumnos:2];$index)
				APPEND TO ARRAY:C911(atACT_ColorAl;"")
				APPEND TO ARRAY:C911(atACT_NombresAl;[Alumnos:2]apellidos_y_nombres:40)
				$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Alumnos:2]nivel_numero:29)+"."+String:C10([Alumnos:2]numero:1)
				AL_LeeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]Condicionalidad_Activada:57;->$condicionalidadActivada)
				AL_LeeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]Condicionalidad_Hasta:58;->$condicionalidadHasta)
				AL_LeeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]Condicionalidad_Motivo:59;->$condicionalidadMotivo)
				If ($condicionalidadActivada)
					atACT_ColorAl{Size of array:C274(atACT_ColorAl)}:="red"
					$vt_condicional:=$vt_condicional+"\r"+"Alumno condicional hasta: "+String:C10($condicionalidadHasta)+"."+"\r"+"Motivo condicionalidad: "+$condicionalidadMotivo+"."
					vl_Condicionales:=vl_Condicionales+1
				End if 
				Case of 
					: ([Alumnos:2]Situacion_final:33="P")
						If (atACT_ColorAl{Size of array:C274(atACT_ColorAl)}="")
							atACT_ColorAl{Size of array:C274(atACT_ColorAl)}:="blue"
						End if 
						APPEND TO ARRAY:C911(atACT_ObsAl;"Situación final: "+ST_Qte ([Alumnos:2]Situacion_final:33)+$vt_condicional)
						vl_Promovidos:=vl_Promovidos+1
					: ([Alumnos:2]Situacion_final:33="R")
						atACT_ColorAl{Size of array:C274(atACT_ColorAl)}:="red"
						APPEND TO ARRAY:C911(atACT_ObsAl;"Situación final: "+ST_Qte ([Alumnos:2]Situacion_final:33)+$vt_condicional)
						vl_Repitentes:=vl_Repitentes+1
					Else 
						APPEND TO ARRAY:C911(atACT_ObsAl;"Alumno sin situación final definida al día de hoy"+$vt_condicional)
				End case 
			End if 
		End for 
		
End case 