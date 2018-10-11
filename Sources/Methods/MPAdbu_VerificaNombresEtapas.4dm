//%attributes = {}
  // MÉTODO: MPAdbu_VerificaNombresEtapas
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 01/10/12, 11:19:18
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // Verifica los nombres de las etapas en las Areas de Aprendizaje
  // Asigna nombres únicos a etapas sin nombbre o con nombres duplicados
  // ----------------------------------------------------
_O_C_INTEGER:C282($i_etapas)
C_TEXT:C284($t_contenidoTexto;$t_descripcion;$t_Encabezado;$t_errorDuplicacion;$t_mensajeExito;$t_mensajeFalla;$t_uuid)

ARRAY LONGINT:C221($al_colores;0)
ARRAY LONGINT:C221($al_estilos;0)
ARRAY TEXT:C222($at_Areas;0)
ARRAY TEXT:C222($at_Errores;0)
ARRAY TEXT:C222($at_TitulosColumnas;0)



  // Código
ARRAY LONGINT:C221(al_RecNumsAreas;0)
ARRAY TEXT:C222(at_etapasUnicas;0)

ARRAY TEXT:C222(atMPA_EtapasArea;0)
ARRAY LONGINT:C221(alMPA_NivelDesde;0)
ARRAY LONGINT:C221(alMPA_NivelHasta;0)
ALL RECORDS:C47([MPA_DefinicionAreas:186])
LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionAreas:186];al_RecNumsAreas;"")

For ($i;1;Size of array:C274(al_RecNumsAreas))
	READ WRITE:C146([MPA_DefinicionAreas:186])
	GOTO RECORD:C242([MPA_DefinicionAreas:186];al_RecNumsAreas{$i})
	BLOB_Blob2Vars (->[MPA_DefinicionAreas:186]xEtapas:10;0;->atMPA_EtapasArea;->alMPA_NivelDesde;->alMPA_NivelHasta)
	
	For ($i_etapas;1;Size of array:C274(atMPA_EtapasArea))
		If (atMPA_EtapasArea{$i_etapas}="")
			atMPA_EtapasArea{$i_etapas}:="Etapa "+String:C10($i_etapas)+" ("+String:C10(alMPA_NivelDesde{$i_etapas})+"º a "+String:C10(alMPA_NivelDesde{$i_etapas})+"º)"
			$t_errorDuplicacion:="Etapa sin nombre. Se le asignó el nombre: "+"\""+atMPA_EtapasArea{$i_etapas}+"\""
			APPEND TO ARRAY:C911($at_Areas;[MPA_DefinicionAreas:186]AreaAsignatura:4)
			APPEND TO ARRAY:C911($at_Errores;$t_errorDuplicacion)
			APPEND TO ARRAY:C911($al_estilos;0)
			APPEND TO ARRAY:C911($al_colores;Green:K11:9)
			BLOB_Variables2Blob (->[MPA_DefinicionAreas:186]xEtapas:10;0;->atMPA_EtapasArea;->alMPA_NivelDesde;->alMPA_NivelHasta)
			SAVE RECORD:C53([MPA_DefinicionAreas:186])
		End if 
	End for 
	
	COPY ARRAY:C226(atMPA_EtapasArea;at_etapasUnicas)
	AT_DistinctsArrayValues (->at_etapasUnicas)
	If (Size of array:C274(atMPA_EtapasArea)#Size of array:C274(at_etapasUnicas))
		For ($i_etapas;1;Size of array:C274(atMPA_EtapasArea))
			If (alMPA_NivelDesde{$i_etapas}=alMPA_NivelHasta{$i_etapas})
				atMPA_EtapasArea{$i_etapas}:=atMPA_EtapasArea{$i_etapas}+" ("+String:C10(alMPA_NivelDesde{$i_etapas})+"º)"
				$t_errorDuplicacion:="Etapa con nombre duplicado. Se le asignó el nombre: "+"\""+atMPA_EtapasArea{$i_etapas}+"\""
			Else 
				atMPA_EtapasArea{$i_etapas}:=atMPA_EtapasArea{$i_etapas}+" ("+String:C10(alMPA_NivelDesde{$i_etapas})+"º a "+String:C10(alMPA_NivelDesde{$i_etapas})+"º)"
				$t_errorDuplicacion:="Etapa con nombre duplicado. Se le asignó el nombre: "+"\""+atMPA_EtapasArea{$i_etapas}+"\""
			End if 
			
			If ($t_errorDuplicacion#"")
				APPEND TO ARRAY:C911($at_Areas;[MPA_DefinicionAreas:186]AreaAsignatura:4)
				APPEND TO ARRAY:C911($at_Errores;$t_errorDuplicacion)
				APPEND TO ARRAY:C911($al_estilos;0)
				APPEND TO ARRAY:C911($al_colores;Green:K11:9)
				BLOB_Variables2Blob (->[MPA_DefinicionAreas:186]xEtapas:10;0;->atMPA_EtapasArea;->alMPA_NivelDesde;->alMPA_NivelHasta)
				SAVE RECORD:C53([MPA_DefinicionAreas:186])
			End if 
		End for 
		
	End if 
End for 
KRL_UnloadReadOnly (->[MPA_DefinicionAreas:186])

If (Size of array:C274($at_Errores)>0)
	$t_Encabezado:="Verificación de los nombres de etapas en las Áreas de Aprendizaje"
	$t_descripcion:="Se detectaron etapas sin nombre o con nombres duplicados en la configuración de Areas de Aprendizajes. Los nombres de las etapas fueron modificados para que sean únicos en el área.\r"
	$t_descripcion:=$t_descripcion+"La lista a continuación contiene el detalle de las áreas modificadas."
	$t_contenidoTexto:=""
	
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Advertencia o Error")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Area")
	$t_mensajeFalla:="Se detectaron posibles inconsistencias en la configuración de mapas de aprendizaje.\r\rEl detalle será mostrado en el centro de notificaciones."
	$t_mensajeExito:="No se detectó ninguna inconsistencia en la configuración de mapas de aprendizaje."
	$t_uuid:=NTC_CreaMensaje ("SchoolTrack";$t_Encabezado;$t_descripcion)
	NTC_Mensaje_Arreglos ($t_uuid;->$at_TitulosColumnas;->$at_errores;->$at_Areas)
	NTC_Mensaje_EstilosColores ($t_uuid;->$al_estilos;->$al_Colores)
	NTC_Mensaje_MetodoAsociado ($t_uuid;Current method name:C684;$t_mensajeFalla;$t_mensajeExito)
	$0:=-1
Else 
	$0:=0
End if 
