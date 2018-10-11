//%attributes = {}
  //SN3_SendColegioXML

C_BOOLEAN:C305($1;$2;$todos;$useArrays)
C_TIME:C306($refXMLDoc)

$todos:=True:C214
$useArrays:=False:C215
Case of 
	: (Count parameters:C259=1)
		$todos:=$1
	: (Count parameters:C259=2)
		$todos:=$1
		$useArrays:=$2
End case 

READ ONLY:C145([Colegio:31])
ALL RECORDS:C47([Colegio:31])
FIRST RECORD:C50([Colegio:31])

$currentErrorHandler:=SN3_SetErrorHandler ("set")

$vt_FileName:=SN3_CreateFile2Send ("crear";"";SN3_DatosColegio;"sax";->$refXMLDoc)
SN3_BuildFileHeader ($refXMLDoc;SN3_DatosColegio;"colegio";$todos;$useArrays)
$ther:=IT_UThermometer (1;0;__ ("Enviando datos generales del colegio..."))

SAX_CreateNode ($refXMLDoc;"id";True:C214;<>gRolBD;True:C214)
SAX_CreateNode ($refXMLDoc;"ciudad";True:C214;[Colegio:31]Ciudad:6;True:C214)
SAX_CreateNode ($refXMLDoc;"codigopostal";True:C214;[Colegio:31]CodigoPostal:24;True:C214)
SAX_CreateNode ($refXMLDoc;"pais";True:C214;[Colegio:31]Codigo_Pais:31;True:C214)
SAX_CreateNode ($refXMLDoc;"comuna";True:C214;[Colegio:31]Comuna:4;True:C214)
SAX_CreateNode ($refXMLDoc;"idcorporacion";True:C214;[Colegio:31]Corporacion_ID:34;True:C214)
SAX_CreateNode ($refXMLDoc;"corporacionnombre";True:C214;[Colegio:31]Corporacion_Nombre:35;True:C214)
SAX_CreateNode ($refXMLDoc;"direccion";True:C214;[Colegio:31]Dirección:3;True:C214)
SAX_CreateNode ($refXMLDoc;"nombre";True:C214;[Colegio:31]Nombre_Colegio:1;True:C214)
SAX_CreateNode ($refXMLDoc;"razonsocial";True:C214;[Colegio:31]RazonSocial:38;True:C214)
SAX_CreateNode ($refXMLDoc;"region";True:C214;[Colegio:31]Region:14;True:C214)
SAX_CreateNode ($refXMLDoc;"rol";True:C214;[Colegio:31]Rol Base Datos:9;True:C214)
SAX_CreateNode ($refXMLDoc;"rut";True:C214;[Colegio:31]RUT:2;True:C214)

