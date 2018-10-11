BWR_FormMethod 
Case of 
	: (Form event:C388=On Load:K2:1)
		
		C_BOOLEAN:C305(cambioEstado)
		motivo:=""
		cambioEstado:=False:C215
		C_BOOLEAN:C305(vb_opPrivada)
		C_BOOLEAN:C305(vb_opPrivadaEx)
		
		_O_C_INTEGER:C282(cb_SaltarEstados)
		cb_SaltarEstados:=Num:C11(PREF_fGet (0;"SaltarEstadosADT";"0"))
		_O_C_INTEGER:C282(obligatorio)
		
		OBJECT SET VISIBLE:C603(*;"matrireligio@";[Familia:78]Matrimonio_Religioso:38)
		OBJECT SET ENTERABLE:C238(*;"matrireligio@";[Familia:78]Matrimonio_Religioso:38)
		OBJECT SET VISIBLE:C603(*;"matricivil@";[Familia:78]Matrimonio_Civil:36)
		OBJECT SET ENTERABLE:C238(*;"matricivil@";[Familia:78]Matrimonio_Civil:36)
		
		  //para actualizar las vista del examen y las entrevistas del formulario
		  //UD_v20090820_UpdateIDEntExaCand 
		ADT_VistasIViewExam 
End case 

