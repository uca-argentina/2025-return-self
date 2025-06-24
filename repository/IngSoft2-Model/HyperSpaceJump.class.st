Class {
	#name : 'HyperSpaceJump',
	#superclass : 'Effect',
	#instVars : [
		'buff',
		'shieldDebuff'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
HyperSpaceJump class >> create [
	^self new initializeEffectWith: 4 and: 1
]

{ #category : 'creation' }
HyperSpaceJump class >> createWith: aBoost and: aShieldDebuff [
	^self new initializeEffectWith: aBoost and: aShieldDebuff 
]

{ #category : 'creation' }
HyperSpaceJump class >> effectProbability [

^0.20
]

{ #category : 'positioning' }
HyperSpaceJump >> applyEffectOn: aPlayer using: positionManager and: battleManager and: turnManager [



		positionManager move: aPlayer forwardWith: buff.
		battleManager playerLoseShield: aPlayer.

]

{ #category : 'initialization' }
HyperSpaceJump >> initializeEffectWith: aBoost and: aShieldDebuff [

	buff := aBoost.
	shieldDebuff:=aShieldDebuff 
]

{ #category : 'testing' }
HyperSpaceJump >> isHyperSpaceJump [ 

	^ true
]
