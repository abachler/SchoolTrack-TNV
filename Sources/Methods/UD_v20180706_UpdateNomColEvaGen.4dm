//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Patricio Aliaga
  // Fecha y hora: 06-07-18, 16:47:30
  // ----------------------------------------------------
  // Método: UD_v20180706_UpdateNomColEvaGen
  // Descripción
  //  Metodo se encarga de redimenzionarla preferencia "PrefObj_NombreColumnasEvaluacionesGenerales" con un dato mas "PTE"
  // Parámetros
  // ----------------------------------------------------

C_LONGINT:C283($i)
C_OBJECT:C1216($ob_preferencia)
ARRAY TEXT:C222($at_propiedades;0)
  //ARRAY TEXT($al_tipoPropiedades;0)
ARRAY LONGINT:C221($al_tipoPropiedades;0)  //ASM cambio por problema de Compilación

$ob_preferencia:=PREF_fGetObject (0;"PrefObj_NombreColumnasEvaluacionesGenerales";$ob_preferencia)

If (Not:C34(OB Is defined:C1231($ob_preferencia)))  //ASM-PA 20180725 Ticket 212688
	LOC_ObjNombreColumnasEval ("iniciar")
	$ob_preferencia:=PREF_fGetObject (0;"PrefObj_NombreColumnasEvaluacionesGenerales";$ob_preferencia)
End if 

OB GET PROPERTY NAMES:C1232($ob_preferencia;$at_propiedades;$al_tipoPropiedades)
For ($i;1;Size of array:C274($at_propiedades))
	If ($at_propiedades{$i}="nombreEva")
		ARRAY TEXT:C222($at_debug;0)
		OB GET ARRAY:C1229($ob_preferencia;$at_propiedades{$i};$at_debug)
		If (Size of array:C274($at_debug)=7)
			APPEND TO ARRAY:C911($at_debug;"Promedio Transversal de Período")
		End if 
		OB SET ARRAY:C1227($ob_preferencia;$at_propiedades{$i};$at_debug)
	Else 
		C_OBJECT:C1216($ob_debug)
		ARRAY TEXT:C222($at_debug;0)
		$ob_debug:=OB Get:C1224($ob_preferencia;$at_propiedades{$i})
		OB GET ARRAY:C1229($ob_debug;"display";$at_debug)
		If (Size of array:C274($at_debug)=7)
			APPEND TO ARRAY:C911($at_debug;"PTE")
		End if 
		OB SET ARRAY:C1227($ob_debug;"display";$at_debug)
		OB SET:C1220($ob_preferencia;$at_propiedades{$i};$ob_debug)
	End if 
End for 
LOC_ObjNombreColumnasEval ("actualizar";->$ob_preferencia)