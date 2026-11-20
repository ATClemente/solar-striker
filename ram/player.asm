DEF wWeaponPowerLevel EQU $CA21
DEF wPlayerShotCooldown EQU $CA24
DEF wPlayerDirectionIndex EQU $CA25 ; 0-7; $FF for no valid direction
DEF wWeaponShotSlots  EQU $CA51
DEF wPlayerShotAllocationIndex EQU $CA54
DEF wPlayerInvincibilityTimer EQU $CA68
DEF wPlayerInvincible EQU $CA69
DEF wPlayerLives      EQU $CF95

DEF wPlayerYPos EQU $C781
DEF wPlayerXPos EQU $C782

DEF wPlayerGraphicsPointer EQU $C783 ; two bytes

DEF wPlayerCollisionCenterY EQU $C786
DEF wPlayerCollisionCenterX EQU $C787

DEF wPlayerHitboxMinY EQU $C788
DEF wPlayerHitboxMinX EQU $C789

DEF wPlayerHitboxMaxY EQU $C78A
DEF wPlayerHitboxMaxX EQU $C78B

;DEF wPlayerDamageThreshold EQU $C78C
;DEF wPlayerAccumulatedDamage EQU $C78D