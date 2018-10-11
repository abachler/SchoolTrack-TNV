Case of 
	: (Form event:C388=On Load:K2:1)
		QUERY WITH ARRAY:C644([xxSTR_Niveles:6]NoNivel:5;<>al_NumeroNivelesActivos)
		SELECTION TO ARRAY:C260([xxSTR_Niveles:6]NoNivel:5;aNivelNo;[xxSTR_Niveles:6]Nivel:1;aPopNivel1)
		COPY ARRAY:C226(aPopNivel1;aPopNivel2)
		SORT ARRAY:C229(aNivelNo;aPopNivel1;aPopNivel2;>)
		aPopNivel1:=1
		apopNivel2:=Size of array:C274(apopNivel2)
		i1InitNumMatricula:=1
		i2InitNumMatricula:=0
		ARRAY TEXT:C222(aOrdenMatricula;4)
		aOrdenMatricula{1}:="Ascendente, por nivel"
		aOrdenMatricula{2}:="Ascendente, por nivel y curso"
		aOrdenMatricula{3}:="Descendente, por nivel"
		aOrdenMatricula{4}:="Descendente, por nivel y curso"
		aOrdenMatricula:=1
		bc_ReasignarTodo:=0
		
		OBJECT SET ENABLED:C1123(*;"obj_fecha@";False:C215)
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 