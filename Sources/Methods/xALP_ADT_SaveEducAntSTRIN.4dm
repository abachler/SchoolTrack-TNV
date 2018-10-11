//%attributes = {}

  //xALP_ADT_SaveEducAntSTRIN

If (False:C215)
	<>ST_v461:=False:C215  //15/8/98 at 16:53:36 by: Alberto Bachler
	  //implementación de bimestres
End if 
C_LONGINT:C283($1;$2)
C_LONGINT:C283(vCol;vRow)
AL_GetCurrCell (xALP_EducAntSTR;vCol;vRow)
If (vRow>0)
	Case of 
		: (vCol=2)
			Case of 
				: (atTipoInstitucion{vRow}="Colegio")
					  //se carga la lista de los colegios
					AL_SetEnterable (xALP_EducAntSTR;2;3;<>aPrevSchool)
					AL_UpdateArrays (xALP_EducAntSTR;-2)
					$institucion:=""
				: (atTipoInstitucion{vRow}="Estudio Universitario")
					AL_SetEnterable (xALP_EducAntSTR;2;3;<>at_TitulosInstitucion)
					AL_UpdateArrays (xALP_EducAntSTR;-2)
					$institucion:=""
				: (atTipoInstitucion{vRow}="Otro")
					AL_SetEnterable (xALP_EducAntSTR;2;1)
					$institucion:=""
			End case 
	End case 
End if 