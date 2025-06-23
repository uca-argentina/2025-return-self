Class {
	#name : 'BlackHole',
	#superclass : 'Effect',
	#instVars : [
		'debuff'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
BlackHole class >> create [
	^self new initializeEffectWith: 4
]

{ #category : 'creation' }
BlackHole class >> createWith: aDebuff [
	^self new initializeEffectWith: aDebuff
]

{ #category : 'creation' }
BlackHole class >> effectProbability [

^0.20
]

{ #category : 'positioning' }
BlackHole >> applyEffectOn: aPlayer using: positionManager and: battleManager and: turnManager [

	positionManager move: aPlayer backwardWith: debuff.

	
]

{ #category : 'initialization' }
BlackHole >> initializeEffectWith: aDebuff [

	debuff := aDebuff
]

{ #category : 'testing' }
BlackHole >> isBlackHole [

	^ true
]
