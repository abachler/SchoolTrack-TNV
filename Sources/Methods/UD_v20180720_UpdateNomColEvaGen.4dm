//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Daniel Ledezma
  // ----------------------------------------------------
  // Método: UD_v20180720_UpdateNomColEvaGen
  // Descripción
  //  Se encarga de agregar a la preferencia "PrefObj_NombreColumnasEvaluacionesGenerales" el dato para personalizar la columna bonificación
  // ----------------------------------------------------

C_LONGINT:C283($i)
C_OBJECT:C1216($ob_preferencia)
ARRAY TEXT:C222($at_propiedades;0)
ARRAY LONGINT:C221($al_tipoPropiedades;0)
$ob_preferencia:=PREF_fGetObject (0;"PrefObj_NombreColumnasEvaluacionesGenerales";$ob_preferencia)
OB GET PROPERTY NAMES:C1232($ob_preferencia;$at_propiedades;$al_tipoPropiedades)
For ($i;1;Size of array:C274($at_propiedades))
	If ($at_propiedades{$i}="nombreEva")
		ARRAY TEXT:C222($at_debug;0)
		OB GET ARRAY:C1229($ob_preferencia;$at_propiedades{$i};$at_debug)
		APPEND TO ARRAY:C911($at_debug;"Bonificación")
		OB SET ARRAY:C1227($ob_preferencia;$at_propiedades{$i};$at_debug)
	Else 
		C_OBJECT:C1216($ob_debug)
		ARRAY TEXT:C222($at_debug;0)
		$ob_debug:=OB Get:C1224($ob_preferencia;$at_propiedades{$i})
		OB GET ARRAY:C1229($ob_debug;"display";$at_debug)
		APPEND TO ARRAY:C911($at_debug;"Bonificación")
		OB SET ARRAY:C1227($ob_debug;"display";$at_debug)
		OB SET:C1220($ob_preferencia;$at_propiedades{$i};$ob_debug)
	End if 
End for 
LOC_ObjNombreColumnasEval ("actualizar";->$ob_preferencia)