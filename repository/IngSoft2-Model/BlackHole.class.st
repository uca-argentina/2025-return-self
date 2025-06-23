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
BlackHole class >> effectProbability [

^0.20
]

{ #category : 'positioning' }
BlackHole >> applyEffectOn: aPlayer using: positionManager and: battleManager and: turnManager [

	positionManager move: aPlayer backwardWith: debuff.

	
]

{ #category : 'initialization' }
BlackHole >> initializeOnTile: aTile [
	tile := aTile.
	debuff := 4.
]

{ #category : 'positioning' }
BlackHole >> isOf:type [

^type='BlackHole'
]
