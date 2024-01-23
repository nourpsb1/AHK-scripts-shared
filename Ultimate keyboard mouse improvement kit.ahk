#Persistent 
;change the path below to any png file you want to us as tray icon
Menu, Tray, Icon, C:\Users\Nour El Yakine\Desktop\‎ ‎ ‎ ‎‎ ‎ ‎ ‎‎ ‎ ‎ ‎‎ ‎ ‎ ‎\theme collection\icons+JPG\keyboard-512.ico ;changes default green icon to red keyboard in taskbar tray 







;shortcut to suspend this script: 
!sc010::suspend,toggle 







; Key scancodes used to make hotkeys work at all languages and layouts
; i sc017
; k sc025
; l sc026
; j sc024
; a sc01E
; d sc020
; f sc021
; e sc012
; s sc01F
; m sc032
; m sc032
; , sc033
; . sc034
; v sc02F
; c sc02E
; x sc02d
; / sc035
; - sc00C
; \ sc02B
; q sc010
; w sc011
; r sc013
; u sc016
; o sc018
; t sc014
; ' sc028
; h sc023
; n sc031
; [ sc01A




;the only bunch of hotkeys that only work with send (not SendInput)

	;window snaping feature
	
		^#sc024::Send,#{Left}	
		^#sc026::Send,#{Right}
		^#sc017::Send,#{Up}
		^#sc025::Send,#{Down}
	
	

	
	;send input applicable : 
		
		$+LWin::AppsKey
		$+RWin::AppsKey	
		
		$^#sc034::SendInput,^#{Right}
		$^#sc033::SendInput,^#{Left}
		
		$!4::SendInput,!{F4}
		$<^>!4::SendInput,!{F4}
		$!sc00C::SendInput,{F11}
		$!+sc00C::SendInput,+{F11}
		$!5::SendInput,{F5}
		$!+5::SendInput,+{F5}
		$!9::SendInput,{F9}
		$!2::SendInput,{F2}
		$!7::SendInput,{F7}
		$<^>!7::SendInput,{{} ;not alt +7 doesn't work cus it's maped to F7
		$<^>!sc020::!sc020 ;to make altgr+d work as alt+d in french
		


	;Delete & backspace key mappings 
	
		;sc02B is \ in english and à in french candian layout legacy and ذ بالعربية
		
				$!sc02B::SendInput,{Del}
				$^sc02B::SendInput,^{Del}
				$<^>!sc02B::SendInput,{Del}
				$!1::SendInput,{del}
		
		;Use ESC as backspace & delete for the left hand side 
		
		$!Esc::SendInput,{BackSpace}
		$^Esc::SendInput,{Del}


		
			#IfWinActive ahk_exe Explorer.exe
		
				;completely avoid explorer slow search clicking ctrl+f allows to search the folder with everything (only doesn't work in "This PC")
					
					;you must not have any folder selected if you want to seach said folder you simply enter it then press ctrl+f
					$!sc02B::SendInput,+{F10}d
				 	$^sc021::SendInput,+{F10}{Up 4}{Enter} ;{Up 4} = 4 times up arrow 
	
			#IfWinActivedn


		;navigate xchange pdf with enter Key 
		
			#IfWinActive ahk_exe PDFXEdit.exe
		
				$+Enter::SendInput,^{Left}
			;jump back to pevious view/ Next view -you were in page 45 then checked first page you can jump back to 45 without scrolling using alt + j even when capslock is off 
		
				$!sc024::SendInput,!{Left} 
				$!sc025::SendInput,!{Right} 
			
			;to get normal alt tab even in full screen 
		
				$!tab::+!tab 	;doesn't work with SendInput!!!!!
		
			#IfWinActive
	 
	
		;Bonus keep window on tap :
		
			$^+space::
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
				Sleep 3000 ;let it display for 3 seconds 
				HideTrayTip()
			
				IsWindowAlwaysOnTop(windowTitle) {
					WinGet, windowStyle, ExStyle, %windowTitle%
					isWindowAlwaysOnTop := if (windowStyle & 0x8) ? false : true ; 0x8 is WS_EX_TOPMOST.
					return isWindowAlwaysOnTop
				}
			
				HideTrayTip() {
					TrayTip  ; Attempt to hide it the normal way.
					if SubStr(A_OSVersion,1,3) = "10."	{
						Menu Tray, NoIcon
						Sleep 200  ; It may be necessary to adjust this sleep.
						Menu Tray, Icon
					}
				}
			Return
		
		;Make window transparent very usefull with pinned on top windows 
				#b::
				toggle:=!toggle
				if toggle=1
				{
				WinSet, Transparent, 175, A
				}
				else
				{
				WinSet, Transparent, OFF, A
				}
				return


;control brightness and volume with mouse wheel !!! Cooolll!!!

#MaxHotkeysPerInterval 200 ; to avoid prompt that too many hotkeys triggerd/ms when scrolling with following code ;) 

CoordMode Mouse, Screen

;precise brightness control 
		$WheelUp::
mouseGetPos,x
if (x >= A_ScreenWidth - 1) 
	
	Run nircmd.exe changebrightness +3

else
	SendInput,{WheelUp}
Return

$WheelDown::
mouseGetPos,x
if (x >= A_ScreenWidth - 1)
	Run nircmd.exe changebrightness -3
else
  SendInput,{WheelDown}
Return

;Fast brightness control

$+WheelUp::
mouseGetPos,x
if (x >= A_ScreenWidth - 1) 
	Run nircmd.exe changebrightness +12

else
 SendInput,+{WheelUp}
Return


$+WheelDown::
mouseGetPos,x
if (x >= A_ScreenWidth - 1)
		Run nircmd.exe changebrightness -12
else
  SendInput,+{WheelDown}
Return
 
 ;Sound control
 
$!WheelUp::
mouseGetPos,x
if (x >= A_ScreenWidth - 1) 
	SoundSet, +5
else
  SendInput,!{WheelUp}
Return


$!WheelDown::
mouseGetPos,x
if (x >= A_ScreenWidth - 1)
	SoundSet, -5
else
  SendInput,!{WheelDown}
Return



;Main function of All the script 

#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
SetWorkingDir %A_ScriptDir%
 

	;Capstate toggles 
		;toggle caps with righthand using alt+/
			$!sc035::CapsLock
			
			
		;ctrl+t start typing in new tab right away 
			#IfWinActive ahk_exe msedge.exe
			
				$^sc014::
				sendinput, ^t 
				SetCapslockState off
				Return
				
				$^sc026::
				sendinput,^l
				SetCapslockState off
				Return
			#IfWinActive
		
		;to send alt+i (launch everything search)& turn off caps to be ready for input ;)  
				$!sc017::
				SendInput !i 
				SetCapslockState off 
				Return
	
		;ctrl find sets lockstate off :: type immediately
				$^sc021::
				SendInput ^f 
				SetCapslockState off 
				Return
		
				
#if (GetKeyState("CapsLock", "T") = True) ;The # before if is neccessary for the fuction to work
 
		$sc032::SendInput,^c
		$sc033::SendInput,^v
		$sc034::SendInput,^x
		$!sc034::SendInput,!.
			
		$sc017::SendInput,{Up}
		$+sc017::SendInput,+{Up}
		
		$u::SendInput,^{Home}
		$+u::SendInput,+^{Home}
		
	
		$sc025::SendInput,{Down}			
		$+sc025::SendInput,+{Down}
		
		$o::SendInput,^{End}
		$+o::SendInput,+^{End}
		
						
		$sc026::SendInput,{Right}
		$+sc026::SendInput,+{Right}
		$^sc026::SendInput,^{Right}
		$+^sc026::SendInput,+^{Right}
		$!sc026::SendInput,{End}	
		$!+sc026::SendInput,+{End}

		$sc024::SendInput,{Left}}
		$+sc024::SendInput,+{Left}
		$^sc024::SendInput,^{Left}
		$+^sc024::SendInput,+^{Left}
		$!sc024::SendInput,{Home}
		$!+sc024::SendInput,+{Home}
	
		
		$sc01E::SendInput,{enter} ;Use the s to go back in xchange pdf dahhh!!!
		$sc02E::SendInput,^c
		$sc02F::SendInput,^v
		$sc02D::SendInput,^x
		$sc010::SendInput,!.
		
		
		
	;used the normal letters not the sc codes inorder not to interfeere with gestures sign shortcuts in pdf Xchange!!!!!!
		
		$r::SendInput,^{Home}
		$w::SendInput,^{End}
		$e::SendInput,{Up}
		$sc020::SendInput,{Down}
		$sc021::SendInput,{Right}
		$s::SendInput,{Left}
		
		
	;move between desktops with one click (to easily migrate windows)=>> Ctrl+Win + arrow still works to change desktops too 

		$sc028::SendInput,^#{Right} 
		$sc023::SendInput,^#{Left}
		
	;move windows between [Existing virtual desktops]==> Doesn't work with UWP apps nor with Cmd prompt !!!!! 
	
		;move current window to desktop to the right[Doesn't work with UWP apps nor with Cmd prompt!!!!! ]
		$sc035::					 
		WinGetTitle, Title, A
		WinSet, ExStyle, ^0x80, %Title%
		Send {LWin down}{Ctrl down}{Right}{Ctrl up}{LWin up}
		sleep, 50
		WinSet, ExStyle, ^0x80, %Title%
		WinActivate, %Title%
		Return
		
		;move current windows to desktop to the left [Doesn't work with UWP apps nor with Cmd prompt!!!!! ]
		$sc031::					
		WinGetTitle, Title, A
		WinSet, ExStyle, ^0x80, %Title%
		Send {LWin down}{Ctrl down}{Left}{Ctrl up}{LWin up}
		sleep, 50
		WinSet, ExStyle, ^0x80, %Title%
		WinActivate, %Title%
		
		
		;Correction to avoid conflict with xchange pdf shortcuts when caps is on 
			$!u::SendInput,!u
			$!sc021::SendInput,!f 
			$!r::SendInput,!r 
			$!x::SendInput,!x 
			$!e::SendInput,!e


		
#if 		;to exit the condtion above ==> you can add more unrelated code BelowNormal



		

	


		
	
