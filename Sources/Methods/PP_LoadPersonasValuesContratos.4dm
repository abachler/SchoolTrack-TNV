//%attributes = {}
  //PP_LoadPersonasValuesContratos

  // $1 .- PRIMER PARAMETRO DEFINE QUE ES LO QUE DEBE DEVOLVER EL METODO
  //Parametro=0 Devuelve la cantidad de cuotas.
  //Parametro=1 Devuelve el Total Proyectado en Pesos (Anual)
  //Parametro=2 Devuelve el Total Proyectado en Moneda (Anual)
  //Parametro=-1 DEvuelve el Valor de la Cuota Mensual en Pesos
  //Parametro=-2 DEvuelve el Valor de la Cuota Mensual en Moneda
  //Parametro=3 Devuelve lista de cuotas Pesos con dia y mes de vencimientos, debe indicarse el día en $2
  //Parametro=4 Devuelve lista de cuotas Moneda con dia y mes de vencimientos, debe indicarse el día en $2

  //$2.- Dia de vencimiento de la cuota
C_LONGINT:C283($2)
SET BLOB SIZE:C606(xBlob;0)
ARRAY REAL:C219(arACT_ValorMoneda;0)
ARRAY TEXT:C222(atACT_SimboloMoneda;0)
ARRAY TEXT:C222(atACT_NombreMoneda;0)
xBlob:=PREF_fGetBlob (0;"ACT_Monedas";xBlob)
BLOB_Blob2Vars (->xBlob;0;->atACT_NombreMoneda;->arACT_ValorMoneda;->atACT_SimboloMoneda)
SET BLOB SIZE:C606(xBlob;0)
If (Size of array:C274(atACT_NombreMoneda)=0)
	LIST TO ARRAY:C288("ACT_Monedas";atACT_NombreMoneda)
	SET BLOB SIZE:C606(xBlob;0)
	ARRAY TEXT:C222(atACT_NombreMoneda;0)
	ARRAY REAL:C219(arACT_ValorMoneda;0)
	ARRAY TEXT:C222(atACT_SimboloMoneda;0)
	BLOB_Blob2Vars (->xBlob;0;->atACT_NombreMoneda;->arACT_ValorMoneda;->atACT_SimboloMoneda)
	PREF_SetBlob (0;"ACT_Monedas";xBlob)
	SET BLOB SIZE:C606(xBlob;0)
End if 


