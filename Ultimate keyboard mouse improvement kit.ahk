#Persistent

^#j::Send,#{Left}

^#l::Send,#{Right}

^#i::Send,#{Up}

^#k::Send,#{Down}

+RWin::AppsKey
+LWin::AppsKey

^#.::Send,^#{Right}
^#,::Send,^#{Left}
!]::Send,!{Right}
![::Send,!{Left}
!4::Send,!{F4}
!-::Send,{F11}
!+-::Send,+{F11}
!5::Send,{F5}3
!9::Send,{F9}
!2::Send,{F2}
!7::Send,{F7}

!\::Send,{Del} ;del key ouside of win explorer
^\::Send,^{Del}



#IfWinActive ahk_exe Explorer.EXE 		;work around to activate Del key while win explorer window is active (desktop included)
!\::Send, {AppsKey} d 
!+\::Send, +{AppsKey} d
#IfWinActive

#IfWinActive ahk_exe PDFXEdit.exe
+Enter::Send,{Left}
#IfWinActive

CoordMode Mouse, Screen

$WheelUp::
mouseGetPos,x
if (x >= A_ScreenWidth - 1) 

	Run nircmd.exe changebrightness +3

else
  Send {WheelUp}
Return


$WheelDown::
mouseGetPos,x

if (x >= A_ScreenWidth - 1)
  
	Run nircmd.exe changebrightness -3

else
  Send {WheelDown}
Return



#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%
 
;Here are the toggle for Caps Lock State - I put in a second one (Alt + /) that I can activate with just my right hand.
;I toggle the CapsLockState also so that the light on CapsLock will indicate when it is on or off.

;Additional keys not depended on caps toggle





CapsLock::
 if (toggle=1) {
  toggle=0
  SetCapsLockState, Off
 }
 else {
  toggle=1
  SetCapsLockState, On
 }
Return

!/::
 if (toggle=1) {
  toggle=0
  SetCapsLockState, Off
 }
 else {
  toggle=1
  SetCapsLockState, On
 }
Return


#If (toggle=1)

;Righ hand side 

m::^c
,::^v
.::^x
!.::!.

i::Send,{Up}
+i::Send,+{Up}					
!^i::Send,^{Home}
!+^i::Send,+^{Home}

k::Send,{Down}				
+k::Send,+{Down}										
!^k::Send,^{End}
!+i::Send,+{Home}
!+^k::Send,+^{End}
				
l::Send,{Right}
+l::Send,+{Right}
^l::Send,^{Right}
+^l::Send,+^{Right}

j::Send,{Left}
+j::Send,+{Left}
^j::Send,^{Left}
+^j::Send,+^{Left}

!l::Send,{End}	
!+l::Send,+{End}


!j::Send,{Home}
!^j::Send,^{Home}

;Left hand side 


Esc::Send,{BackSpace}
a::enter
c::^c
v::^v
x::^x

e::Send,^{Home}


d::Send,^{End}


f::Send,{Right}
s::Send,{Left}





	




