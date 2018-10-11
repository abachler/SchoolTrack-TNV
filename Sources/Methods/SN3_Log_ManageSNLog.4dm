//%attributes = {}
  //SN3_Log_ManageSNLog

C_DATE:C307($date;$1)
Case of 
	: (Count parameters:C259=1)
		$date:=$1
		$cb_Log_VerErrores:=0
		$cb_Log_VerInfo:=0
		$cb_Log_VerGeneracion:=0
		$cb_Log_VerEnvios:=0
	: (Count parameters:C259=2)
		$date:=$1
		$cb_Log_VerErrores:=$2
		$cb_Log_VerInfo:=0
		$cb_Log_VerGeneracion:=0
		$cb_Log_VerEnvios:=0
	: (Count parameters:C259=3)
		$date:=$1
		$cb_Log_VerErrores:=$2
		$cb_Log_VerInfo:=$3
		$cb_Log_VerGeneracion:=0
		$cb_Log_VerEnvios:=0
	: (Count parameters:C259=4)
		$date:=$1
		$cb_Log_VerErrores:=$2
		$cb_Log_VerInfo:=$3
		$cb_Log_VerGeneracion:=$4
		$cb_Log_VerEnvios:=0
	: (Count parameters:C259=5)
		$date:=$1
		$cb_Log_VerErrores:=$2
		$cb_Log_VerInfo:=$3
		$cb_Log_VerGeneracion:=$4
		$cb_Log_VerEnvios:=$5
End case 

ARRAY DATE:C224(SN3_Log_Fecha;0)
ARRAY LONGINT:C221(SN3_Log_Hora;0)
ARRAY TEXT:C222(SN3_Log_Descripcion;0)
ARRAY LONGINT:C221(SN3_Log_Colores;0)
ARRAY LONGINT:C221(SN3_Log_Estilos;0)
ARRAY LONGINT:C221(SN3_Log_Tipo;0)
ARRAY TEXT:C222(SN3_Log_DescError;0)
ARRAY TEXT:C222(SN3_Log_Maquina;0)
ARRAY DATE:C224($SN3_Log_Fecha;0)
ARRAY LONGINT:C221($SN3_Log_Hora;0)
ARRAY TEXT:C222($SN3_Log_Descripcion;0)
ARRAY LONGINT:C221($SN3_Log_Colores;0)
ARRAY LONGINT:C221($SN3_Log_Estilos;0)
ARRAY LONGINT:C221($SN3_Log_Tipo;0)
ARRAY TEXT:C222($SN3_Log_DescError;0)
ARRAY TEXT:C222($SN3_Log_Maquina;0)
If ($date=!00-00-00!)
	COPY ARRAY:C226(SN3_Log_FechaSN;SN3_Log_Fecha)
	COPY ARRAY:C226(SN3_Log_HoraSN;SN3_Log_Hora)
	COPY ARRAY:C226(SN3_Log_DescripcionSN;SN3_Log_Descripcion)
	COPY ARRAY:C226(SN3_Log_ColoresSN;SN3_Log_Colores)
	COPY ARRAY:C226(SN3_Log_EstilosSN;SN3_Log_Estilos)
	COPY ARRAY:C226(SN3_Log_TipoSN;SN3_Log_Tipo)
	COPY ARRAY:C226(SN3_Log_DescErrorSN;SN3_Log_DescError)
	COPY ARRAY:C226(SN3_Log_MaquinaSN;SN3_Log_Maquina)
Else 
	SN3_Log_Fecha{0}:=$date
	ARRAY LONGINT:C221($DA_Return;0)
	AT_SearchArray (->SN3_Log_FechaSN;"=";->$DA_Return)
	For ($i;1;Size of array:C274($DA_Return))
		$j:=$DA_Return{$i}
		APPEND TO ARRAY:C911(SN3_Log_Fecha;SN3_Log_FechaSN{$j})
		APPEND TO ARRAY:C911(SN3_Log_Hora;SN3_Log_HoraSN{$j})
		APPEND TO ARRAY:C911(SN3_Log_Descripcion;SN3_Log_DescripcionSN{$j})
		APPEND TO ARRAY:C911(SN3_Log_Colores;SN3_Log_ColoresSN{$j})
		APPEND TO ARRAY:C911(SN3_Log_Estilos;SN3_Log_EstilosSN{$j})
		APPEND TO ARRAY:C911(SN3_Log_Tipo;SN3_Log_TipoSN{$j})
		APPEND TO ARRAY:C911(SN3_Log_DescError;SN3_Log_DescErrorSN{$j})
		APPEND TO ARRAY:C911(SN3_Log_Maquina;SN3_Log_MaquinaSN{$j})
	End for 
End if 

ARRAY LONGINT:C221(DA_ReturnERRORS;0)
ARRAY LONGINT:C221(DA_ReturnINFOS;0)
ARRAY LONGINT:C221(DA_ReturnGENER;0)
ARRAY LONGINT:C221(DA_ReturnSENT;0)
ARRAY LONGINT:C221(DA_Finals;0)
If ($cb_Log_VerErrores=1)
	SN3_Log_Tipo{0}:=SN3_Log_Error
	AT_SearchArray (->SN3_Log_Tipo;"=";->DA_ReturnERRORS)