SN3_LoadGeneralSettings 
SAX_CreateNode ($refXMLDoc;"mailadmin";True:C214;SN3_eMailAdministrador;True:C214)
SAX_CreateNode ($refXMLDoc;"niveles")
For ($i;1;Size of array:C274(<>al_NumeroNivelesSchoolNet))
	SAX_CreateNode ($refXMLDoc;"nivel")
	$noNivel:=<>al_NumeroNivelesSchoolNet{$i}
	SAX_CreateNode ($refXMLDoc;"id";True:C214;String:C10(<>al_NumeroNivelesSchoolNet{$i}))
	SAX_CreateNode ($refXMLDoc;"nombre";True:C214;<>at_NombreNivelesSchoolNet{$i};True:C214)
	$asistMode:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$noNivel;->[xxSTR_Niveles:6]AttendanceMode:3)
	$lateMode:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$noNivel;->[xxSTR_Niveles:6]Lates_Mode:16)
	SAX_CreateNode ($refXMLDoc;"modoasistencia";True:C214;String:C10($asistMode);True:C214)
	SAX_CreateNode ($refXMLDoc;"modoatrasos";True:C214;String:C10($lateMode);True:C214)
	PERIODOS_LoadData (<>al_NumeroNivelesSchoolNet{$i})
	SAX_CreateNode ($refXMLDoc;"horario")
	SAX_CreateNode ($refXMLDoc;"tipociclos";True:C214;String:C10(vlSTR_Horario_TipoCiclos))
	SAX_CreateNode ($refXMLDoc;"numciclos";True:C214;String:C10(vlSTR_Horario_NoCiclos))
	SAX_CreateNode ($refXMLDoc;"consabado";True:C214;String:C10(vlSTR_Horario_SabadoLabor))
	If (Size of array:C274(aiSTR_Horario_HoraNo)>0)
		SAX_CreateNode ($refXMLDoc;"horas")
		For ($k;1;Size of array:C274(aiSTR_Horario_HoraNo))
			SAX_CreateNode ($refXMLDoc;"hora")
			SAX_CreateNode ($refXMLDoc;"numhora";True:C214;String:C10(aiSTR_Horario_HoraNo{$k});True:C214)
			SAX_CreateNode ($refXMLDoc;"aliasHora";True:C214;String:C10(atSTR_Horario_HoraAlias{$k});True:C214)  //MONO TICKET 201238
			SAX_CreateNode ($refXMLDoc;"desde";True:C214;Time string:C180(alSTR_Horario_Desde{$k});True:C214)
			SAX_CreateNode ($refXMLDoc;"hasta";True:C214;Time string:C180(alSTR_Horario_Hasta{$k});True:C214)
			SAX_CreateNode ($refXMLDoc;"tipo";True:C214;String:C10(alSTR_Horario_RefTipoHora{$k}))
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //Cierra hora
		End for 
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //Cierra horas
	End if 
	SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //Cierra horario
	SAX_CreateNode ($refXMLDoc;"periodos")
	For ($j;1;Size of array:C274(atSTR_Periodos_Nombre))
		SAX_CreateNode ($refXMLDoc;"periodo")
		SAX_CreateNode ($refXMLDoc;"numero";True:C214;String:C10($j);True:C214)
		SAX_CreateNode ($refXMLDoc;"nombre";True:C214;atSTR_Periodos_Nombre{$j};True:C214)
		SAX_CreateNode ($refXMLDoc;"fechainicio";True:C214;SN3_MakeDateInmune2LocalFormat (adSTR_Periodos_Desde{$j});True:C214)
		SAX_CreateNode ($refXMLDoc;"fechatermino";True:C214;SN3_MakeDateInmune2LocalFormat (adSTR_Periodos_Hasta{$j});True:C214)
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
	End for 
	SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //Cierra periodos
	SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //Cierra nivel
End for 
SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //Cierra niveles

INstk_CreaMatrizVacunacion 
SAX_CreateNode ($refXMLDoc;"vacunas")
For ($i;1;Size of array:C274(<>atSTK_Vacunas))
	SAX_CreateNode ($refXMLDoc;"vacuna")
	SAX_CreateNode ($refXMLDoc;"enfermedad";True:C214;<>atSTK_Vacunas{$i};True:C214)
	SAX_CreateNode ($refXMLDoc;"meses";True:C214;String:C10(<>alSTK_MesesVacunacion{$i});True:C214)
	SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //Cierra vacuna
End for 
SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //Cierra vacunas

SAX_CreateNode ($refXMLDoc;"configactividades")
SAX_CreateNode ($refXMLDoc;"rasgos";True:C214;<>sXCRexpl1;True:C214)
SAX_CreateNode ($refXMLDoc;"indicadores";True:C214;<>sXCRexpl2;True:C214)
SAX_CreateNode ($refXMLDoc;"encabezadosevaluaciones")
For ($k;1;Size of array:C274(<>aXCRAbrv))
	SAX_CreateNode ($refXMLDoc;"encabezado")
	SAX_CreateNode ($refXMLDoc;"orden";True:C214;String:C10($k);True:C214)
	SAX_CreateNode ($refXMLDoc;"texto";True:C214;<>aXCRAbrv{$k};True:C214)
	SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //Cierra encabezado
