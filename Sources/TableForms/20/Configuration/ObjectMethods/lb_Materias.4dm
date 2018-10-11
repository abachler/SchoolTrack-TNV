Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		CREATE SET:C116([xxSTR_Materias:20];"Seleccion")
		WDW_OpenFormWindow (->[xxSTR_Materias:20];"Input";-1;8;__ ("Subsectores de aprendizaje"))
		KRL_ModifyRecord (->[xxSTR_Materias:20];"Input")
		CLOSE WINDOW:C154
		ONE RECORD SELECT:C189([xxSTR_Materias:20])
		CREATE SET:C116([xxSTR_Materias:20];"MateriasSeleccionadas")
		USE SET:C118("Seleccion")
		CLEAR SET:C117("Seleccion")
		
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
		OBJECT SET SCROLL POSITION:C906(*;"lb_Materias")
		
	: (Form event:C388=On Clicked:K2:4)
		LOAD RECORD:C52([xxSTR_Materias:20])
		OBJECT SET ENABLED:C1123(*;"eliminar";Records in set:C195("MateriasSeleccionadas")>0)
		
End case 