#Persistent
#InstallKeybdHook
#InstallMouseHook
; Key scancodes used to make hotkeys work at all languages and layouts
; i sc017
; k scsc025
; l scsc026
; j sc024
; a sc01E
; d sc020
; f sc021
; e sc012
; s sc01F
; m sc032
; , sc033
; . sc034
; v sc02F
; c sc02E
; x sc02d
; [ sc01A
; ] sc01B


$^#sc024::send,#{Left}

$^#sc026::send,#{Right}

$^#sc017::send,#{Up}

$^#sc025::send,#{Down}

$+RWin::AppsKey
$+LWin::AppsKey

$^#.::send,^#{Right}
$^#,::send,^#{Left}


$!sc01A::!Left
$!sc01B::!Right
$!4::!F4
$!-::F11
$!+-::+F11
$!5::F5
$!9::F9
$!2::F2
$!7::F7

;sc02B is \ in english and à in french candian layout legacy
$!sc02B::send,{Del}
$^sc02B::send,^{Del}
$<^>!sc02B::send,{Del}



;Bonus keep window on tap :::

^+space::
	WinGetTitle, activeWindow, A
	if IsWindowAlwaysOnTop(activeWindow) {
		notificationMessage := "The window """ . activeWindow . """ is now always on top."
		notificationIcon := 16 + 1 ; No notification sound (16) + Info icon (1)
	}
	else {
		notificationMessage := "The window """ . activeWindow . """ is no longer always on top."
		notificationIcon := 16 + 2 ; No notification sound (16) + Warning icon (2)
	}
	Winset, Alwaysontop, , A
	TrayTip, Always-on-top, %notificationMessage%, , %notificationIcon% 
	Sleep 3000 ; Let it display for 3 seconds.
	HideTrayTip()

	IsWindowAlwaysOnTop(windowTitle) {
		WinGet, windowStyle, ExStyle, %windowTitle%
		isWindowAlwaysOnTop := if (windowStyle & 0x8) ? false : true ; 0x8 is WS_EX_TOPMOST.
		return isWindowAlwaysOnTop
	}

	HideTrayTip() {
		TrayTip  ; Attempt to hide it the normal way.
		if SubStr(A_OSVersion,1,3) = "10." {
			Menu Tray, NoIcon
			Sleep 200  ; It may be necessary to adjust this sleep.
			Menu Tray, Icon
		}
	}
Return


;work around to activate Del key while win explorer window is active (desktop included)

#IfWinActive ahk_exe Explorer.EXE 	
$!\::Send, {AppsKey} d
$!+\::Send, +{AppsKey} d
#IfWinActive

#IfWinActive ahk_exe PDFXEdit.exe
$+Enter::send,^{Left}
$!tab::+!tab
#IfWinActive
#MaxHotkeysPerInterval 200
CoordMode Mouse, Screen
;precise brightness control 

$WheelUp::
mouseGetPos,x
if (x >= A_ScreenWidth - 1) 
	Run nircmd.exe changebrightness +3

else
$WheelUp::WheelUp
Return
$WheelDown::
mouseGetPos,x
if (x >= A_ScreenWidth - 1)
	Run nircmd.exe changebrightness -3
else
  $WheelDown::WheelDown
Return

;Fast brightness control

$+WheelUp::
mouseGetPos,x
if (x >= A_ScreenWidth - 1) 
	Run nircmd.exe changebrightness +12

else
 $+WheelUp::+WheelUp
Return


$+WheelDown::
mouseGetPos,x
if (x >= A_ScreenWidth - 1)
		Run nircmd.exe changebrightness -12
else
  $+WheelDown::+WheelDown
Return
 
 ;Sound control
 
$!WheelUp::
mouseGetPos,x
if (x >= A_ScreenWidth - 1) 
	SoundSet, +5
else
  $!WheelUp::!WheelUp
Return


$!WheelDown::
mouseGetPos,x
if (x >= A_ScreenWidth - 1)
	SoundSet, -5
else
  $!WheelDown::WheelDown
Return


;Main function of script 

#NoEnv  				; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  		; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%
  
;Do not move the following hotkey it needs SendMode Input to work !!!!
  
$<^>!7::send,{{} ; sends "{" whehn AltGr (in french keyboard) is pressed with 7 [canadian legacyla]
 
$!/::capslock ;tooggle caps with righthand

 #if (GetKeyState("CapsLock", "T") = True) ;The # before if is neccessary for the fuction to work
 
		$sc032::^c
		$sc033::^v
		$sc034::^x
		$!sc034::!.
		
		$sc017::Up
		$+sc017::+Up					
		$^sc017::^Home
		$+^sc017::+^Home

		$sc025::Down				
		$+sc025::+Down										
		$^sc025::^End
		$+^sc025::+^End
						
		$sc026::Right
		$+sc026::+Right
		$^sc026::^Right
		$+^sc026::+^Right
		$!sc026::End	
		$!+sc026::+End

		$sc024::Left
		$+sc024::+Left
		$^sc024::^Left
		$+^sc024::+^Left
		$!sc024::Home
		$!+sc024::+Home
		

		;Left hand side 
		

		$sc01E::enter
		$sc02E::^c
		$sc02F::^v
		$sc02D::^x
	
		$sc012::^Home
		$sc020::^End
		$sc021::Right
		$sc01F::Left
		
		
		
		
	
		$Esc::BackSpace 	 	
