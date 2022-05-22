;;;;;;;;;;;;;;;;;;;;;;;;;
;; Game Fixes & Tweaks ;;
;;;;;;;;;;;;;;;;;;;;;;;;;

; check for interaction every single frame (as opposed to every other frame)
org $02A0B2 : db $00 ; fireball-sprite
org $01A7EF : db $00 ; mario-sprite
org $029500 : db $00 ; cape-sprite

; make doors more easy to enter adjust door proximity check
org $00F44B : db $10 ; width of the enterable region of the door (up to 0x10, default 0x08)  
org $00F447 : db $05 ; offset the enterable region, which is half of above (default 0x04)

; play SFX when exiting horizontal pipes
org $00D24E : LDA $7D : NOP : NOP

; fix bug in yoshi stomp hitbox 
org $0286D7 : db $D5

; no powerups from midways
org $00F2E2 : db $80

; remove Yoshi's rescue message
org $01EC36 : db $80

; stop the bridge breaking in the Reznor fight
org $03989F : db $EA,$EA,$EA,$EA

; fix disappearing music on overworld when boss defeated
org $048E2E : db $80  

; Sunken Ghost Ship glitch
org $048DDA : db $80

; fix crash that occurs when trying to stop layer 3 smasher with generator D2
org $02D421 : db $6B

; infinite lives
org $00D0D8 : NOP #3

; fix Yellow Koopa jump framerule
org $018898 : bra $05

; fix Message Box removing some sprite tiles when closing
org $05B31B : rts

; fix HDMA breaks
org $05B129 : nop #3
org $05B296 : db $0C
org $00CB0C : db $0C
org $009CAD : nop #3
org $0092EA : db $0C
org $0CAB98 : db $0C
org $04DB99 : db $0C
org $04F40D : nop #3
org $00C5CE : nop #3
org $03C511 : db $0C

;;;;;;;;;;;;;;;;;;;;;;;;
;; GFX Tweaks & Fixes ;;
;;;;;;;;;;;;;;;;;;;;;;;;

; fix palette of the white tile in the cave layer 3 background
org $05A312 : db $15
org $05A4B2 : db $15

; fix dark palette on "Erase Game" screen
org $009D30 : db $EA,$EA,$EA,$EA,$EA

; fix a misplaced tile on the keyhole "iris in" effect
org $00CBA3 : db $49

; fix the S in "Mario/Luigi Start".
org $00913F : db $34
org $009170 : db $F4

; fix chuck arm palette
org $02CAFA : db $4B,$0B

; fix the Dolphin tails showing up when they're vertically off-screen
org $07F69C : db $25

; fix bat ceiling gfx
org $02FDB8 : db $AE,$AE,$C0,$E8

; fix layer 3 cave background using wrong colors
org $05A312 : db $15
org $05A4B2 : db $15

; fix the last tile of the Turnblock Bridge being X flipped.
org $01B79D : db $20

; fix Wendy's bow
org $03CFAF : db $08
org $03CFB5 : db $08
org $03D1D7 : db $1F,$1E
org $03D1DD : db $1E,$1F

; fix magikoopa palettes
org $03B90C : db $00,$28
org $03B91C : db $40,$34
org $03B92C : db $A3,$40
org $03B93C : db $06,$4D
org $03B94C : db $69,$59
org $03B95C : db $CC,$65
org $03B96C : db $2F,$72
org $03B97C : db $92,$7E

; fix vertical level priorities
org $0584BE : db $20,$20        ; level mode 07 & 08
org $0584C1 : db $20            ; level mode 0A
org $0584C3 : db $20,$20,$20    ; level mode 0C, 0D & 0E
org $0584C8 : db $20            ; level mode 11
org $0584D5 : db $20,$20        ; level mode 1E & 1F

;;;;;;;;;;;;;;;;;;;
;; Sprite Remaps ;;
;;;;;;;;;;;;;;;;;;;

; Note block bounce sprite
org $0291F2 : db $4A : org $02878A : db $02 : org $02925D : db $02
; Side turn block bounce sprite
org $0291F4 : db $40 : org $02878C : db $00 : org $02925D : db $02
; ON/OFF bounce sprite
org $0291F6 : db $20 : org $02878E : db $06 : org $02925D : db $02

; Yoshi's tongue, end
org $01F48C : db $7E : org $01F494 : db $08
; Yoshi's tongue, middle
org $01F488 : db $7F : org $01F494 : db $08
; Yoshi's throat
org $01F08B : db $38 : org $01F097 : db $00

; Piranha plant Head 1
org $019BBD : db $AC : org $07F418 : db $08
; Piranha plant Stem 1
org $019BBE : db $0A : org $018E92 : db $0B
; Piranha plant Head 2
org $019BBF : db $AE : org $07F418 : db $08
; Piranha plant Stem 2
org $019BC0 : db $0A : org $018E92 : db $09

; Lava splashes
org $029E82
    db $5B
    db $4B
    db $5A
    db $4A

org $029ED5 : db $04