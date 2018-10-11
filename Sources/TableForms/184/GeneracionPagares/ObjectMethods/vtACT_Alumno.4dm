  //C_TEXT(vsACT_OldNomApellido)

IT_clairvoyanceOnFields2 (Self:C308;->[Alumnos:2]apellidos_y_nombres:40;False:C215)

Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		  //vsACT_OldNomApellido:=Self->
		ACTcfg_OpcionesGeneracionP ("TestInitVars")
		
	: ((Form event:C388=On Losing Focus:K2:8) | (Form event:C388=On Data Change:K2:15))
		If (Self:C308->#"")
			Case of 
				: (Records in selection:C76([Alumnos:2])=1)
					POST KEY:C465(Character code:C91("+");256)
					
				: (Records in selection:C76([Alumnos:2])>1)
					CD_Dlog (0;"Existe más de un registro con ese nombre.")
					
				: (Records in selection:C76([Alumnos:2])=0)
					CD_Dlog (0;"No existe un registro con ese nombre.")
					
			End case 
		Else 
			  //Self->:=vsACT_OldNomApellido
			
			REDUCE SELECTION:C351([Alumnos:2];0)
			REDUCE SELECTION:C351([ACT_CuentasCorrientes:175];0)
			REDUCE SELECTION:C351([Cursos:3];0)
			vtACT_Alumno:=""
			vtACT_RUT:=""
			POST KEY:C465(Character code:C91("+");256)
			
		End if 
End case 
