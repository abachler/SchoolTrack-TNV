
If (alProEvt=-5)
	C_LONGINT:C283($i)
	For ($i;1;Size of array:C274(al_Orden))
		al_Orden{$i}:=$i
	End for 
	  //ABC192542
	  //Cuando es año historico se pueden mover las asignaturas en el form, por ende solo para estos casos reasigno arreglo de subsector y nunmero de columna
	  //Para que sea almacenado el orden.
	If (<>aYears{<>aYears}#<>gYear)
		ARRAY TEXT:C222(atActas_Subsectores;0)
		ARRAY INTEGER:C220(alActas_ColumnNumber;0)
		For ($i;1;Size of array:C274(atActas_SubsectoresCertif))
			APPEND TO ARRAY:C911(alActas_ColumnNumber;$i)
			APPEND TO ARRAY:C911(atActas_Subsectores;atActas_SubsectoresCertif{$i})
		End for 
	End if 
	AL_SetSort (Self:C308->;4)
	AL_SetLine (Self:C308->;0)
	AL_UpdateArrays (Self:C308->;-2)
	vModif:=True:C214
End if 