End if 
If ($cb_Log_VerInfo=1)
	SN3_Log_Tipo{0}:=SN3_Log_Info
	AT_SearchArray (->SN3_Log_Tipo;"=";->DA_ReturnINFOS)
End if 
If ($cb_Log_VerGeneracion=1)
	SN3_Log_Tipo{0}:=SN3_Log_FileGeneration
	AT_SearchArray (->SN3_Log_Tipo;"=";->DA_ReturnGENER)
End if 
If ($cb_Log_VerEnvios=1)
	SN3_Log_Tipo{0}:=SN3_Log_FileSent
	AT_SearchArray (->SN3_Log_Tipo;"=";->DA_ReturnSENT)
End if 
For ($i;1;Size of array:C274(DA_ReturnERRORS))
	APPEND TO ARRAY:C911(DA_Finals;DA_ReturnERRORS{$i})
End for 
For ($i;1;Size of array:C274(DA_ReturnINFOS))
	APPEND TO ARRAY:C911(DA_Finals;DA_ReturnINFOS{$i})
End for 
For ($i;1;Size of array:C274(DA_ReturnGENER))
	APPEND TO ARRAY:C911(DA_Finals;DA_ReturnGENER{$i})
End for 
For ($i;1;Size of array:C274(DA_ReturnSENT))
	APPEND TO ARRAY:C911(DA_Finals;DA_ReturnSENT{$i})
End for 
SORT ARRAY:C229(DA_Finals)
For ($j;1;Size of array:C274(DA_Finals))
	APPEND TO ARRAY:C911($SN3_Log_Fecha;SN3_Log_Fecha{DA_Finals{$j}})
	APPEND TO ARRAY:C911($SN3_Log_Hora;SN3_Log_Hora{DA_Finals{$j}})
	APPEND TO ARRAY:C911($SN3_Log_Descripcion;SN3_Log_Descripcion{DA_Finals{$j}})
	APPEND TO ARRAY:C911($SN3_Log_Colores;SN3_Log_Colores{DA_Finals{$j}})
	APPEND TO ARRAY:C911($SN3_Log_Estilos;SN3_Log_Estilos{DA_Finals{$j}})
	APPEND TO ARRAY:C911($SN3_Log_Tipo;SN3_Log_Tipo{DA_Finals{$j}})
	APPEND TO ARRAY:C911($SN3_Log_DescError;SN3_Log_DescError{DA_Finals{$j}})
	APPEND TO ARRAY:C911($SN3_Log_Maquina;SN3_Log_Maquina{DA_Finals{$j}})
End for 
ARRAY DATE:C224(SN3_Log_Fecha;0)
ARRAY LONGINT:C221(SN3_Log_Hora;0)
ARRAY TEXT:C222(SN3_Log_Descripcion;0)
ARRAY LONGINT:C221(SN3_Log_Colores;0)
ARRAY LONGINT:C221(SN3_Log_Estilos;0)
ARRAY LONGINT:C221(SN3_Log_Tipo;0)
ARRAY TEXT:C222(SN3_Log_DescError;0)
ARRAY TEXT:C222(SN3_Log_Maquina;0)
COPY ARRAY:C226($SN3_Log_Fecha;SN3_Log_Fecha)
COPY ARRAY:C226($SN3_Log_Hora;SN3_Log_Hora)
COPY ARRAY:C226($SN3_Log_Descripcion;SN3_Log_Descripcion)
COPY ARRAY:C226($SN3_Log_Colores;SN3_Log_Colores)
COPY ARRAY:C226($SN3_Log_Estilos;SN3_Log_Estilos)
COPY ARRAY:C226($SN3_Log_Tipo;SN3_Log_Tipo)
COPY ARRAY:C226($SN3_Log_DescError;SN3_Log_DescError)
COPY ARRAY:C226($SN3_Log_Maquina;SN3_Log_Maquina)

vFechaHeader:=0
vHoraHeader:=0
vEventoHeader:=0
vLastLinea:=-1
If ($date=!00-00-00!)
	vt_Log_Msg:=String:C10(Size of array:C274(SN3_Log_Tipo))+__ (" entradas de ")+String:C10(Size of array:C274(SN3_Log_TipoSN))+__ (" existentes.")
Else 
	vt_Log_Msg:=String:C10(Size of array:C274(SN3_Log_Tipo))+__ (" entradas del ")+String:C10($date;Internal date short:K1:7)+__ (" de ")+String:C10(Size of array:C274(SN3_Log_TipoSN))+__ (" existentes.")
End if 
IT_SetButtonState ((Size of array:C274(SN3_Log_Tipo)>0);->b_Log_Print;->b_Log_Save)
OBJECT SET TITLE:C194(cb_Log_VerGeneracion;__ ("Proceso de Archivos"))
OBJECT SET TITLE:C194(cb_Log_VerEnvios;__ ("Recepción de Archivos"))

