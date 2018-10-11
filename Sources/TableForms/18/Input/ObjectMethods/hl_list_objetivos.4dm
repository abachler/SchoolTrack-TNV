
If (Form event:C388=On Clicked:K2:4)
	C_TEXT:C284($text)
	GET LIST ITEM:C378(hl_list_objetivos;Selected list items:C379(hl_list_objetivos);vl_refPestañaObjetivosActiva;$text)
	
	Case of 
		: (vl_refPestañaObjetivosActiva=1)
			vt_periodo:=atSTR_Periodos_Nombre{viSTR_PeriodoActual_Numero}
			OBJECT SET COLOR:C271(vt_periodo;-5)
			OBJECT SET VISIBLE:C603(*;"vObj_P@";False:C215)
			OBJECT SET VISIBLE:C603(*;"vObj_P"+String:C10(viSTR_PeriodoActual_Numero);True:C214)
			OBJECT SET VISIBLE:C603(*;"xALP_ObjxAlu";False:C215)
			OBJECT SET VISIBLE:C603(*;"bc_MostrarFotografias1";False:C215)
			AL_UpdateArrays (xALP_ObjxAlu;0)
			AL_SetScroll (xALP_ObjxAlu;0;0)
			ALP_RemoveAllArrays (xALP_ObjxAlu)
			GOTO OBJECT:C206(*;"vObj_P"+String:C10(viSTR_PeriodoActual_Numero))
		: (vl_refPestañaObjetivosActiva=2)
			OBJECT SET VISIBLE:C603(*;"bc_MostrarFotografias1";True:C214)
			OBJECT SET VISIBLE:C603(*;"vObj_P@";False:C215)
			OBJECT SET VISIBLE:C603(*;"xALP_ObjxAlu";True:C214)
			AS_Load_ObjxAlu 
			
		: (vl_refPestañaObjetivosActiva=3)
			  //quizas en el futuro podria crear los objetivos por grupo de trabajo dentro
	End case 
End if 