End for 
SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //Cierra encabezadosevaluaciones
SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //Cierra configactividades

SET BLOB SIZE:C606($blob;0)
PICTURE TO BLOB:C692([Colegio:31]Logo:37;$blob;".jpg")
SAX OPEN XML ELEMENT:C853($refXMLDoc;"logo")
SAX ADD XML ELEMENT VALUE:C855($refXMLDoc;$blob)
SAX CLOSE XML ELEMENT:C854($refXMLDoc)

  //mono sn3 cambio para ACTUADATOS
READ ONLY:C145([xShell_List:39])
QUERY:C277([xShell_List:39];[xShell_List:39]Module:4="Schooltrack";*)
QUERY:C277([xShell_List:39]; | [xShell_List:39]Module:4="All")

ARRAY TEXT:C222($at_listas;0)
APPEND TO ARRAY:C911($at_listas;"Comunas")
APPEND TO ARRAY:C911($at_listas;"Ficha Médica: Alergias")
APPEND TO ARRAY:C911($at_listas;"Ficha Médica: Grupos Sanguíneos")
APPEND TO ARRAY:C911($at_listas;"Lugar de Nacimiento")
APPEND TO ARRAY:C911($at_listas;"Nacionalidad")
APPEND TO ARRAY:C911($at_listas;"Prefijos")
APPEND TO ARRAY:C911($at_listas;"Profesiones")
APPEND TO ARRAY:C911($at_listas;"Religiones")
APPEND TO ARRAY:C911($at_listas;"Ficha Médica: Alergias")
APPEND TO ARRAY:C911($at_listas;"Ficha Médica: Enfermedades")
APPEND TO ARRAY:C911($at_listas;"Grupos (Alianza, Casa, Color…)")
APPEND TO ARRAY:C911($at_listas;"Sector Domicilio")

QRY_QueryWithArray (->[xShell_List:39]Listname:1;->$at_listas;True:C214)

ARRAY LONGINT:C221($al_rn_xsl;0)

LONGINT ARRAY FROM SELECTION:C647([xShell_List:39];$al_rn_xsl;"")
SAX_CreateNode ($refXMLDoc;"listas")
For ($i;1;Size of array:C274($al_rn_xsl))
	GOTO RECORD:C242([xShell_List:39];$al_rn_xsl{$i})
	SAX_CreateNode ($refXMLDoc;"lista")
	If ([xShell_List:39]Listname:1="Grupos (Alianza, Casa, Color…)")
		SAX_CreateNode ($refXMLDoc;"tag";True:C214;"grupo";True:C214)
	Else 
		SAX_CreateNode ($refXMLDoc;"tag";True:C214;[xShell_List:39]Listname:1;True:C214)
	End if 
	SAX_CreateNode ($refXMLDoc;"enriquecible";True:C214;String:C10(Num:C11([xShell_List:39]Enriquecible:8));True:C214)
	SAX_CreateNode ($refXMLDoc;"elementos")
	
	$ptr_array:=Get pointer:C304([xShell_List:39]ArrayName1:5)
	
	For ($n;1;Size of array:C274($ptr_array->))
		SAX_CreateNode ($refXMLDoc;"item";True:C214;$ptr_array->{$n};True:C214)
	End for 
	
	SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //Cierra elementos
	SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //Cierra lista
End for 
  //valores de vacunas
SAX_CreateNode ($refXMLDoc;"lista")
SAX_CreateNode ($refXMLDoc;"tag";True:C214;"Vacunas";True:C214)
SAX_CreateNode ($refXMLDoc;"enriquecible";True:C214;"0";True:C214)
SAX_CreateNode ($refXMLDoc;"elementos")