C_TEXT:C284($0)
If (Count parameters:C259#0)
	ACT_relacionaCtasyApdos (2)
	LOAD RECORD:C52([Personas:7])
	ORDER BY:C49([ACT_CuentasCorrientes:175];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>)
	FIRST RECORD:C50([ACT_CuentasCorrientes:175])
	
	ARRAY REAL:C219(arACT_CCProyectadomesMoneda;0)
	ARRAY REAL:C219(arACT_CCProyectadomesPesos;0)
	ARRAY TEXT:C222(atACT_CCFechaMes;0)
	ARRAY TEXT:C222(atACT_Simbolo;0)
	C_TEXT:C284($TipoMoneda)
	C_LONGINT:C283($idxMoneda)
	C_TEXT:C284($vtGlosaGral)
	READ ONLY:C145([Alumnos:2])
	READ ONLY:C145([ACT_Apoderados_de_Cuenta:107])
	READ ONLY:C145([ACT_Pagos:172])
	
	  //Buscar ID de los items que contengan la palabra Colegiatura
	ARRAY TEXT:C222(atACT_GlosaItemsGral;0)
	ARRAY LONGINT:C221(alACT_IDItemsGral;0)
	ARRAY LONGINT:C221(alACT_IDItemsBuscados;0)
	READ ONLY:C145([xxACT_Items:179])
	ALL RECORDS:C47([xxACT_Items:179])
	SELECTION TO ARRAY:C260([xxACT_Items:179]Glosa:2;atACT_GlosaItemsGral;[xxACT_Items:179]ID:1;alACT_IDItemsGral)
	$line:=Size of array:C274(alACT_IDItemsGral)
	For ($j;1;$line)
		$vtGlosaGral:=atACT_GlosaItemsGral{$j}
		If (Position:C15("Colegiatura";$vtGlosaGral)>0)
			AT_Insert (0;1;->alACT_IDItemsBuscados)
			alACT_IDItemsBuscados{Size of array:C274(alACT_IDItemsBuscados)}:=alACT_IDItemsGral{$j}
		End if 
	End for 
	
	ARRAY TEXT:C222(atACT_CCAlumno;0)
	ARRAY TEXT:C222(atACT_CCCurso;0)
	For ($x;1;Records in selection:C76([ACT_CuentasCorrientes:175]))
		AT_Insert (0;1;->atACT_CCAlumno;->atACT_CCCurso)
		$alumnoactivo:=[ACT_CuentasCorrientes:175]Estado:4
		If ($alumnoactivo=True:C214)
			QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
			atACT_CCAlumno{Size of array:C274(atACT_CCAlumno)}:=[Alumnos:2]apellidos_y_nombres:40
			atACT_CCCurso{Size of array:C274(atACT_CCCurso)}:=[Alumnos:2]curso:20
		End if 
		
		NEXT RECORD:C51([ACT_CuentasCorrientes:175])
	End for 
	
	For ($i;1;12)
		AT_Insert (0;1;->arACT_CCProyectadomesMoneda;->arACT_CCProyectadomesPesos;->atACT_CCFechaMes;->atACT_Simbolo)
		ARRAY REAL:C219(arACT_CCProyectadoEjercicio;0)
		ARRAY REAL:C219(arACT_CCProyectadoCtaCte;0)
		FIRST RECORD:C50([ACT_CuentasCorrientes:175])
		For ($o;1;Records in selection:C76([ACT_CuentasCorrientes:175]))
			
			AT_Insert (0;1;->arACT_CCProyectadoEjercicio;->arACT_CCProyectadoCtaCte)
			vdFechaCargoFin:=DT_GetDateFromDayMonthYear (31;12;Year of:C25(Current date:C33(*)))
			vdFechaCargoIni:=DT_GetDateFromDayMonthYear (1;1;Year of:C25(Current date:C33(*)))
			
			QRY_QueryWithArray (->[ACT_Cargos:173]Ref_Item:16;->alACT_IDItemsBuscados)
			CREATE SET:C116([ACT_Cargos:173];"todos")
			
			USE SET:C118("todos")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1)
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=[Personas:7]No:1)
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_generacion:4;>=;vdFechaCargoIni)
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_generacion:4;<=;vdFechaCargoFin)
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Mes:13;=;$i)
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]EsRelativo:10=False:C215)
			  //Valor en Moneda a pagar en un mes por una cuenta corriente
			arACT_CCProyectadoCtaCte{Size of array:C274(arACT_CCProyectadoCtaCte)}:=Sum:C1([ACT_Cargos:173]Monto_Moneda:9)
			
			$TipoMoneda:=[ACT_Cargos:173]Moneda:28
			  //Valor en Pesos a pagar en un mes por una cuenta corriente
			arACT_CCProyectadoEjercicio{Size of array:C274(arACT_CCProyectadoEjercicio)}:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
			
			If (Count parameters:C259=2)
				If (Records in selection:C76([ACT_Cargos:173])#0)
					$mes:=[ACT_Cargos:173]Mes:13
				Else 
					$mes:=1
				End if 
				atACT_CCFechaMes{Size of array:C274(atACT_CCFechaMes)}:=String:C10($2)+" de "+<>atXS_MonthNames{$mes}
			End if 
			
			NEXT RECORD:C51([ACT_CuentasCorrientes:175])
		End for 
		
		$idxMoneda:=Find in array:C230(atACT_NombreMoneda;$TipoMoneda)
		If ($idxMoneda#-1)
			atACT_Simbolo{Size of array:C274(atACT_Simbolo)}:=atACT_SimboloMoneda{$idxMoneda}
		End if 
		  //Valor en Moneda a pagar por un mes por todas las cuentas corrientes
		arACT_CCProyectadomesMoneda{Size of array:C274(arACT_CCProyectadomesMoneda)}:=AT_GetSumArray (->arACT_CCProyectadoCtaCte)
		  //Valor en Pesos a pagar por un mes por todas las cuentas corrientes
		arACT_CCProyectadomesPesos{Size of array:C274(arACT_CCProyectadomesPesos)}:=AT_GetSumArray (->arACT_CCProyectadoEjercicio)
		
	End for 
	CLEAR SET:C117("todos")
	  //TRACE
	C_TEXT:C284(vtListaCuotasPesos)
	C_TEXT:C284(vtListaCuotasMoneda)
	C_TEXT:C284(vtListaMeses)
	vtListaCuotasPesos:=""
	vtListaCuotasMoneda:=""
	vtListaMeses:=""
	For ($x;Size of array:C274(arACT_CCProyectadomesPesos);1;-1)
		If (arACT_CCProyectadomesPesos{$x}=0)
			AT_Delete ($x;1;->arACT_CCProyectadomesPesos;->atACT_CCFechaMes)
		End if 
	End for 
	
	For ($x;Size of array:C274(arACT_CCProyectadomesMoneda);1;-1)
		If (arACT_CCProyectadomesMoneda{$x}=0)
			AT_Delete ($x;1;->arACT_CCProyectadomesMoneda;->atACT_Simbolo)
		End if 
	End for 
	
	For ($x;1;Size of array:C274(arACT_CCProyectadomesMoneda))
		vtListaCuotasMoneda:=vtListaCuotasMoneda+String:C10($x)+".-"+"\t"+atACT_CCFechaMes{$x}+"\t"+atACT_Simbolo{$x}+" "+String:C10(arACT_CCProyectadomesMoneda{$x};"|Despliegue_UF")+"\r"
	End for 
	
	For ($x;1;Size of array:C274(arACT_CCProyectadomesPesos))
		vtListaCuotasPesos:=vtListaCuotasPesos+String:C10($x)+".-"+"\t"+atACT_CCFechaMes{$x}+"\t"+"$ "+String:C10(arACT_CCProyectadomesPesos{$x};"|Despliegue_ACT")+"\r"
	End for 
	
	
	
	C_REAL:C285(vrACT_Total_ProyectadoPesos)
	C_REAL:C285(vrACT_Total_ProyectadoMoneda)
	C_LONGINT:C283(vlCuotasPesos)
	C_LONGINT:C283(vlCuotasMoneda)
	C_REAL:C285(vrACT_ValorCuotaPesos)
	C_REAL:C285(vrACT_ValorCuotaMoneda)
	
	
	vrACT_Total_ProyectadoPesos:=AT_GetSumArray (->arACT_CCProyectadomesPesos)
	vrACT_Total_ProyectadoMoneda:=AT_GetSumArray (->arACT_CCProyectadomesMoneda)
	vlCuotasPesos:=Size of array:C274(arACT_CCProyectadomesPesos)
	vlCuotasMoneda:=Size of array:C274(arACT_CCProyectadomesMoneda)
	vrACT_ValorCuotaPesos:=vrACT_Total_ProyectadoPesos/vlCuotasPesos
	vrACT_ValorCuotaMoneda:=vrACT_Total_ProyectadoMoneda/vlCuotasMoneda
	
	
	Case of 
			
		: ($1=0)
			$0:=String:C10(vlCuotasPesos)
		: ($1=1)
			$0:=String:C10(vrACT_Total_ProyectadoPesos;"|Despliegue_ACT")
		: ($1=2)
			$0:=String:C10(vrACT_Total_ProyectadoMoneda;"|Despliegue_UF")
		: ($1=-1)
			$0:=String:C10(vrACT_ValorCuotaPesos;"|Despliegue_ACT")
		: ($1=-2)
			$0:=String:C10(vrACT_ValorCuotaMoneda;"|Despliegue_UF")
		: ($1=3)
			$0:=vtListaCuotasPesos
		: ($1=4)
			$0:=vtListaCuotasMoneda
	End case 
	
End if 



