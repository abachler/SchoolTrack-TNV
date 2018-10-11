If (Form event:C388=On Load:K2:1)
	Case of 
		: (arCU_DispersionTo{8}#-10)
			$cols:=36
			$width1:=550-($cols*12)
			$err:=PL_SetArraysNam (xPL_Disp;1;13;"aAsig";"aDisp1";"aDisp2";"aDisp3";"aDisp4";"aDisp5";"aDisp6";"aDisp7";"aDisp8";"aPend";"aExim";"aNoEval";"aTotal")
			PL_SetWidths (xPL_Disp;1;13;$width1;$cols;$cols;$cols;$cols;$cols;$cols;$cols;$cols;$cols;$cols;$cols;$cols)
			PL_SetHeaders (xPL_Disp;1;13;"Asignatura";"<="+atCU_DispersionTo{1};"<="+atCU_DispersionTo{2};"<="+atCU_DispersionTo{3};"<="+atCU_DispersionTo{4};"<="+atCU_DispersionTo{5};"<="+atCU_DispersionTo{6};"<="+atCU_DispersionTo{7};"<="+atCU_DispersionTo{8};"Pend.";"Exim.";"Sin Ev.";"Total")
			
		: (arCU_DispersionTo{7}#-10)
			$cols:=38
			$width1:=550-($cols*11)
			$err:=PL_SetArraysNam (xPL_Disp;1;12;"aAsig";"aDisp1";"aDisp2";"aDisp3";"aDisp4";"aDisp5";"aDisp6";"aDisp7";"aPend";"aExim";"aNoEval";"aTotal")
			PL_SetWidths (xPL_Disp;1;12;$width1;$cols;$cols;$cols;$cols;$cols;$cols;$cols;$cols;$cols;$cols;$cols)
			PL_SetHeaders (xPL_Disp;1;12;"Asignatura";"<="+atCU_DispersionTo{1};"<="+atCU_DispersionTo{2};"<="+atCU_DispersionTo{3};"<="+atCU_DispersionTo{4};"<="+atCU_DispersionTo{5};"<="+atCU_DispersionTo{6};"<="+atCU_DispersionTo{7};"Pend.";"Exim.";"Sin Ev.";"Total")
			
		: (arCU_DispersionTo{6}#-10)
			$cols:=38
			$width1:=550-($cols*10)
			$err:=PL_SetArraysNam (xPL_Disp;1;11;"aAsig";"aDisp1";"aDisp2";"aDisp3";"aDisp4";"aDisp5";"aDisp6";"aPend";"aExim";"aNoEval";"aTotal")
			PL_SetWidths (xPL_Disp;1;11;$width1;$cols;$cols;$cols;$cols;$cols;$cols;$cols;$cols;$cols;$cols)
			PL_SetHeaders (xPL_Disp;1;11;"Asignatura";"<="+atCU_DispersionTo{1};"<="+atCU_DispersionTo{2};"<="+atCU_DispersionTo{3};"<="+atCU_DispersionTo{4};"<="+atCU_DispersionTo{5};"<="+atCU_DispersionTo{6};"Pend.";"Exim.";"Sin Ev.";"Total")
			
		: (arCU_DispersionTo{5}#-10)
			$cols:=40
			$width1:=550-($cols*9)
			$err:=PL_SetArraysNam (xPL_Disp;1;10;"aAsig";"aDisp1";"aDisp2";"aDisp3";"aDisp4";"aDisp5";"aPend";"aExim";"aNoEval";"aTotal")
			PL_SetWidths (xPL_Disp;1;10;$width1;$cols;$cols;$cols;$cols;$cols;$cols;$cols;$cols;$cols)
			PL_SetHeaders (xPL_Disp;1;10;"Asignatura";"<="+atCU_DispersionTo{1};"<="+atCU_DispersionTo{2};"<="+atCU_DispersionTo{3};"<="+atCU_DispersionTo{4};"<="+atCU_DispersionTo{5};"Pend.";"Exim.";"Sin Ev.";"Total")
			
			
		: (arCU_DispersionTo{4}#-10)
			$cols:=45
			$width1:=550-($cols*8)
			$err:=PL_SetArraysNam (xPL_Disp;1;9;"aAsig";"aDisp1";"aDisp2";"aDisp3";"aDisp4";"aPend";"aExim";"aNoEval";"aTotal")
			PL_SetWidths (xPL_Disp;1;9;$cols0;40;40;40;40;$cols;$cols;$cols;$cols)
			PL_SetHeaders (xPL_Disp;1;9;"Asignatura";"<="+atCU_DispersionTo{1};"<="+atCU_DispersionTo{2};"<="+atCU_DispersionTo{3};"<="+atCU_DispersionTo{4};"Pend.";"Exim.";"Sin Ev.";"Total")
			
			
		: (arCU_DispersionTo{3}#-10)
			$cols:=50
			$width1:=550-($cols*7)
			$err:=PL_SetArraysNam (xPL_Disp;1;8;"aAsig";"aDisp1";"aDisp2";"aDisp3";"aPend";"aExim";"aNoEval";"aTotal")
			PL_SetWidths (xPL_Disp;1;8;$width1;$cols;$cols;$cols;$cols;$cols;$cols;$cols)
			PL_SetHeaders (xPL_Disp;1;8;"Asignatura";"<="+atCU_DispersionTo{1};"<="+atCU_DispersionTo{2};"<="+atCU_DispersionTo{3};"Pend.";"Exim.";"Sin Ev.";"Total")
			
		: (arCU_DispersionTo{2}#-10)
			$cols:=60
			$width1:=550-($cols*6)
			$err:=PL_SetArraysNam (xPL_Disp;1;7;"aAsig";"aDisp1";"aDisp2";"aPend";"aExim";"aNoEval";"aTotal")
			PL_SetWidths (xPL_Disp;1;7;$width1;$cols;$cols;$cols;$cols;$cols;$cols)
			PL_SetHeaders (xPL_Disp;1;7;"Asignatura";"<="+atCU_DispersionTo{1};"<="+atCU_DispersionTo{2};"Pend.";"Exim.";"Sin Ev.";"Total")
			
		: (arCU_DispersionTo{1}#-10)
			$cols:=70
			$width1:=550-($cols*5)
			$err:=PL_SetArraysNam (xPL_Disp;1;6;"aAsig";"aDisp1";"aPend";"aExim";"aNoEval";"aTotal")
			PL_SetWidths (xPL_Disp;1;6;$width1;$cols;$cols;$cols;$cols;$cols)
			PL_SetHeaders (xPL_Disp;1;6;"Asignatura";"<="+atCU_DispersionTo{1};"Pend.";"Exim.";"Sin Ev.";"Total")
	End case 
	
	  //modifico JVP 11-06 debido a que si es un solo alumno en la dispersion estaba mostrando 10, al cambiar a ## muestra 0 si no hay y el numero correspondiente cuando se deba
	  //PL_SetFormat (xPL_Disp;0;"##0";2;2)
	  //nuevo codigo
	PL_SetFormat (xPL_Disp;0;"##";2;2)
	PL_SetHdrOpts (xPL_Disp;2)
	PL_SetHeight (xPL_Disp;1;1;0;0)
	PL_SetHdrStyle (xPL_Disp;0;"Tahoma";8;1)
	PL_SetStyle (xPL_Disp;0;"Tahoma";8;0)
	PL_SetStyle (xPL_Disp;9;"Tahoma";8;1)
	PL_SetFormat (xPL_Disp;1;"";1;2)
	PL_SetDividers (xPL_Disp;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
	PL_SetFrame (xPL_Disp;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
	PL_SetSort (xPL_Disp;1)
End if 

