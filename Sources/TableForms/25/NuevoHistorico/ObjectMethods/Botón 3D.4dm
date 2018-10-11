  // Método: Método de Objeto: STR_NuevoHistorico.Botón 3D
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 30/06/10, 06:14:03
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal

If ((vl_NivelSeleccionado#0) & (vl_Year>0))
	QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4;=;-[Alumnos:2]numero:1)
	SELECTION TO ARRAY:C260([Alumnos_SintesisAnual:210]NumeroNivel:6;$aNivelesExistentes;[Alumnos_SintesisAnual:210]Promovido:91;$aPromovidos)
	SORT ARRAY:C229($aNivelesExistentes;$aPromovidos)
	
	If (Size of array:C274($aNivelesExistentes)>0)
		$nivelPrimerHistorico:=$aNivelesExistentes{1}
		$offsetNivelSelecionado:=$nivelPrimerHistorico-vl_NivelSeleccionado
	Else 
		If (vl_NivelSeleccionado>0)
			$offsetNivelSelecionado:=[Alumnos:2]nivel_numero:29-vl_NivelSeleccionado
		Else 
			$offsetNivelSelecionado:=vl_NivelSeleccionado-[Alumnos:2]nivel_numero:29
		End if 
		  //If (vl_NivelSeleccionado<0)
		  //$offsetNivelSelecionado:=$offsetNivelSelecionado-1
	End if 
	
	CREATE RECORD:C68([Alumnos_SintesisAnual:210])
	[Alumnos_SintesisAnual:210]ID_Institucion:1:=0
	[Alumnos_SintesisAnual:210]ID_Alumno:4:=-[Alumnos:2]numero:1
	[Alumnos_SintesisAnual:210]ID:267:=SQ_SeqNumber (->[Alumnos_SintesisAnual:210]ID:267)
	[Alumnos_SintesisAnual:210]Año:2:=vl_Year
	[Alumnos_SintesisAnual:210]NumeroNivel:6:=vl_NivelSeleccionado
	
	If ($offsetNivelSelecionado=0)
		[Alumnos_SintesisAnual:210]Promovido:91:=False:C215
		[Alumnos_SintesisAnual:210]SituacionFinal:8:="R"
	Else 
		[Alumnos_SintesisAnual:210]Promovido:91:=True:C214
		[Alumnos_SintesisAnual:210]SituacionFinal:8:="P"
	End if 
	
	If (([Alumnos_SintesisAnual:210]Promovido:91))
		Case of 
			: (<>vtXS_CountryCode="pe")
				[Alumnos_SintesisAnual:210]SituacionFinal:8:="A"
				
			: ((<>vtXS_CountryCode="cl") | (<>vtXS_CountryCode="co") | (<>vtXS_CountryCode="ve") | (<>vtXS_CountryCode="ar"))
				[Alumnos_SintesisAnual:210]SituacionFinal:8:="P"
				
			Else 
				[Alumnos_SintesisAnual:210]SituacionFinal:8:="P"
				
		End case 
		
	Else 
		
		Case of 
			: (<>vtXS_CountryCode="pe")
				[Alumnos_SintesisAnual:210]SituacionFinal:8:="D"
				
			: ((<>vtXS_CountryCode="cl") | (<>vtXS_CountryCode="co") | (<>vtXS_CountryCode="ve") | (<>vtXS_CountryCode="ar"))
				[Alumnos_SintesisAnual:210]SituacionFinal:8:="R"
				
			Else 
				[Alumnos_SintesisAnual:210]SituacionFinal:8:="R"
				
		End case 
		
		
	End if 
	
	SAVE RECORD:C53([Alumnos_SintesisAnual:210])
	$vt_llave:=[Alumnos_SintesisAnual:210]LlavePrincipal:5
	KRL_ReloadAsReadOnly (->[Alumnos_SintesisAnual:210])
	STRal_CreaHistorico ($vt_llave)
	ACCEPT:C269
End if 



