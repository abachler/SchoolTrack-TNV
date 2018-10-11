//%attributes = {}
  //ACTinit_CreateUFTables
C_REAL:C285($0;$vr_ultimoValor)
C_LONGINT:C283($accountTrackIsInitialized)
C_LONGINT:C283($i)
C_DATE:C307($vd_Fecha)
C_LONGINT:C283($proc)

$accountTrackIsInitialized:=Num:C11(PREF_fGet (0;"ACT_Inicializado";"0"))
If ($accountTrackIsInitialized=1)
	If (<>vtXS_CountryCode="cl")
		$proc:=IT_UThermometer (1;0;"Actualizando valores de IPC y UF...")
		C_BLOB:C604(xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		
		ARRAY INTEGER:C220(aiACT_YearIPC;12)
		ARRAY TEXT:C222(atACT_MesIPC;12)
		ARRAY REAL:C219(arACT_VariacionIPC;12)
		ARRAY REAL:C219(arACT_UFReferencia;12)
		COPY ARRAY:C226(<>atXS_MonthNames;atACT_MesIPC)
		
		  // creando tabla IPC para 2001
		For ($i;1;Size of array:C274(aiACT_YearIPC))
			aiACT_YearIPC{$i}:=2001
		End for 
		arACT_VariacionIPC{1}:=0.3  // variacin IPC
		arACT_VariacionIPC{2}:=-0.3
		arACT_VariacionIPC{3}:=0.5
		arACT_VariacionIPC{4}:=0.5
		arACT_VariacionIPC{5}:=0.4
		arACT_VariacionIPC{6}:=0.1
		arACT_VariacionIPC{7}:=-0.2
		arACT_VariacionIPC{8}:=0.8
		arACT_VariacionIPC{9}:=0.7
		arACT_VariacionIPC{10}:=0.1
		arACT_VariacionIPC{11}:=0
		arACT_VariacionIPC{12}:=-0.3
		arACT_UFReferencia{1}:=15783.64  //UF de referencia
		arACT_UFReferencia{2}:=15799.42
		arACT_UFReferencia{3}:=15846.82
		arACT_UFReferencia{4}:=15799.28
		arACT_UFReferencia{5}:=15878.28
		arACT_UFReferencia{6}:=15957.67
		arACT_UFReferencia{7}:=16021.5
		arACT_UFReferencia{8}:=16037.52
		arACT_UFReferencia{9}:=16005.44
		arACT_UFReferencia{10}:=16133.48
		arACT_UFReferencia{11}:=16246.41
		arACT_UFReferencia{12}:=16262.66
		SET BLOB SIZE:C606(xBlob;0)
		BLOB_Variables2Blob (->xBlob;0;->aiACT_YearIPC;->atACT_MesIPC;->arACT_VariacionIPC;->arACT_UFReferencia)
		  //PREF_SetBlob (0;"ACT_IPC "+String(2001);xBlob)
		PREF_fGetBlob (0;"ACT_IPC "+String:C10(2001);xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		
		  // creando tabla IPC para 2002
		For ($i;1;Size of array:C274(aiACT_YearIPC))
			aiACT_YearIPC{$i}:=2002
		End for 
		arACT_VariacionIPC{1}:=-0.1  // variacin IPC
		arACT_VariacionIPC{2}:=0
		arACT_VariacionIPC{3}:=0.5
		arACT_VariacionIPC{4}:=0.4
		arACT_VariacionIPC{5}:=0.1
		arACT_VariacionIPC{6}:=-0.1
		arACT_VariacionIPC{7}:=0.4
		arACT_VariacionIPC{8}:=0.4
		arACT_VariacionIPC{9}:=0.8
		arACT_VariacionIPC{10}:=0.9
		arACT_VariacionIPC{11}:=-0.1
		arACT_VariacionIPC{12}:=-0.4
		arACT_UFReferencia{1}:=16262.66  //UF de referencia
		arACT_UFReferencia{2}:=16213.87
		arACT_UFReferencia{3}:=16197.66
		arACT_UFReferencia{4}:=16197.66
		arACT_UFReferencia{5}:=16278.65
		arACT_UFReferencia{6}:=16343.76
		arACT_UFReferencia{7}:=16360.1
		arACT_UFReferencia{8}:=16343.74
		arACT_UFReferencia{9}:=16409.11
		arACT_UFReferencia{10}:=16474.75
		arACT_UFReferencia{11}:=16606.55
		arACT_UFReferencia{12}:=16756.01
		SET BLOB SIZE:C606(xBlob;0)
		BLOB_Variables2Blob (->xBlob;0;->aiACT_YearIPC;->atACT_MesIPC;->arACT_VariacionIPC;->arACT_UFReferencia)
		  //PREF_SetBlob (0;"ACT_IPC "+String(2002);xBlob)
		PREF_fGetBlob (0;"ACT_IPC "+String:C10(2002);xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		
		  // creando tabla IPC para 2003
		For ($i;1;Size of array:C274(arACT_VariacionIPC))
			aiACT_YearIPC{$i}:=2003
		End for 
		arACT_VariacionIPC{1}:=0.1  // variacin IPC
		arACT_VariacionIPC{2}:=0.8
		arACT_VariacionIPC{3}:=1.2
		arACT_VariacionIPC{4}:=-0.1
		arACT_VariacionIPC{5}:=-0.4
		arACT_VariacionIPC{6}:=0
		arACT_VariacionIPC{7}:=-0.1
		arACT_VariacionIPC{8}:=0.2
		arACT_VariacionIPC{9}:=0.2
		arACT_VariacionIPC{10}:=-0.2
		arACT_VariacionIPC{11}:=-0.3
		arACT_VariacionIPC{12}:=-0.3
		arACT_UFReferencia{1}:=16739.25
		arACT_UFReferencia{2}:=16672.29
		arACT_UFReferencia{3}:=16688.96
		arACT_UFReferencia{4}:=16822.47
		arACT_UFReferencia{5}:=17024.34
		arACT_UFReferencia{6}:=17007.32
		arACT_UFReferencia{7}:=16939.29
		arACT_UFReferencia{8}:=16939.29
		arACT_UFReferencia{9}:=16922.35
		arACT_UFReferencia{10}:=16956.19
		arACT_UFReferencia{11}:=16990.1
		arACT_UFReferencia{12}:=16956.12
		SET BLOB SIZE:C606(xBlob;0)
		BLOB_Variables2Blob (->xBlob;0;->aiACT_YearIPC;->atACT_MesIPC;->arACT_VariacionIPC;->arACT_UFReferencia)
		  //PREF_SetBlob (0;"ACT_IPC "+String(2003);xBlob)
		PREF_fGetBlob (0;"ACT_IPC "+String:C10(2003);xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		
		  // creando tabla IPC para 2004
		ARRAY REAL:C219(arACT_VariacionIPC;0)
		ARRAY REAL:C219(arACT_UFReferencia;0)
		ARRAY REAL:C219(arACT_VariacionIPC;12)
		ARRAY REAL:C219(arACT_UFReferencia;12)
		For ($i;1;Size of array:C274(arACT_VariacionIPC))
			aiACT_YearIPC{$i}:=2004
		End for 
		arACT_VariacionIPC{1}:=-0.2  // variacin IPC
		arACT_VariacionIPC{2}:=0
		arACT_VariacionIPC{3}:=0.4
		arACT_VariacionIPC{4}:=0.4
		arACT_VariacionIPC{5}:=0.5
		arACT_VariacionIPC{6}:=0.4
		arACT_VariacionIPC{7}:=0.2
		arACT_VariacionIPC{8}:=0.4
		arACT_VariacionIPC{9}:=0.1
		arACT_VariacionIPC{10}:=0.3
		arACT_VariacionIPC{11}:=0.3
		arACT_VariacionIPC{12}:=-0.4
		arACT_UFReferencia{1}:=16905.25
		arACT_UFReferencia{2}:=16854.53
		arACT_UFReferencia{3}:=16820.82
		arACT_UFReferencia{4}:=16820.82
		arACT_UFReferencia{5}:=16888.1
		arACT_UFReferencia{6}:=16955.65
		arACT_UFReferencia{7}:=17040.43
		arACT_UFReferencia{8}:=17108.59
		arACT_UFReferencia{9}:=17142.81
		arACT_UFReferencia{10}:=17211.38
		arACT_UFReferencia{11}:=17228.59
		arACT_UFReferencia{12}:=17280.28
		SET BLOB SIZE:C606(xBlob;0)
		BLOB_Variables2Blob (->xBlob;0;->aiACT_YearIPC;->atACT_MesIPC;->arACT_VariacionIPC;->arACT_UFReferencia)
		  //PREF_SetBlob (0;"ACT_IPC "+String(2004);xBlob)
		PREF_fGetBlob (0;"ACT_IPC "+String:C10(2004);xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		
		ARRAY REAL:C219(arACT_VariacionIPC;0)
		ARRAY REAL:C219(arACT_UFReferencia;0)
		ARRAY REAL:C219(arACT_VariacionIPC;12)
		ARRAY REAL:C219(arACT_UFReferencia;12)
		For ($i;1;Size of array:C274(arACT_VariacionIPC))
			aiACT_YearIPC{$i}:=2005
		End for 
		arACT_VariacionIPC{1}:=-0.3  // variacin IPC
		arACT_VariacionIPC{2}:=-0.1
		arACT_VariacionIPC{3}:=0.6
		arACT_VariacionIPC{4}:=0.9
		arACT_VariacionIPC{5}:=0.3
		arACT_VariacionIPC{6}:=0.4
		arACT_VariacionIPC{7}:=0.6
		arACT_VariacionIPC{8}:=0.3
		arACT_VariacionIPC{9}:=1
		arACT_VariacionIPC{10}:=0.5
		arACT_VariacionIPC{11}:=-0.2
		arACT_VariacionIPC{12}:=-0.3
		arACT_UFReferencia{1}:=17332.12
		arACT_UFReferencia{2}:=17262.79
		arACT_UFReferencia{3}:=17211
		arACT_UFReferencia{4}:=17193.79
		arACT_UFReferencia{5}:=17296.95
		arACT_UFReferencia{6}:=17452.62
		arACT_UFReferencia{7}:=17504.98
		arACT_UFReferencia{8}:=17575
		arACT_UFReferencia{9}:=17680.45
		arACT_UFReferencia{10}:=17733.49
		arACT_UFReferencia{11}:=17910.82
		arACT_UFReferencia{12}:=18000.37
		SET BLOB SIZE:C606(xBlob;0)
		BLOB_Variables2Blob (->xBlob;0;->aiACT_YearIPC;->atACT_MesIPC;->arACT_VariacionIPC;->arACT_UFReferencia)
		  //PREF_SetBlob (0;"ACT_IPC "+String(2005);xBlob)
		PREF_fGetBlob (0;"ACT_IPC "+String:C10(2005);xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		
		ARRAY REAL:C219(arACT_VariacionIPC;0)
		ARRAY REAL:C219(arACT_UFReferencia;0)
		ARRAY REAL:C219(arACT_VariacionIPC;12)
		ARRAY REAL:C219(arACT_UFReferencia;12)
		For ($i;1;Size of array:C274(arACT_VariacionIPC))
			aiACT_YearIPC{$i}:=2006
		End for 
		arACT_VariacionIPC{1}:=0.1  // variacin IPC
		arACT_VariacionIPC{2}:=-0.1
		arACT_VariacionIPC{3}:=0.6
		arACT_VariacionIPC{4}:=0.6
		arACT_VariacionIPC{5}:=0.2
		arACT_VariacionIPC{6}:=0.6
		arACT_VariacionIPC{7}:=0.5
		arACT_VariacionIPC{8}:=0.3
		arACT_VariacionIPC{9}:=0
		arACT_VariacionIPC{10}:=-0.3
		arACT_VariacionIPC{11}:=-0.2
		arACT_VariacionIPC{12}:=0.1
		
		arACT_UFReferencia{1}:=17964.37
		arACT_UFReferencia{2}:=17910.48
		arACT_UFReferencia{3}:=17928.39
		arACT_UFReferencia{4}:=17910.46
		arACT_UFReferencia{5}:=18017.92
		arACT_UFReferencia{6}:=18126.03
		arACT_UFReferencia{7}:=18162.28
		arACT_UFReferencia{8}:=18271.25
		arACT_UFReferencia{9}:=18362.61
		arACT_UFReferencia{10}:=18417.7
		arACT_UFReferencia{11}:=18417.7
		arACT_UFReferencia{12}:=18362.45
		
		SET BLOB SIZE:C606(xBlob;0)
		BLOB_Variables2Blob (->xBlob;0;->aiACT_YearIPC;->atACT_MesIPC;->arACT_VariacionIPC;->arACT_UFReferencia)
		  //PREF_SetBlob (0;"ACT_IPC "+String(2006);xBlob)
		PREF_fGetBlob (0;"ACT_IPC "+String:C10(2006);xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		
		ARRAY REAL:C219(arACT_VariacionIPC;0)
		ARRAY REAL:C219(arACT_UFReferencia;0)
		ARRAY REAL:C219(arACT_VariacionIPC;12)
		ARRAY REAL:C219(arACT_UFReferencia;12)
		For ($i;1;Size of array:C274(arACT_VariacionIPC))
			aiACT_YearIPC{$i}:=2007
		End for 
		arACT_VariacionIPC{1}:=0.3  // variacin IPC
		arACT_VariacionIPC{2}:=-0.2
		arACT_VariacionIPC{3}:=0.4
		arACT_VariacionIPC{4}:=0.6
		arACT_VariacionIPC{5}:=0.6
		arACT_VariacionIPC{6}:=0.9
		arACT_VariacionIPC{7}:=1.1
		arACT_VariacionIPC{8}:=1.1
		arACT_VariacionIPC{9}:=1.1
		arACT_VariacionIPC{10}:=0.3
		arACT_VariacionIPC{11}:=0.8
		arACT_VariacionIPC{12}:=0.5
		
		arACT_UFReferencia{1}:=18325.73
		arACT_UFReferencia{2}:=18344.06
		arACT_UFReferencia{3}:=18399.09
		arACT_UFReferencia{4}:=18362.29
		arACT_UFReferencia{5}:=18435.74
		arACT_UFReferencia{6}:=18546.35
		arACT_UFReferencia{7}:=18657.63
		arACT_UFReferencia{8}:=18255.5
		arACT_UFReferencia{9}:=19032.63
		arACT_UFReferencia{10}:=19241.99
		arACT_UFReferencia{11}:=19453.65
		arACT_UFReferencia{12}:=19512.01
		
		SET BLOB SIZE:C606(xBlob;0)
		BLOB_Variables2Blob (->xBlob;0;->aiACT_YearIPC;->atACT_MesIPC;->arACT_VariacionIPC;->arACT_UFReferencia)
		  //PREF_SetBlob (0;"ACT_IPC "+String(2007);xBlob)
		PREF_fGetBlob (0;"ACT_IPC "+String:C10(2007);xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		
		ARRAY REAL:C219(arACT_VariacionIPC;0)
		ARRAY REAL:C219(arACT_UFReferencia;0)
		ARRAY REAL:C219(arACT_VariacionIPC;12)
		ARRAY REAL:C219(arACT_UFReferencia;12)
		For ($i;1;Size of array:C274(arACT_VariacionIPC))
			aiACT_YearIPC{$i}:=2008
		End for 
		arACT_VariacionIPC{1}:=0  // variacin IPC
		arACT_VariacionIPC{2}:=0.4
		arACT_VariacionIPC{3}:=0.8
		arACT_VariacionIPC{4}:=0.4
		arACT_VariacionIPC{5}:=1.2
		arACT_VariacionIPC{6}:=1.5
		arACT_VariacionIPC{7}:=1.1
		arACT_VariacionIPC{8}:=0.9
		arACT_VariacionIPC{9}:=1.1
		arACT_VariacionIPC{10}:=0.9
		arACT_VariacionIPC{11}:=-0.1
		arACT_VariacionIPC{12}:=-1.2
		
		arACT_UFReferencia{1}:=19668.11
		arACT_UFReferencia{2}:=19766.45
		arACT_UFReferencia{3}:=19766.45
		arACT_UFReferencia{4}:=19845.52
		arACT_UFReferencia{5}:=20004.28
		arACT_UFReferencia{6}:=20084.3
		arACT_UFReferencia{7}:=20325.31
		arACT_UFReferencia{8}:=20630.19
		arACT_UFReferencia{9}:=20857.12
		arACT_UFReferencia{10}:=21044.83
		arACT_UFReferencia{11}:=21276.32
		arACT_UFReferencia{12}:=21467.81
		
		SET BLOB SIZE:C606(xBlob;0)
		BLOB_Variables2Blob (->xBlob;0;->aiACT_YearIPC;->atACT_MesIPC;->arACT_VariacionIPC;->arACT_UFReferencia)
		  //PREF_SetBlob (0;"ACT_IPC "+String(2008);xBlob)
		PREF_fGetBlob (0;"ACT_IPC "+String:C10(2008);xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		
		ARRAY REAL:C219(arACT_VariacionIPC;0)
		ARRAY REAL:C219(arACT_UFReferencia;0)
		ARRAY REAL:C219(arACT_VariacionIPC;12)
		ARRAY REAL:C219(arACT_UFReferencia;12)
		For ($i;1;Size of array:C274(arACT_VariacionIPC))
			aiACT_YearIPC{$i}:=2009
		End for 
		arACT_VariacionIPC{1}:=-0.8  // variacin IPC
		arACT_VariacionIPC{2}:=-0.4
		arACT_VariacionIPC{3}:=0.4
		arACT_VariacionIPC{4}:=-0.2
		arACT_VariacionIPC{5}:=-0.3
		arACT_VariacionIPC{6}:=0.3
		arACT_VariacionIPC{7}:=-0.4
		arACT_VariacionIPC{8}:=-0.4
		arACT_VariacionIPC{9}:=1
		arACT_VariacionIPC{10}:=0
		arACT_VariacionIPC{11}:=-0.5
		arACT_VariacionIPC{12}:=-0.3
		
		arACT_UFReferencia{1}:=21446.34
		arACT_UFReferencia{2}:=21188.98
		arACT_UFReferencia{3}:=21019.47
		arACT_UFReferencia{4}:=20935.39
		arACT_UFReferencia{5}:=21019.13
		arACT_UFReferencia{6}:=20977.09
		arACT_UFReferencia{7}:=20914.16
		arACT_UFReferencia{8}:=20976.9
		arACT_UFReferencia{9}:=20892.99
		arACT_UFReferencia{10}:=20809.42
		arACT_UFReferencia{11}:=21017.51
		arACT_UFReferencia{12}:=21017.51
		
		SET BLOB SIZE:C606(xBlob;0)
		BLOB_Variables2Blob (->xBlob;0;->aiACT_YearIPC;->atACT_MesIPC;->arACT_VariacionIPC;->arACT_UFReferencia)
		  //PREF_SetBlob (0;"ACT_IPC "+String(2009);xBlob)
		PREF_fGetBlob (0;"ACT_IPC "+String:C10(2009);xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		
		ARRAY REAL:C219(arACT_VariacionIPC;0)
		ARRAY REAL:C219(arACT_UFReferencia;0)
		ARRAY REAL:C219(arACT_VariacionIPC;12)
		ARRAY REAL:C219(arACT_UFReferencia;12)
		C_LONGINT:C283($vl_year)
		
		$vl_year:=2010
		For ($i;1;Size of array:C274(arACT_VariacionIPC))
			aiACT_YearIPC{$i}:=$vl_year
		End for 
		arACT_VariacionIPC{1}:=0.5
		arACT_VariacionIPC{2}:=0.3
		arACT_VariacionIPC{3}:=0.1
		arACT_VariacionIPC{4}:=0.5
		arACT_VariacionIPC{5}:=0.4
		arACT_VariacionIPC{6}:=0
		arACT_VariacionIPC{7}:=0.6
		arACT_VariacionIPC{8}:=-0.1
		arACT_VariacionIPC{9}:=0.4
		arACT_VariacionIPC{10}:=0.1
		arACT_VariacionIPC{11}:=0.1
		arACT_VariacionIPC{12}:=0.1
		
		arACT_UFReferencia{1}:=20912.42
		$vr_ultimoValor:=arACT_UFReferencia{1}
		arACT_UFReferencia{2}:=20849.68
		$vr_ultimoValor:=arACT_UFReferencia{2}
		arACT_UFReferencia{3}:=20953.93
		$vr_ultimoValor:=arACT_UFReferencia{3}
		arACT_UFReferencia{4}:=21016.79
		$vr_ultimoValor:=arACT_UFReferencia{4}
		arACT_UFReferencia{5}:=21037.81
		$vr_ultimoValor:=arACT_UFReferencia{5}
		arACT_UFReferencia{6}:=21143
		$vr_ultimoValor:=arACT_UFReferencia{6}
		arACT_UFReferencia{7}:=21227.57
		$vr_ultimoValor:=arACT_UFReferencia{7}
		arACT_UFReferencia{8}:=21227.57
		$vr_ultimoValor:=arACT_UFReferencia{8}
		arACT_UFReferencia{9}:=21354.94
		$vr_ultimoValor:=arACT_UFReferencia{9}
		arACT_UFReferencia{10}:=21333.59
		$vr_ultimoValor:=arACT_UFReferencia{10}
		arACT_UFReferencia{11}:=21418.92
		$vr_ultimoValor:=arACT_UFReferencia{11}
		arACT_UFReferencia{12}:=21440.34
		$vr_ultimoValor:=arACT_UFReferencia{12}
		
		SET BLOB SIZE:C606(xBlob;0)
		BLOB_Variables2Blob (->xBlob;0;->aiACT_YearIPC;->atACT_MesIPC;->arACT_VariacionIPC;->arACT_UFReferencia)
		  //PREF_SetBlob (0;"ACT_IPC "+String($vl_year);xBlob)
		PREF_fGetBlob (0;"ACT_IPC "+String:C10($vl_year);xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		
		ARRAY REAL:C219(arACT_VariacionIPC;0)
		ARRAY REAL:C219(arACT_UFReferencia;0)
		ARRAY REAL:C219(arACT_VariacionIPC;12)
		ARRAY REAL:C219(arACT_UFReferencia;12)
		C_LONGINT:C283($vl_year)
		
		
		$vl_year:=2011
		For ($i;1;Size of array:C274(arACT_VariacionIPC))
			aiACT_YearIPC{$i}:=$vl_year
		End for 
		arACT_VariacionIPC{1}:=0.3
		arACT_VariacionIPC{2}:=0.2
		arACT_VariacionIPC{3}:=0.8
		arACT_VariacionIPC{4}:=0.3
		arACT_VariacionIPC{5}:=0.4
		arACT_VariacionIPC{6}:=0.2
		arACT_VariacionIPC{7}:=0.1
		arACT_VariacionIPC{8}:=0.2
		arACT_VariacionIPC{9}:=0.5
		arACT_VariacionIPC{10}:=0.5
		arACT_VariacionIPC{11}:=0.3
		arACT_VariacionIPC{12}:=0.6
		
		arACT_UFReferencia{1}:=21461.78
		$vr_ultimoValor:=arACT_UFReferencia{1}
		arACT_UFReferencia{2}:=21483.24
		$vr_ultimoValor:=arACT_UFReferencia{2}
		arACT_UFReferencia{3}:=21547.69
		$vr_ultimoValor:=arACT_UFReferencia{3}
		arACT_UFReferencia{4}:=21590.79
		$vr_ultimoValor:=arACT_UFReferencia{4}
		arACT_UFReferencia{5}:=21763.52
		$vr_ultimoValor:=arACT_UFReferencia{5}
		arACT_UFReferencia{6}:=21828.81
		$vr_ultimoValor:=arACT_UFReferencia{6}
		arACT_UFReferencia{7}:=21916.13
		$vr_ultimoValor:=arACT_UFReferencia{7}
		arACT_UFReferencia{8}:=21959.96
		$vr_ultimoValor:=arACT_UFReferencia{8}
		arACT_UFReferencia{9}:=21981.92
		$vr_ultimoValor:=arACT_UFReferencia{9}
		arACT_UFReferencia{10}:=22025.88
		$vr_ultimoValor:=arACT_UFReferencia{10}
		arACT_UFReferencia{11}:=22136.01
		$vr_ultimoValor:=arACT_UFReferencia{11}
		arACT_UFReferencia{12}:=22246.69
		$vr_ultimoValor:=arACT_UFReferencia{12}
		
		SET BLOB SIZE:C606(xBlob;0)
		BLOB_Variables2Blob (->xBlob;0;->aiACT_YearIPC;->atACT_MesIPC;->arACT_VariacionIPC;->arACT_UFReferencia)
		  //PREF_SetBlob (0;"ACT_IPC "+String($vl_year);xBlob)
		PREF_fGetBlob (0;"ACT_IPC "+String:C10($vl_year);xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		
		ARRAY REAL:C219(arACT_VariacionIPC;0)
		ARRAY REAL:C219(arACT_UFReferencia;0)
		ARRAY REAL:C219(arACT_VariacionIPC;12)
		ARRAY REAL:C219(arACT_UFReferencia;12)
		C_LONGINT:C283($vl_year)
		
		$vl_year:=2012
		For ($i;1;Size of array:C274(arACT_VariacionIPC))
			aiACT_YearIPC{$i}:=$vl_year
		End for 
		arACT_VariacionIPC{1}:=0.1
		arACT_VariacionIPC{2}:=0.4
		arACT_VariacionIPC{3}:=0.2
		arACT_VariacionIPC{4}:=0.1
		arACT_VariacionIPC{5}:=0
		arACT_VariacionIPC{6}:=-0.3
		arACT_VariacionIPC{7}:=0
		arACT_VariacionIPC{8}:=0.2
		arACT_VariacionIPC{9}:=0.8
		arACT_VariacionIPC{10}:=0.6
		arACT_VariacionIPC{11}:=-0.5
		arACT_VariacionIPC{12}:=0
		
		arACT_UFReferencia{1}:=22313.43
		$vr_ultimoValor:=arACT_UFReferencia{1}
		arACT_UFReferencia{2}:=22447.31
		$vr_ultimoValor:=arACT_UFReferencia{2}
		arACT_UFReferencia{3}:=22469.76
		$vr_ultimoValor:=arACT_UFReferencia{3}
		arACT_UFReferencia{4}:=22559.64
		$vr_ultimoValor:=arACT_UFReferencia{4}
		arACT_UFReferencia{5}:=22604.76
		$vr_ultimoValor:=arACT_UFReferencia{5}
		arACT_UFReferencia{6}:=22627.36
		$vr_ultimoValor:=arACT_UFReferencia{6}
		arACT_UFReferencia{7}:=22627.36
		$vr_ultimoValor:=arACT_UFReferencia{7}
		arACT_UFReferencia{8}:=22559.48
		$vr_ultimoValor:=arACT_UFReferencia{8}
		arACT_UFReferencia{9}:=22559.48
		$vr_ultimoValor:=arACT_UFReferencia{9}
		arACT_UFReferencia{10}:=22604.6
		$vr_ultimoValor:=arACT_UFReferencia{10}
		arACT_UFReferencia{11}:=22785.44
		$vr_ultimoValor:=arACT_UFReferencia{11}
		arACT_UFReferencia{12}:=22922.15
		$vr_ultimoValor:=arACT_UFReferencia{12}
		
		SET BLOB SIZE:C606(xBlob;0)
		BLOB_Variables2Blob (->xBlob;0;->aiACT_YearIPC;->atACT_MesIPC;->arACT_VariacionIPC;->arACT_UFReferencia)
		  //PREF_SetBlob (0;"ACT_IPC "+String($vl_year);xBlob)
		PREF_fGetBlob (0;"ACT_IPC "+String:C10($vl_year);xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		
		ARRAY REAL:C219(arACT_VariacionIPC;0)
		ARRAY REAL:C219(arACT_UFReferencia;0)
		ARRAY REAL:C219(arACT_VariacionIPC;12)
		ARRAY REAL:C219(arACT_UFReferencia;12)
		C_LONGINT:C283($vl_year)
		
		$vl_year:=2013
		For ($i;1;Size of array:C274(arACT_VariacionIPC))
			aiACT_YearIPC{$i}:=$vl_year
		End for 
		arACT_VariacionIPC{1}:=0.2
		arACT_VariacionIPC{2}:=0.1
		arACT_VariacionIPC{3}:=0.4
		arACT_VariacionIPC{4}:=-0.5
		arACT_VariacionIPC{5}:=0
		arACT_VariacionIPC{6}:=0.6
		arACT_VariacionIPC{7}:=0.3
		arACT_VariacionIPC{8}:=0.2
		arACT_VariacionIPC{9}:=0.5
		arACT_VariacionIPC{10}:=0.1
		arACT_VariacionIPC{11}:=0.4
		arACT_VariacionIPC{12}:=0.6
		
		arACT_UFReferencia{1}:=22807.54
		$vr_ultimoValor:=arACT_UFReferencia{1}
		arACT_UFReferencia{2}:=22807.54
		$vr_ultimoValor:=arACT_UFReferencia{2}
		arACT_UFReferencia{3}:=22853.16
		$vr_ultimoValor:=arACT_UFReferencia{3}
		arACT_UFReferencia{4}:=22876.01
		$vr_ultimoValor:=arACT_UFReferencia{4}
		arACT_UFReferencia{5}:=22967.51
		$vr_ultimoValor:=arACT_UFReferencia{5}
		arACT_UFReferencia{6}:=22852.67
		$vr_ultimoValor:=arACT_UFReferencia{6}
		arACT_UFReferencia{7}:=22852.67
		$vr_ultimoValor:=arACT_UFReferencia{7}
		arACT_UFReferencia{8}:=22989.79
		$vr_ultimoValor:=arACT_UFReferencia{8}
		arACT_UFReferencia{9}:=23058.76
		$vr_ultimoValor:=arACT_UFReferencia{9}
		arACT_UFReferencia{10}:=23104.88
		$vr_ultimoValor:=arACT_UFReferencia{10}
		arACT_UFReferencia{11}:=23220.4
		$vr_ultimoValor:=arACT_UFReferencia{11}
		arACT_UFReferencia{12}:=23243.62
		$vr_ultimoValor:=arACT_UFReferencia{12}
		
		SET BLOB SIZE:C606(xBlob;0)
		BLOB_Variables2Blob (->xBlob;0;->aiACT_YearIPC;->atACT_MesIPC;->arACT_VariacionIPC;->arACT_UFReferencia)
		  //PREF_SetBlob (0;"ACT_IPC "+String($vl_year);xBlob)
		PREF_fGetBlob (0;"ACT_IPC "+String:C10($vl_year);xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		
		ARRAY REAL:C219(arACT_VariacionIPC;0)
		ARRAY REAL:C219(arACT_UFReferencia;0)
		ARRAY REAL:C219(arACT_VariacionIPC;12)
		ARRAY REAL:C219(arACT_UFReferencia;12)
		C_LONGINT:C283($vl_year)
		
		$vl_year:=2014
		For ($i;1;Size of array:C274(arACT_VariacionIPC))
			aiACT_YearIPC{$i}:=$vl_year
		End for 
		arACT_VariacionIPC{1}:=0.2
		arACT_VariacionIPC{2}:=0.5
		arACT_VariacionIPC{3}:=0.8
		arACT_VariacionIPC{4}:=0.6
		arACT_VariacionIPC{5}:=0.3
		arACT_VariacionIPC{6}:=0.1
		arACT_VariacionIPC{7}:=0.2
		arACT_VariacionIPC{8}:=0.3
		arACT_VariacionIPC{9}:=0.8
		arACT_VariacionIPC{10}:=1
		arACT_VariacionIPC{11}:=0
		arACT_VariacionIPC{12}:=-0.4
		
		arACT_UFReferencia{1}:=23336.59
		$vr_ultimoValor:=arACT_UFReferencia{1}
		arACT_UFReferencia{2}:=23476.61
		$vr_ultimoValor:=arACT_UFReferencia{2}
		arACT_UFReferencia{3}:=23523.56
		$vr_ultimoValor:=arACT_UFReferencia{3}
		arACT_UFReferencia{4}:=23641.18
		$vr_ultimoValor:=arACT_UFReferencia{4}
		arACT_UFReferencia{5}:=23830.31
		$vr_ultimoValor:=arACT_UFReferencia{5}
		arACT_UFReferencia{6}:=23973.29
		$vr_ultimoValor:=arACT_UFReferencia{6}
		arACT_UFReferencia{7}:=24045.21
		$vr_ultimoValor:=arACT_UFReferencia{7}
		arACT_UFReferencia{8}:=24069.26
		$vr_ultimoValor:=arACT_UFReferencia{8}
		arACT_UFReferencia{9}:=24117.4
		$vr_ultimoValor:=arACT_UFReferencia{9}
		arACT_UFReferencia{10}:=24189.75
		$vr_ultimoValor:=arACT_UFReferencia{10}
		arACT_UFReferencia{11}:=24383.27
		$vr_ultimoValor:=arACT_UFReferencia{11}
		arACT_UFReferencia{12}:=24627.1
		$vr_ultimoValor:=arACT_UFReferencia{12}
		
		SET BLOB SIZE:C606(xBlob;0)
		BLOB_Variables2Blob (->xBlob;0;->aiACT_YearIPC;->atACT_MesIPC;->arACT_VariacionIPC;->arACT_UFReferencia)
		  //PREF_SetBlob (0;"ACT_IPC "+String($vl_year);xBlob)
		PREF_fGetBlob (0;"ACT_IPC "+String:C10($vl_year);xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		
		ARRAY REAL:C219(arACT_VariacionIPC;0)
		ARRAY REAL:C219(arACT_UFReferencia;0)
		ARRAY REAL:C219(arACT_VariacionIPC;12)
		ARRAY REAL:C219(arACT_UFReferencia;12)
		C_LONGINT:C283($vl_year)
		
		$vl_year:=2015
		For ($i;1;Size of array:C274(arACT_VariacionIPC))
			aiACT_YearIPC{$i}:=$vl_year
		End for 
		arACT_VariacionIPC{1}:=0.1
		arACT_VariacionIPC{2}:=0.4
		arACT_VariacionIPC{3}:=0.6
		arACT_VariacionIPC{4}:=0.6
		arACT_VariacionIPC{5}:=0.2
		arACT_VariacionIPC{6}:=0.5
		arACT_VariacionIPC{7}:=0.4
		arACT_VariacionIPC{8}:=0.7
		arACT_VariacionIPC{9}:=0.5
		arACT_VariacionIPC{10}:=0.4
		arACT_VariacionIPC{11}:=0
		arACT_VariacionIPC{12}:=0
		
		arACT_UFReferencia{1}:=24627.1
		$vr_ultimoValor:=arACT_UFReferencia{1}
		arACT_UFReferencia{2}:=24528.59
		$vr_ultimoValor:=arACT_UFReferencia{2}
		arACT_UFReferencia{3}:=24553.12
		$vr_ultimoValor:=arACT_UFReferencia{3}
		arACT_UFReferencia{4}:=24651.33
		$vr_ultimoValor:=arACT_UFReferencia{4}
		arACT_UFReferencia{5}:=24799.24
		$vr_ultimoValor:=arACT_UFReferencia{5}
		arACT_UFReferencia{6}:=24948.04
		$vr_ultimoValor:=arACT_UFReferencia{6}
		arACT_UFReferencia{7}:=24997.94
		$vr_ultimoValor:=arACT_UFReferencia{7}
		arACT_UFReferencia{8}:=25122.93
		$vr_ultimoValor:=arACT_UFReferencia{8}
		arACT_UFReferencia{9}:=25223.42
		$vr_ultimoValor:=arACT_UFReferencia{9}
		arACT_UFReferencia{10}:=25399.98
		$vr_ultimoValor:=arACT_UFReferencia{10}
		arACT_UFReferencia{11}:=25526.98
		$vr_ultimoValor:=arACT_UFReferencia{11}
		arACT_UFReferencia{12}:=25629.09
		$vr_ultimoValor:=arACT_UFReferencia{12}
		
		SET BLOB SIZE:C606(xBlob;0)
		BLOB_Variables2Blob (->xBlob;0;->aiACT_YearIPC;->atACT_MesIPC;->arACT_VariacionIPC;->arACT_UFReferencia)
		  //PREF_SetBlob (0;"ACT_IPC "+String($vl_year);xBlob)
		PREF_fGetBlob (0;"ACT_IPC "+String:C10($vl_year);xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		
		
		ARRAY REAL:C219(arACT_VariacionIPC;0)
		ARRAY REAL:C219(arACT_UFReferencia;0)
		ARRAY REAL:C219(arACT_VariacionIPC;12)
		ARRAY REAL:C219(arACT_UFReferencia;12)
		C_LONGINT:C283($vl_year)
		  //
		  //$vl_year:=2016
		  //For ($i;1;Size of array(arACT_VariacionIPC))
		  //aiACT_YearIPC{$i}:=$vl_year
		  //End for 
		  //arACT_VariacionIPC{1}:=0
		  //arACT_VariacionIPC{2}:=0
		  //arACT_VariacionIPC{3}:=0
		  //arACT_VariacionIPC{4}:=0
		  //arACT_VariacionIPC{5}:=0
		  //arACT_VariacionIPC{6}:=0
		  //arACT_VariacionIPC{7}:=0
		  //arACT_VariacionIPC{8}:=0
		  //arACT_VariacionIPC{9}:=0
		  //arACT_VariacionIPC{10}:=0
		  //arACT_VariacionIPC{11}:=0
		  //arACT_VariacionIPC{12}:=0
		  //
		  //arACT_UFReferencia{1}:=$vr_ultimoValor
		  //$vr_ultimoValor:=arACT_UFReferencia{1}
		  //arACT_UFReferencia{2}:=$vr_ultimoValor
		  //$vr_ultimoValor:=arACT_UFReferencia{2}
		  //arACT_UFReferencia{3}:=$vr_ultimoValor
		  //$vr_ultimoValor:=arACT_UFReferencia{3}
		  //arACT_UFReferencia{4}:=$vr_ultimoValor
		  //$vr_ultimoValor:=arACT_UFReferencia{4}
		  //arACT_UFReferencia{5}:=$vr_ultimoValor
		  //$vr_ultimoValor:=arACT_UFReferencia{5}
		  //arACT_UFReferencia{6}:=$vr_ultimoValor
		  //$vr_ultimoValor:=arACT_UFReferencia{6}
		  //arACT_UFReferencia{7}:=$vr_ultimoValor
		  //$vr_ultimoValor:=arACT_UFReferencia{7}
		  //arACT_UFReferencia{8}:=$vr_ultimoValor
		  //$vr_ultimoValor:=arACT_UFReferencia{8}
		  //arACT_UFReferencia{9}:=$vr_ultimoValor
		  //$vr_ultimoValor:=arACT_UFReferencia{9}
		  //arACT_UFReferencia{10}:=$vr_ultimoValor
		  //$vr_ultimoValor:=arACT_UFReferencia{10}
		  //arACT_UFReferencia{11}:=$vr_ultimoValor
		  //$vr_ultimoValor:=arACT_UFReferencia{11}
		  //arACT_UFReferencia{12}:=$vr_ultimoValor
		  //$vr_ultimoValor:=arACT_UFReferencia{12}
		  //
		  //SET BLOB SIZE(xBlob;0)
		  //BLOB_Variables2Blob (->xBlob;0;->aiACT_YearIPC;->atACT_MesIPC;->arACT_VariacionIPC;->arACT_UFReferencia)
		  //PREF_SetBlob (0;"ACT_IPC "+String($vl_year);xBlob)
		  //SET BLOB SIZE(xBlob;0)
		
		  //para generar la table de la uf para el año siguiente...
		C_LONGINT:C283($l_lastYear;$l_indiceYear)
		$l_lastYear:=$vl_year
		
		$vd_Fecha:=Add to date:C393(Current date:C33(*);0;1;0)
		$vl_year:=Year of:C25($vd_Fecha)
		
		If ($vl_year>=$l_lastYear)
			For ($l_indiceYear;$l_lastYear;$vl_year)
				READ ONLY:C145([xShell_Prefs:46])
				QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]User:9=0;*)
				QUERY:C277([xShell_Prefs:46]; & [xShell_Prefs:46]Reference:1="ACT_IPC "+String:C10($l_indiceYear))
				If (Records in selection:C76([xShell_Prefs:46])=0)
					For ($i;1;Size of array:C274(arACT_VariacionIPC))
						aiACT_YearIPC{$i}:=$l_indiceYear
					End for 
					arACT_VariacionIPC{1}:=0
					arACT_VariacionIPC{2}:=0
					arACT_VariacionIPC{3}:=0
					arACT_VariacionIPC{4}:=0
					arACT_VariacionIPC{5}:=0
					arACT_VariacionIPC{6}:=0
					arACT_VariacionIPC{7}:=0
					arACT_VariacionIPC{8}:=0
					arACT_VariacionIPC{9}:=0
					arACT_VariacionIPC{10}:=0
					arACT_VariacionIPC{11}:=0
					arACT_VariacionIPC{12}:=0
					
					arACT_UFReferencia{1}:=$vr_ultimoValor
					$vr_ultimoValor:=arACT_UFReferencia{1}
					arACT_UFReferencia{2}:=$vr_ultimoValor
					$vr_ultimoValor:=arACT_UFReferencia{2}
					arACT_UFReferencia{3}:=$vr_ultimoValor
					$vr_ultimoValor:=arACT_UFReferencia{3}
					arACT_UFReferencia{4}:=$vr_ultimoValor
					$vr_ultimoValor:=arACT_UFReferencia{4}
					arACT_UFReferencia{5}:=$vr_ultimoValor
					$vr_ultimoValor:=arACT_UFReferencia{5}
					arACT_UFReferencia{6}:=$vr_ultimoValor
					$vr_ultimoValor:=arACT_UFReferencia{6}
					arACT_UFReferencia{7}:=$vr_ultimoValor
					$vr_ultimoValor:=arACT_UFReferencia{7}
					arACT_UFReferencia{8}:=$vr_ultimoValor
					$vr_ultimoValor:=arACT_UFReferencia{8}
					arACT_UFReferencia{9}:=$vr_ultimoValor
					$vr_ultimoValor:=arACT_UFReferencia{9}
					arACT_UFReferencia{10}:=$vr_ultimoValor
					$vr_ultimoValor:=arACT_UFReferencia{10}
					arACT_UFReferencia{11}:=$vr_ultimoValor
					$vr_ultimoValor:=arACT_UFReferencia{11}
					arACT_UFReferencia{12}:=$vr_ultimoValor
					$vr_ultimoValor:=arACT_UFReferencia{12}
					
					SET BLOB SIZE:C606(xBlob;0)
					BLOB_Variables2Blob (->xBlob;0;->aiACT_YearIPC;->atACT_MesIPC;->arACT_VariacionIPC;->arACT_UFReferencia)
					  //PREF_SetBlob (0;"ACT_IPC "+String($vl_year);xBlob)
					PREF_fGetBlob (0;"ACT_IPC "+String:C10($l_indiceYear);xBlob)
					SET BLOB SIZE:C606(xBlob;0)
					
				End if 
			End for 
		End if 
		
		
		ACTcfg_OpenYear 
		IT_UThermometer (-2;$proc)
	End if 
End if 

$0:=$vr_ultimoValor