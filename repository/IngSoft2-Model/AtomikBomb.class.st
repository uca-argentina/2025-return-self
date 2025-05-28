Class {
	#name : 'AtomikBomb',
	#superclass : 'Effect',
	#instVars : [
		'tile',
		'debuff',
		'setOfPlayers'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
AtomikBomb class >> initializeInTile: aTile andSetOfPlayers: aSetOFPlayers [ 
	^self new initializeOnTile: aTile andSetOfPlayers: aSetOFPlayers .
]

{ #category : 'positioning' }
AtomikBomb >> applyEffectOn: aSetOfPlayers onIndex: anIndex [
   |aux|
	(aSetOfPlayers at: anIndex) position = tile ifTrue:[
		aux := aSetOfPlayers collect: [:player | player goBackTiles: debuff.].
		aux := aux collect: [:player | player loseShield .].
		^aux
	].
	^aSetOfPlayers

	
]

{ #category : 'initialization' }
AtomikBomb >> initializeOnTile: aTile andSetOfPlayers: aSetOfPlayers [
	tile := aTile.
	debuff := aTile - 1.
	setOfPlayers := aSetOfPlayers.
]

{ #category : 'initialization' }
AtomikBomb >> initializeOnTile: aTile withDebuff: aDebuff andSetOfPlayers: aSetOfPlayers [
	tile := aTile.
	debuff := aDebuff.
	setOfPlayers := aSetOfPlayers.
]
