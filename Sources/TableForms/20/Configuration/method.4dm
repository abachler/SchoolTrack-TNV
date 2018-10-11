Spell_CheckSpelling 



Case of 
	: (Form event:C388=On Load:K2:1)
		READ ONLY:C145([xxSTR_Materias:20])
		ALL RECORDS:C47([xxSTR_Materias:20])
		ORDER BY:C49([xxSTR_Materias:20];[xxSTR_Materias:20]Materia:2;>)
		(OBJECT Get pointer:C1124(Object named:K67:5;"encabezadoOrden"))->:=0
		(OBJECT Get pointer:C1124(Object named:K67:5;"encabezadoSector"))->:=0
		(OBJECT Get pointer:C1124(Object named:K67:5;"encabezadoSubsector"))->:=1
		OBJECT SET ENABLED:C1123(*;"eliminar";Records in set:C195("MateriasSeleccionadas")>0)
		OBJECT SET VISIBLE:C603(*;"mostrarTodo";True:C214)
		
		OBJECT SET RGB COLORS:C628(*;"lb_Materias";0x004F4F4F;0x00E1E1E1;0x00F1F1F1)
		
		Case of 
			: ((OBJECT Get pointer:C1124(Object named:K67:5;"encabezadoOrden"))->=1)
				ORDER BY:C49([xxSTR_Materias:20];[xxSTR_Materias:20]NoSector:11;>)
				
			: ((OBJECT Get pointer:C1124(Object named:K67:5;"encabezadoOrden"))->=-1)
				ORDER BY:C49([xxSTR_Materias:20];[xxSTR_Materias:20]NoSector:11;<)
				
			: ((OBJECT Get pointer:C1124(Object named:K67:5;"encabezadoSector"))->=1)
				ORDER BY:C49([xxSTR_Materias:20];[xxSTR_Materias:20]Area:12;>)
				
			: ((OBJECT Get pointer:C1124(Object named:K67:5;"encabezadoSector"))->=-1)
				ORDER BY:C49([xxSTR_Materias:20];[xxSTR_Materias:20]Area:12;<)
				
			: ((OBJECT Get pointer:C1124(Object named:K67:5;"encabezadoSubsector"))->=1)
				ORDER BY:C49([xxSTR_Materias:20];[xxSTR_Materias:20]Materia:2;>)
				
			: ((OBJECT Get pointer:C1124(Object named:K67:5;"encabezadoSubsector"))->=-1)
				ORDER BY:C49([xxSTR_Materias:20];[xxSTR_Materias:20]Materia:2;<)
				
		End case 
		
		
	: (Form event:C388=On Close Box:K2:21)
		vbCFG_CloseWindow:=True:C214
		CANCEL:C270
		
	: (Form event:C388=On Unload:K2:2)
		CLEAR SET:C117("MateriasSeleccionadas")
		
		
End case 