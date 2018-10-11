  // Método: Método de Formulario: STR_NuevoHistorico
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 22/06/10, 11:05:52
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal

Case of 
	: (Form event:C388=On Load:K2:1)
		
		vl_Year:=0
		vl_NivelSeleccionado:=0
		vt_yearName:="Seleccione el año..."
		OBJECT SET COLOR:C271(vt_yearName;-14)
		vt_Nivel:="Seleccione el año, luego el nivel"
		OBJECT SET COLOR:C271(vt_Nivel;-14)
		
		CREATE EMPTY SET:C140([xxSTR_HistoricoNiveles:191];"NivelesDisponibles")
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
	: (Form event:C388=On Unload:K2:2)
		SET_ClearSets ("NivelesDisponibles")
		
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 




