  // Método: Método de Formulario: [SN3_PublicationPrefs]PublicationExtras
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 07/02/10, 18:32:28
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
Case of 
	: (Form event:C388=On Load:K2:1)
		$where:=Find in array:C230(aERefs;vRefExtraPublication)
		$leftOriginal:=aELefts{$where}
		$topOriginal:=aETops{$where}
		$objectNames:=aEObjectNames{$where}
		$moveLeft:=15-$leftOriginal
		$moveTop:=37-$topOriginal
		OBJECT MOVE:C664(*;$objectNames+"@";$moveLeft;$moveTop)
		Case of 
			: (vRefExtraPublication="Anotaciones")
				cb_PublicarAnotObs1:=cb_PublicarAnotObs
				cb_PublicarAnotAutor1:=cb_PublicarAnotAutor
				cb_PublicarAMailProf1:=cb_PublicarAMailProf
				IT_SetButtonState ((cb_PublicarAnotAutor1=1);->cb_PublicarAMailProf1)
			: (vRefExtraPublication="Suspensiones")
				cb_PublicarSuspObs1:=cb_PublicarSuspObs
				cb_PublicarSuspProfesor1:=cb_PublicarSuspProfesor
				cb_PublicarSMailProf1:=cb_PublicarSMailProf
				IT_SetButtonState ((cb_PublicarSuspProfesor1=1);->cb_PublicarSMailProf1)
			: (vRefExtraPublication="Castigos")
				cb_PublicarCastigosObs1:=cb_PublicarCastigosObs
				cb_PublicarCastigosProfesor1:=cb_PublicarCastigosProfesor
				cb_PublicarCMailProf1:=cb_PublicarCMailProf
				IT_SetButtonState ((cb_PublicarCastigosProfesor1=1);->cb_PublicarCMailProf1)
			: (vRefExtraPublication="Atrasos")
				cb_PublicarAtrasosObs1:=cb_PublicarAtrasosObs
				cb_PublicarAtrasosInter1:=cb_PublicarAtrasosInter
			: (vRefExtraPublication="Calificaciones")
				cb_PublicarEEsfuerzo1:=cb_PublicarEEsfuerzo
				cb_PublicarEParciales1:=cb_PublicarEParciales
				cb_PublicarECP1:=cb_PublicarECP
				cb_PublicarEPP1:=cb_PublicarEPP
				cb_PublicarEPA1:=cb_PublicarEPA
				cb_PublicarEExamen1:=cb_PublicarEExamen
				cb_PublicarEEXX1:=cb_PublicarEEXX
				cb_PublicarENF1:=cb_PublicarENF
				cb_MostrarDetalle1:=cb_MostrarDetalle
				cb_PublicarEPonderacion1:=cb_PublicarEPonderacion
				cb_OcultaParcialesMadre1:=cb_OcultaParcialesMadre
				cb_HijasDesplegadas1:=cb_HijasDesplegadas
				IT_SetButtonState ((cb_MostrarDetalle1=1);->cb_PublicarEPonderacion1;->cb_OcultaParcialesMadre1;->cb_HijasDesplegadas1)
		End case 
End case 



