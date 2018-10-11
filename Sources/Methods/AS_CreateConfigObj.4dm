//%attributes = {}
  //AS_CreateConfigObj
  //Crear el objeto de configuración
  //Casos
  //1) Asignatura Nueva
  //2) Asignatura Existente, con registro de config en XshellFatObjects
  //3) Asignatura existente sin registro en XshellFatObjects
  //Contenido del Objeto Configuración
  //1) Configuraciones independientes de la consolidación
  //2) Nodo Consolidación Anual (Opcional) 
  //3) Nodos Consolidación por Periodo (Opcional)

C_LONGINT:C283($1;$id_asignatura;$vlAS_CalcMethod;$vi_DecimalesPonderacion;$vi_PonderacionTruncada;$vi_ConsolidaExamenFinal;$vi_ConsolidaNotasFinales)
C_LONGINT:C283($vl_configPer;$i_periodo)
C_TEXT:C284($t_NombreRegistroPropiedades;$t_nodo)
C_BOOLEAN:C305($b_crear;$2;$vb_actualizacion)

ARRAY TEXT:C222($atAS_EvalPropSourceName;0)  //destination name
ARRAY TEXT:C222($atAS_EvalPropClassName;0)  //destination class
ARRAY LONGINT:C221($alAS_EvalPropSourceID;0)  //id destination
ARRAY LONGINT:C221($aiAS_EvalPropEnterable;0)  //method
ARRAY REAL:C219($arAS_EvalPropPercent;0)  //grade weight
ARRAY REAL:C219($arAS_EvalPropCoefficient;0)  //coefficient
ARRAY BOOLEAN:C223($abAS_EvalPropPrintDetail;0)  //print on reports
ARRAY TEXT:C222($atAS_EvalPropPrintName;0)  //print as
ARRAY TEXT:C222($atAS_EvalPropDescription;0)  //description
ARRAY DATE:C224($adAS_EvalPropDueDate;0)  //due date 

ARRAY DATE:C224(ad_BloqueoParcial_p1;0)
ARRAY DATE:C224(ad_BloqueoParcial_p2;0)
ARRAY DATE:C224(ad_BloqueoParcial_p3;0)
ARRAY DATE:C224(ad_BloqueoParcial_p4;0)
ARRAY DATE:C224(ad_BloqueoParcial_p5;0)

ARRAY DATE:C224($ad_limiteParciales;0)  // limite de ingreso de parciales
ARRAY DATE:C224($ad_limiteParciales;12)

  //sin parámetros asumimos que utilizamos el que está en selección.
If (Count parameters:C259>=1)
	$id_asignatura:=$1
End if 
If (Count parameters:C259=2)
	$vb_actualizacion:=$2  //este parametro se utiliza sólo en la actualización de 11.12 a 12
	  //utilizaré este parámetro para forzar la creación del objeto también
End if 

If ($id_asignatura>0)
	READ WRITE:C146([Asignaturas:18])
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$id_asignatura)
End if 

