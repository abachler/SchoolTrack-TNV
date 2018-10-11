  // [Alumnos].rep_CL_Concentracion_carta()
  // Por: Alberto Bachler K.: 16-04-14, 17:59:29
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

If (Form event:C388=On Printing Detail:K2:18)
	  //`variable para saber si es carta o oficio
	C_TEXT:C284(tipoDocumento)
	tipoDocumento:="Carta"
	AL_CertConcent 
	If (([Alumnos:2]nivel_numero:29<12) | (([Alumnos:2]nivel_numero:29=12) & ([Alumnos:2]Situacion_final:33#"P")))
		OBJECT SET VISIBLE:C603(*;"docInvalido";True:C214)
	Else 
		OBJECT SET VISIBLE:C603(*;"docInvalido";False:C215)
	End if 
	
	ACTAS_FirmaDirector 
	
End if 



