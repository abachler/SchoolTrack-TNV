  //◊stopExec:=False

  //LOCKED ATTRIBUTES(MUloadFile->;$procID;$user;$station;$procName)

  //vMUmess:=Get indexed string(20002;5)+"\r"+"Presione la tecla Escape para abortar."

  //REDRAW(vMUmess)

  //CALL PROCESS(-1)

  //ON EVENT CALL("Interruptions_EscapeKey")

  //While ((Locked(MUloadFile->)) & (Not(◊stopExec)))

  //LOAD RECORD(MUloadFile->)

  //DELAY PROCESS(Current process;10)

  //End while 

  //ON EVENT CALL("")

  //If (Not(◊stopExec))

  //ACCEPT

  //Else 

  //CANCEL

  //End if 

