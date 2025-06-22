Class {
	#name : 'HyperSpaceJump',
	#superclass : 'Effect',
	#instVars : [
		'buff'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
HyperSpaceJump class >> effectProbability [

^0.20
]

{ #category : 'positioning' }
HyperSpaceJump >> applyEffectOn: aPlayer using: positionManager and: battleManager and: turnManager [



		positionManager move: aPlayer forwardWith: buff.
		battleManager playerLoseShield: aPlayer.

]

{ #category : 'initialization' }
HyperSpaceJump >> initializeOnTile: aTile [
	tile := aTile.
	buff := 4.

]
