//%attributes = {}
  //xALP_ADT_SaveEducAntSTR

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2;$col;$row;$id)
C_TEXT:C284($tipoInstitucion;$institucion;$pais;$grado;$anio;$idEducacionAnterior)
C_TEXT:C284($atArrayVacio;0)


If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	  //codigo
	
	AL_GetCurrCell (xALP_EducAntSTR;$col;$row)
	AL_GetCellValue (xALP_EducAntSTR;$row;1;$tipoInstitucion)
	AL_GetCellValue (xALP_EducAntSTR;$row;2;$institucion)
	AL_GetCellValue (xALP_EducAntSTR;$row;3;$pais)
	AL_GetCellValue (xALP_EducAntSTR;$row;4;$grado)
	AL_GetCellValue (xALP_EducAntSTR;$row;5;$anio)
	AL_GetCellValue (xALP_EducAntSTR;$row;6;$idEducacionAnterior)
	
	$id:=Num:C11($idEducacionAnterior)
	Case of 
		: ($col=1)  //se eligen la opcion de colegio o institucion
			
			Case of 
				: ($tipoInstitucion="Colegio")
					  //se carga la lista de los colegios
					AL_SetEnterable (xALP_EducAntSTR;2;3;<>aPrevSchool)
					AL_UpdateArrays (xALP_EducAntSTR;-2)
					$institucion:=""
				: ($tipoInstitucion="Estudio Universitario")
					AL_SetEnterable (xALP_EducAntSTR;2;3;<>at_TitulosInstitucion)
					AL_UpdateArrays (xALP_EducAntSTR;-2)
					$institucion:=""
				: ($tipoInstitucion="Otro")
					AL_SetEnterable (xALP_EducAntSTR;2;1)
					$institucion:=""
			End case 
	End case 
	
	
	  //se guardar los datos
	READ WRITE:C146([STR_EducacionAnterior:87])
	QUERY:C277([STR_EducacionAnterior:87];[STR_EducacionAnterior:87]ID_EducacionAnterior:9=$id)
	If ((Records in selection:C76([STR_EducacionAnterior:87])>0) & ($id#0))  //`ya existe el registro, se edita
		[STR_EducacionAnterior:87]Tipo_Persona:8:="pe"
		[STR_EducacionAnterior:87]Año:4:=Num:C11($anio)
		[STR_EducacionAnterior:87]ID_Persona:6:=[Personas:7]No:1
		[STR_EducacionAnterior:87]Nivel:3:=$grado
		[STR_EducacionAnterior:87]Nombre_Colegio:1:=$institucion
		[STR_EducacionAnterior:87]País:2:=$pais
		[STR_EducacionAnterior:87]Tipo_Institucion:10:=$tipoInstitucion
		SAVE RECORD:C53([STR_EducacionAnterior:87])
	Else   //se crea
		If ($id=0)
			DELETE SELECTION:C66([STR_EducacionAnterior:87])
		End if 
		CREATE RECORD:C68([STR_EducacionAnterior:87])
		[STR_EducacionAnterior:87]ID_EducacionAnterior:9:=SQ_SeqNumber (->[STR_EducacionAnterior:87]ID_EducacionAnterior:9)
		[STR_EducacionAnterior:87]Tipo_Persona:8:="pe"
		[STR_EducacionAnterior:87]Año:4:=Num:C11($anio)
		[STR_EducacionAnterior:87]ID_Persona:6:=[Personas:7]No:1
		[STR_EducacionAnterior:87]Nivel:3:=$grado
		[STR_EducacionAnterior:87]Nombre_Colegio:1:=$institucion
		[STR_EducacionAnterior:87]País:2:=$pais
		[STR_EducacionAnterior:87]Tipo_Institucion:10:=$tipoInstitucion
		SAVE RECORD:C53([STR_EducacionAnterior:87])
	End if 
	
	aiAno{$row}:=[STR_EducacionAnterior:87]Año:4
	atInstitucion{$row}:=[STR_EducacionAnterior:87]Nombre_Colegio:1
	atTipoInstitucion{$row}:=[STR_EducacionAnterior:87]Tipo_Institucion:10
	atGradoONivel{$row}:=[STR_EducacionAnterior:87]Nivel:3
	atPaisEducacion{$row}:=[STR_EducacionAnterior:87]País:2
	IDEducacionAnterior{$row}:=[STR_EducacionAnterior:87]ID_EducacionAnterior:9
	
	KRL_UnloadReadOnly (->[STR_EducacionAnterior:87])
	
	AL_SetLine (xALP_EducAntSTR;0)
	
End if 