If ([Asignaturas:18]Numero:1>0)
	PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)  //20170609 RCH Se estaba pasando mal el parámetro
	
	If (Not:C34(OB Is defined:C1231([Asignaturas:18]Configuracion:63)) | ($vb_actualizacion))  //Si el objeto no está definimos lo creamos y si lo estamos utilizando desde la actualización lo forzamos a crearlo nuevamente.
		[Asignaturas:18]Configuracion:63:=OB_Create 
	End if 
	
	  //Fecha límite de ingreso de parciales 
	For ($i_periodo;1;Size of array:C274(aiSTR_Periodos_Numero))
		$t_nodo:="LimiteIngresoParciales_P"+String:C10($i_periodo)
		If (Not:C34(OB Is defined:C1231([Asignaturas:18]Configuracion:63;$t_nodo)))
			OB_AppendNode ([Asignaturas:18]Configuracion:63;$t_nodo)
			OB_SET ([Asignaturas:18]Configuracion:63;->$ad_limiteParciales;$t_nodo;"DD/MM/YYYY")
		End if 
	End for 
	
	If ([Asignaturas:18]Consolidacion_PorPeriodo:58)
		
		For ($i_periodo;1;Size of array:C274(aiSTR_Periodos_Numero))
			$t_NombreRegistroPropiedades:="Blob_ConfigNotas/"+String:C10([Asignaturas:18]Numero:1)+"/P"+String:C10($i_periodo)
			$t_nodo:="P"+String:C10($i_periodo)
			
			If (Not:C34(OB Is defined:C1231([Asignaturas:18]Configuracion:63;$t_nodo)))
				$ob_nodo:=OB_AppendNode ([Asignaturas:18]Configuracion:63;$t_nodo)
				$b_crear:=True:C214
			End if 
			
			If ($b_crear)
				
				  //20170621 ASM Ticket 183892
				If ($vb_actualizacion)
					  //Ticket 184577 
					  // Modificado por: Alexis Bustamante, DL (04-07-2017)
					  //Cuando es Actualizacion se debe Leer el blob en donde se guardo la configuración en versiones 11.12
					READ ONLY:C145([XShell_FatObjects:86])
					QUERY:C277([XShell_FatObjects:86];[XShell_FatObjects:86]FatObjectName:1=$t_NombreRegistroPropiedades)
				Else 
					REDUCE SELECTION:C351([XShell_FatObjects:86];0)
				End if 
				
				If (Records in selection:C76([XShell_FatObjects:86])=0)
					ARRAY TEXT:C222($atAS_EvalPropSourceName;12)  //destination name
					ARRAY TEXT:C222($atAS_EvalPropClassName;12)  //destination class
					ARRAY LONGINT:C221($alAS_EvalPropSourceID;12)  //id destination
					ARRAY LONGINT:C221($aiAS_EvalPropEnterable;12)  //method
					ARRAY REAL:C219($arAS_EvalPropPercent;12)  //grade weight
					ARRAY REAL:C219($arAS_EvalPropCoefficient;12)  //coefficient
					ARRAY BOOLEAN:C223($abAS_EvalPropPrintDetail;12)  //print on reports
					ARRAY TEXT:C222($atAS_EvalPropPrintName;12)  //print as
					ARRAY TEXT:C222($atAS_EvalPropDescription;12)  //description
					ARRAY DATE:C224($adAS_EvalPropDueDate;12)  //due date 
					
					ARRAY DATE:C224(ad_BloqueoParcial_p1;0)
					ARRAY DATE:C224(ad_BloqueoParcial_p2;0)
					ARRAY DATE:C224(ad_BloqueoParcial_p3;0)
					ARRAY DATE:C224(ad_BloqueoParcial_p4;0)
					ARRAY DATE:C224(ad_BloqueoParcial_p5;0)
					
					For ($i;1;12)
						$atAS_EvalPropSourceName{$i}:="Evaluación ingresable"
						$alAS_EvalPropSourceID{$i}:=0
						$aiAS_EvalPropEnterable{$i}:=1
						$arAS_EvalPropCoefficient{$i}:=1
						If (Not:C34($abAS_EvalPropPrintDetail{$i}))
							$atAS_EvalPropPrintName{$i}:=""
						End if 
					End for 
					COPY ARRAY:C226($arAS_EvalPropCoefficient;$arAS_EvalPropPonderacion)
				Else 
					BLOB_Blob2Vars (->[XShell_FatObjects:86]BlobObject:2;0;->$alAS_EvalPropSourceID;->$atAS_EvalPropSourceName;->$atAS_EvalPropClassName;->$aiAS_EvalPropEnterable;->$arAS_EvalPropPercent;->$arAS_EvalPropCoefficient;->$abAS_EvalPropPrintDetail;->$atAS_EvalPropPrintName;->$vlAS_CalcMethod;->$atAS_EvalPropDescription;->$adAS_EvalPropDueDate;->$vi_DecimalesPonderacion;->$vi_PonderacionTruncada;->$vi_ConsolidaExamenFinal;->$vi_ConsolidaNotasFinales)
				End if 
				
				OB_SET ([Asignaturas:18]Configuracion:63;->$alAS_EvalPropSourceID;$t_nodo+".SourceID")
				OB_SET ([Asignaturas:18]Configuracion:63;->$atAS_EvalPropSourceName;$t_nodo+".SourceName")
				OB_SET ([Asignaturas:18]Configuracion:63;->$atAS_EvalPropClassName;$t_nodo+".ClassName")
				OB_SET ([Asignaturas:18]Configuracion:63;->$aiAS_EvalPropEnterable;$t_nodo+".Enterable")
				OB_SET ([Asignaturas:18]Configuracion:63;->$arAS_EvalPropPercent;$t_nodo+".Percent")
				OB_SET ([Asignaturas:18]Configuracion:63;->$arAS_EvalPropCoefficient;$t_nodo+".Coefficient")
				OB_SET ([Asignaturas:18]Configuracion:63;->$abAS_EvalPropPrintDetail;$t_nodo+".PrintDetail")
				OB_SET ([Asignaturas:18]Configuracion:63;->$atAS_EvalPropPrintName;$t_nodo+".PrintName")
				OB_SET ([Asignaturas:18]Configuracion:63;->$atAS_EvalPropDescription;$t_nodo+".Description")
				OB_SET ([Asignaturas:18]Configuracion:63;->$adAS_EvalPropDueDate;$t_nodo+".DueDate")
				
				OB_SET ([Asignaturas:18]Configuracion:63;->$vlAS_CalcMethod;$t_nodo+".CalcMethod")
				OB_SET ([Asignaturas:18]Configuracion:63;->$vi_DecimalesPonderacion;$t_nodo+".DecimalesPonderacion")
				OB_SET ([Asignaturas:18]Configuracion:63;->$vi_PonderacionTruncada;$t_nodo+".PonderacionTruncada")
				OB_SET ([Asignaturas:18]Configuracion:63;->$vi_ConsolidaExamenFinal;$t_nodo+".ConsolidaExamenFinal")
				OB_SET ([Asignaturas:18]Configuracion:63;->$vi_ConsolidaNotasFinales;$t_nodo+".ConsolidaNotasFinales")
				
				OB_SET ([Asignaturas:18]Configuracion:63;->ad_BloqueoParcial_p1;"LimiteIngresoParciales_P1")
				OB_SET ([Asignaturas:18]Configuracion:63;->ad_BloqueoParcial_p2;"LimiteIngresoParciales_P2")
				OB_SET ([Asignaturas:18]Configuracion:63;->ad_BloqueoParcial_p3;"LimiteIngresoParciales_P3")
				OB_SET ([Asignaturas:18]Configuracion:63;->ad_BloqueoParcial_p4;"LimiteIngresoParciales_P4")
				OB_SET ([Asignaturas:18]Configuracion:63;->ad_BloqueoParcial_p5;"LimiteIngresoParciales_P5")
				
			End if 
			
		End for 
		
	Else 
		
		$t_NombreRegistroPropiedades:="Blob_ConfigNotas/"+String:C10([Asignaturas:18]Numero:1)
		$t_nodo:="Anual"
		
		If (Not:C34(OB Is defined:C1231([Asignaturas:18]Configuracion:63;$t_nodo)))
			$ob_nodo:=OB_AppendNode ([Asignaturas:18]Configuracion:63;$t_nodo)
			$b_crear:=True:C214
		End if 
		
		If ($b_crear) | ($vb_actualizacion)
			  //20170621 ASM Ticket 183892
			If ($vb_actualizacion)
				  //Ticket 184577 
				  // Modificado por: Alexis Bustamante,DL (04-07-2017)
				  //Cuando es Actualizacion se debe Leer el blob en donde se guardo la configuración en versiones 11.12
				READ ONLY:C145([XShell_FatObjects:86])
				QUERY:C277([XShell_FatObjects:86];[XShell_FatObjects:86]FatObjectName:1=$t_NombreRegistroPropiedades)
			Else 
				REDUCE SELECTION:C351([XShell_FatObjects:86];0)
			End if 
			
			If (Records in selection:C76([XShell_FatObjects:86])=0)
				ARRAY TEXT:C222($atAS_EvalPropSourceName;12)  //destination name
				ARRAY TEXT:C222($atAS_EvalPropClassName;12)  //destination class
				ARRAY LONGINT:C221($alAS_EvalPropSourceID;12)  //id destination
				ARRAY LONGINT:C221($aiAS_EvalPropEnterable;12)  //method
				ARRAY REAL:C219($arAS_EvalPropPercent;12)  //grade weight
				ARRAY REAL:C219($arAS_EvalPropCoefficient;12)  //coefficient
				ARRAY BOOLEAN:C223($abAS_EvalPropPrintDetail;12)  //print on reports
				ARRAY TEXT:C222($atAS_EvalPropPrintName;12)  //print as
				ARRAY TEXT:C222($atAS_EvalPropDescription;12)  //description
				ARRAY DATE:C224($adAS_EvalPropDueDate;12)  //due date 
				
				ARRAY DATE:C224(ad_BloqueoParcial_p1;0)
				ARRAY DATE:C224(ad_BloqueoParcial_p2;0)
				ARRAY DATE:C224(ad_BloqueoParcial_p3;0)
				ARRAY DATE:C224(ad_BloqueoParcial_p4;0)
				ARRAY DATE:C224(ad_BloqueoParcial_p5;0)
				
				For ($i;1;12)
					$atAS_EvalPropSourceName{$i}:="Evaluación ingresable"
					$alAS_EvalPropSourceID{$i}:=0
					$aiAS_EvalPropEnterable{$i}:=1
					$arAS_EvalPropCoefficient{$i}:=1
					If (Not:C34($abAS_EvalPropPrintDetail{$i}))
						$atAS_EvalPropPrintName{$i}:=""
					End if 
				End for 
				COPY ARRAY:C226($arAS_EvalPropCoefficient;$arAS_EvalPropPonderacion)
			Else 
				BLOB_Blob2Vars (->[XShell_FatObjects:86]BlobObject:2;0;->$alAS_EvalPropSourceID;->$atAS_EvalPropSourceName;->$atAS_EvalPropClassName;->$aiAS_EvalPropEnterable;->$arAS_EvalPropPercent;->$arAS_EvalPropCoefficient;->$abAS_EvalPropPrintDetail;->$atAS_EvalPropPrintName;->$vlAS_CalcMethod;->$atAS_EvalPropDescription;->$adAS_EvalPropDueDate;->$vi_DecimalesPonderacion;->$vi_PonderacionTruncada;->$vi_ConsolidaExamenFinal;->$vi_ConsolidaNotasFinales)
			End if 
			
			OB_SET ([Asignaturas:18]Configuracion:63;->$alAS_EvalPropSourceID;$t_nodo+".SourceID")
			OB_SET ([Asignaturas:18]Configuracion:63;->$atAS_EvalPropSourceName;$t_nodo+".SourceName")
			OB_SET ([Asignaturas:18]Configuracion:63;->$atAS_EvalPropClassName;$t_nodo+".ClassName")
			OB_SET ([Asignaturas:18]Configuracion:63;->$aiAS_EvalPropEnterable;$t_nodo+".Enterable")
			OB_SET ([Asignaturas:18]Configuracion:63;->$arAS_EvalPropPercent;$t_nodo+".Percent")
			OB_SET ([Asignaturas:18]Configuracion:63;->$arAS_EvalPropCoefficient;$t_nodo+".Coefficient")
			OB_SET ([Asignaturas:18]Configuracion:63;->$abAS_EvalPropPrintDetail;$t_nodo+".PrintDetail")
			OB_SET ([Asignaturas:18]Configuracion:63;->$atAS_EvalPropPrintName;$t_nodo+".PrintName")
			OB_SET ([Asignaturas:18]Configuracion:63;->$atAS_EvalPropDescription;$t_nodo+".Description")
			OB_SET ([Asignaturas:18]Configuracion:63;->$adAS_EvalPropDueDate;$t_nodo+".DueDate";"DD/MM/YYYY")
			
			OB_SET ([Asignaturas:18]Configuracion:63;->$vlAS_CalcMethod;$t_nodo+".CalcMethod")
			OB_SET ([Asignaturas:18]Configuracion:63;->$vi_DecimalesPonderacion;$t_nodo+".DecimalesPonderacion")
			OB_SET ([Asignaturas:18]Configuracion:63;->$vi_PonderacionTruncada;$t_nodo+".PonderacionTruncada")
			OB_SET ([Asignaturas:18]Configuracion:63;->$vi_ConsolidaExamenFinal;$t_nodo+".ConsolidaExamenFinal")
			OB_SET ([Asignaturas:18]Configuracion:63;->$vi_ConsolidaNotasFinales;$t_nodo+".ConsolidaNotasFinales")
			
			OB_SET ([Asignaturas:18]Configuracion:63;->ad_BloqueoParcial_p1;"LimiteIngresoParciales_P1")
			OB_SET ([Asignaturas:18]Configuracion:63;->ad_BloqueoParcial_p2;"LimiteIngresoParciales_P2")
			OB_SET ([Asignaturas:18]Configuracion:63;->ad_BloqueoParcial_p3;"LimiteIngresoParciales_P3")
			OB_SET ([Asignaturas:18]Configuracion:63;->ad_BloqueoParcial_p4;"LimiteIngresoParciales_P4")
			OB_SET ([Asignaturas:18]Configuracion:63;->ad_BloqueoParcial_p5;"LimiteIngresoParciales_P5")
		End if 
		
	End if 
	
	If ($id_asignatura>0)
		C_OBJECT:C1216($objeto)
		$objeto:=[Asignaturas:18]Configuracion:63
		[Asignaturas:18]Configuracion:63:=$objeto
		SAVE RECORD:C53([Asignaturas:18])
		KRL_UnloadReadOnly (->[Asignaturas:18])
	End if 
End if 

