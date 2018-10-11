Spell_CheckSpelling 
Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		ARRAY TEXT:C222(atACT_AlumnosObsPgs;0)
		
		$error:=ALP_DefaultColSettings (xALP_ACTpgs_Alumnos;1;"atACT_AlumnosObsPgs";__ ("Alumno");200)
		$error:=ALP_DefaultColSettings (xALP_ACTpgs_Alumnos;2;"alACT_IdsAlumnos";__ ("Información SchoolTrack");360)
		
		  //general options
		ALP_SetDefaultAppareance (xALP_ACTpgs_Alumnos;9;1;6;1;8)
		AL_SetColOpts (xALP_ACTpgs_Alumnos;1;1;1;1;0)
		AL_SetRowOpts (xALP_ACTpgs_Alumnos;1;1;0;0;1;0)
		AL_SetCellOpts (xALP_ACTpgs_Alumnos;0;1;1)
		AL_SetMainCalls (xALP_ACTpgs_Alumnos;"";"")
		AL_SetScroll (xALP_ACTpgs_Alumnos;0;0)
		AL_SetEntryOpts (xALP_ACTpgs_Alumnos;0;0;0;0;0;<>tXS_RS_DecimalSeparator)
		
		AL_UpdateArrays (xALP_ACTpgs_Alumnos;0)
		For ($i;1;Size of array:C274(alACT_IdsAlumnos))
			$vl_idAlumno:=alACT_IdsAlumnos{$i}
			APPEND TO ARRAY:C911(atACT_AlumnosObsPgs;KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$vl_idAlumno;->[Alumnos:2]apellidos_y_nombres:40))
		End for 
		AL_UpdateArrays (xALP_ACTpgs_Alumnos;-2)
		
		ARRAY LONGINT:C221($al_pos;0)
		AL_SetSelect (xALP_ACTpgs_Alumnos;$al_pos)
		
		C_LONGINT:C283(btn_Apoderado;btn_Cta)
		C_DATE:C307(vdFechaObs)
		C_TEXT:C284(vt_Obs)
		
		If (btn_apdo=1)
			btn_Apoderado:=1
			btn_Cta:=0
			_O_ENABLE BUTTON:C192(btn_Apoderado)
		Else 
			btn_Apoderado:=0
			btn_Cta:=1
			_O_DISABLE BUTTON:C193(btn_Apoderado)
		End if 
		vdFechaObs:=Current date:C33(*)
		vt_Obs:=""
		
End case 