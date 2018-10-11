$ref:=Create document:C266("")
If (ok=1)
	$path:=document
	ARRAY TEXT:C222(aHeaders;34)
	AT_Inc (0)
	aHeaders{AT_Inc }:="[Alumno]Identificador nacional"
	aHeaders{AT_Inc }:="[Alumno]Apellido paterno"
	aHeaders{AT_Inc }:="[Alumno]Apellido_materno"
	aHeaders{AT_Inc }:="[Alumno]Nombres"
	aHeaders{AT_Inc }:="[Alumno]Sexo"
	aHeaders{AT_Inc }:="[Alumno]Fecha de nacimiento"
	aHeaders{AT_Inc }:="[Alumno]Dirección"
	aHeaders{AT_Inc }:="[Alumnos]Codigo_Postal"
	aHeaders{AT_Inc }:="[Alumnos]Comuna(Colonia)"
	aHeaders{AT_Inc }:="[Alumnos]Región_o_estado"
	aHeaders{AT_Inc }:="[ADT_Candidatos]Entrevistador"
	aHeaders{AT_Inc }:="[ADT_Candidatos]Postula_a(numero nivel ST)"
	aHeaders{AT_Inc }:="[ADT_Candidatos]Como_Llego_al_Colegio"
	aHeaders{AT_Inc }:="[ADT_Candidatos]Estado"
	aHeaders{AT_Inc }:="[ADT_Candidatos]Observaciones_entrevista"
	aHeaders{AT_Inc }:="[ADT_Candidatos_Observaciones]Observaciones_del_candidato"
	aHeaders{AT_Inc }:="[STR_EducacionAnterior]Nombre_Colegio"
	aHeaders{AT_Inc }:="[STR_EducacionAnterior]País"
	aHeaders{AT_Inc }:="[STR_EducacionAnterior]Nivel"
	aHeaders{AT_Inc }:="[STR_EducacionAnterior]Año"
	aHeaders{AT_Inc }:="[Padre]Identificador_Nacional"
	aHeaders{AT_Inc }:="[Padre]Apellido Paterno"
	aHeaders{AT_Inc }:="[Padre]Apellido Materno"
	aHeaders{AT_Inc }:="[Padre]Nombres"
	aHeaders{AT_Inc }:="[Padre]Dirección"
	aHeaders{AT_Inc }:="[Padre]Email"
	aHeaders{AT_Inc }:="[Padre]Celular"
	aHeaders{AT_Inc }:="[Madre]Identificador_Nacional"
	aHeaders{AT_Inc }:="[Madre]Apellido Paterno"
	aHeaders{AT_Inc }:="[Madre]Apellido Materno"
	aHeaders{AT_Inc }:="[Madre]Nombres"
	aHeaders{AT_Inc }:="[Madre]Dirección"
	aHeaders{AT_Inc }:="[Madre]Email"
	aHeaders{AT_Inc }:="[Madre]Celular"
	
	$text:=AT_array2text (->aHeaders;"\t")
	AT_Initialize (->aHeaders)
	IO_SendPacket ($ref;$text)
	CLOSE DOCUMENT:C267($ref)
	
	CD_Dlog (0;__ ("Archivo generado con éxito.\rPodrá encontrarlo en \r\r")+$path)
End if 
