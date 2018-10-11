C_BOOLEAN:C305($b_justificadoConLicencia)
C_LONGINT:C283($l_inasistencias)

Spell_CheckSpelling 

Case of 
	: (Form event:C388=On Load:K2:1)
		
		Case of 
			: ((vt_multiplesSesiones="") & (vt_multiplesAlumnos=""))
				FORM GOTO PAGE:C247(1)
			: ((vt_multiplesSesiones#"") & (vt_multiplesAlumnos=""))
				FORM GOTO PAGE:C247(2)
			: ((vt_multiplesSesiones="") & (vt_multiplesAlumnos#""))
				FORM GOTO PAGE:C247(3)
			: ((vt_multiplesSesiones#"") & (vt_multiplesAlumnos#""))
				FORM GOTO PAGE:C247(4)
		End case 
		OBJECT SET ENABLED:C1123(*;"guardar";[Asignaturas_Inasistencias:125]Justificacion:3#"")
		
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Data Change:K2:15))
		OBJECT SET ENABLED:C1123(*;"guardar";[Asignaturas_Inasistencias:125]Justificacion:3#"")
		
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