ARRAY TEXT:C222($vacunas;0)
COPY ARRAY:C226(<>atSTK_Vacunas;$vacunas)
AT_DistinctsArrayValues (->$vacunas)
For ($n;1;Size of array:C274($vacunas))
	SAX_CreateNode ($refXMLDoc;"item";True:C214;$vacunas{$n};True:C214)
End for 

SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //Cierra elementos
SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //Cierra lista

SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //Cierra listas
  //mono sn3 cambio

SAX_CreateNode ($refXMLDoc;"configuracionperiodos")
READ ONLY:C145([xxSTR_Periodos:100])
QUERY:C277([xxSTR_Periodos:100];[xxSTR_Periodos:100]ID:1>=-1)  //-2 reservado para MediaTrack
ARRAY LONGINT:C221($aPeridosRefs;0)
SELECTION TO ARRAY:C260([xxSTR_Periodos:100]ID:1;$aPeridosRefs)
For ($i;1;Size of array:C274($aPeridosRefs))
	PERIODOS_LoadData (0;$aPeridosRefs{$i})
	SAX_CreateNode ($refXMLDoc;"configuracion")
	SAX_CreateNode ($refXMLDoc;"id";True:C214;String:C10($aPeridosRefs{$i}))
	SAX_CreateNode ($refXMLDoc;"periodos")
	For ($j;1;Size of array:C274(atSTR_Periodos_Nombre))
		SAX_CreateNode ($refXMLDoc;"periodo")
		SAX_CreateNode ($refXMLDoc;"numero";True:C214;String:C10($j);True:C214)
		SAX_CreateNode ($refXMLDoc;"nombre";True:C214;atSTR_Periodos_Nombre{$j};True:C214)
		SAX_CreateNode ($refXMLDoc;"fechainicio";True:C214;SN3_MakeDateInmune2LocalFormat (adSTR_Periodos_Desde{$j});True:C214)
		SAX_CreateNode ($refXMLDoc;"fechatermino";True:C214;SN3_MakeDateInmune2LocalFormat (adSTR_Periodos_Hasta{$j});True:C214)
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
	End for 
	SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //cierre periodos
	SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //cierre configuracion
End for 
SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //cierre configuracionperiodos

  //Alias de Calificaciones - MONO TICKET 114780
C_OBJECT:C1216($o_nomEvaGral)
ARRAY TEXT:C222($at_nombreEva;0)
C_TEXT:C284($t_display)
C_LONGINT:C283($i_nivel;$i_display)

SAX_CreateNode ($refXMLDoc;"aliasCalificacionesGenerales")

For ($i_nivel;1;Size of array:C274(<>al_NumeroNivelesSchoolNet))
	
	CLEAR VARIABLE:C89($o_nomEvaGral)
	LOC_ObjNombreColumnasEval ("consultar";->$o_nomEvaGral;<>al_NumeroNivelesSchoolNet{$i_nivel})
	OB GET PROPERTY NAMES:C1232($o_nomEvaGral;$at_nombreEva)
	
	SAX_CreateNode ($refXMLDoc;"nivel")
	SAX_CreateNode ($refXMLDoc;"id";True:C214;String:C10(<>al_NumeroNivelesSchoolNet{$i_nivel}))
	For ($i_display;1;Size of array:C274($at_nombreEva))
		$t_display:=OB Get:C1224($o_nomEvaGral;$at_nombreEva{$i_display})
		SAX_CreateNode ($refXMLDoc;$at_nombreEva{$i_display};True:C214;$t_display;True:C214)
	End for 
	SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //cierre nivel
End for 
SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //cierre aliasCalificacionesGenerales

IT_UThermometer (-2;$ther)

SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
If (Error=0)
	SN3_RegisterLogEntry (SN3_Log_FileGeneration;"Generación del documento con datos del colegio.")
Else 
	SN3_RegisterLogEntry (SN3_Log_Error;"El documento con datos del colegio no pudo ser generado.";Error)
	
End if 

SN3_SetErrorHandler ("clear";$currentErrorHandler)