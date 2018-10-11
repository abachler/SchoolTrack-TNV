C_LONGINT:C283($l_Programacion)

$l_Programacion:=(OBJECT Get pointer:C1124(Object named:K67:5;"menuProgramacionSeleccion"))->



Case of 
	: ($l_Programacion=1)  // sin respaldos
		OBJECT SET VISIBLE:C603(*;"BKP@";False:C215)
		OBJECT SET VISIBLE:C603(*;"menuProgramacionSeleccion";True:C214)
		(OBJECT Get pointer:C1124(Object named:K67:5;"BKP_programacion"))->:="Never"
		(OBJECT Get pointer:C1124(Object named:K67:5;"BKP_restauracionAutomatica"))->:=0
		(OBJECT Get pointer:C1124(Object named:K67:5;"BKP_integracionAutomaticaLog"))->:=0
		
	: ($l_Programacion=2)  // frecuencia horaria (cada X horas)
		OBJECT SET VISIBLE:C603(*;"BKP_@";True:C214)
		OBJECT SET VISIBLE:C603(*;"BKP_semanal@";False:C215)
		OBJECT SET VISIBLE:C603(*;"BKP_frecuenciaDiaria@";False:C215)
		
		(OBJECT Get pointer:C1124(Object named:K67:5;"BKP_programacion"))->:="Hourly"
		IT_AlineaObjetos (Izquierda;30;"menuProgramacionSeleccion";"BKP_FrecuenciaHoraria@")
		
		
	: ($l_Programacion=3)  // frecuencia diaria (cada X días)
		OBJECT SET VISIBLE:C603(*;"BKP_@";True:C214)
		OBJECT SET VISIBLE:C603(*;"BKP_semanal@";False:C215)
		OBJECT SET VISIBLE:C603(*;"BKP_frecuenciaHoraria@";False:C215)
		(OBJECT Get pointer:C1124(Object named:K67:5;"BKP_programacion"))->:="Daily"
		IT_AlineaObjetos (Izquierda;30;"menuProgramacionSeleccion";"BKP_FrecuenciaDiaria@")
		
		
	: ($l_Programacion=4)  // programacion semanal personalizada
		OBJECT SET VISIBLE:C603(*;"BKP_@";True:C214)
		OBJECT SET VISIBLE:C603(*;"BKP_frecuenciaDiaria@";False:C215)
		OBJECT SET VISIBLE:C603(*;"BKP_frecuenciaHoraria@";False:C215)
		(OBJECT Get pointer:C1124(Object named:K67:5;"BKP_programacion"))->:="Weekly"
		IT_AlineaObjetos (Izquierda;15;"menuProgramacionSeleccion";"BKP_Semanal@")
End case 

OBJECT SET VISIBLE:C603(*;"menuRespaldosModoEliminacion";$l_programacion>1)
OBJECT SET VISIBLE:C603(*;"menuUnidadReintentos";$l_programacion>1)
OBJECT SET VISIBLE:C603(*;"menuRespaldosCompresion";$l_programacion>1)
OBJECT SET VISIBLE:C603(*;"botonRutaRespaldos";$l_programacion>1)
OBJECT SET VISIBLE:C603(*;"seleccionHistorial";$l_programacion>1)
OBJECT SET ENABLED:C1123(*;"BKP_restauracionAutomatica";(OBJECT Get pointer:C1124(Object named:K67:5;"menuProgramacionSeleccion"))->>1)
OBJECT SET VISIBLE:C603(*;"verHistorial";(OBJECT Get pointer:C1124(Object named:K67:5;"menuProgramacionSeleccion"))->>1)
