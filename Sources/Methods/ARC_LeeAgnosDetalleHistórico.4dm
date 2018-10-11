//%attributes = {}
  //ARC_LeeAgnosDetalleHistórico

  //verificando si existen registros historicos para páginas de conducta

READ ONLY:C145([Alumnos_SintesisAnual:210])
QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4;=;-[Alumnos:2]numero:1)
SELECTION TO ARRAY:C260([Alumnos_SintesisAnual:210]Año:2;$aYears)
SORT ARRAY:C229($aYears;<)


ARRAY TEXT:C222(aYears;Size of array:C274($aYears))
For ($i;1;Size of array:C274($aYears))
	$year:=$aYears{$i}
	aYears{$i}:=KRL_GetTextFieldData (->[xxSTR_DatosDeCierre:24]Year:1;->$year;->[xxSTR_DatosDeCierre:24]NombreAgnoEscolar:5)
End for 

If (Size of array:C274(aYears)>0)
	  //SET VISIBLE(*;"Años@";True)
	INSERT IN ARRAY:C227(aYears;1;1)
	aYears{1}:=<>gNombreAgnoEscolar
Else 
	INSERT IN ARRAY:C227(aYears;1;1)
	aYears{1}:=<>gNombreAgnoEscolar
	  //SET VISIBLE(*;"Años@";False)
End if 
If (aYears=0)
	aYears:=1
End if 

