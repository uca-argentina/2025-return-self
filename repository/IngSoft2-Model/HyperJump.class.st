Class {
	#name : 'HyperJump',
	#superclass : 'Effect',
	#instVars : [
		'actualBuff',
		'initialBuff'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
HyperJump class >> createOnTile: aTile [
"ver en la generacion automatica"
^ self new initializeOnTile: aTile with: 5.
]

{ #category : 'creation' }
HyperJump class >> effectProbability [

^0.08
]

{ #category : 'positioning' }
HyperJump >> applyEffectOn: aPlayer using: positionManager and: battleManager and: turnManager [

	positionManager move: aPlayer forwardWith: actualBuff .

		self lowerBuff.

]

{ #category : 'initialization' }
HyperJump >> initializeOnTile: aTile with: parsecs [
	tile := aTile.
	initialBuff := parsecs.
	actualBuff := parsecs.
]

{ #category : 'as yet unclassified' }
HyperJump >> lowerBuff [

	actualBuff := actualBuff -1.
	actualBuff < 1 ifTrue: [ actualBuff := initialBuff ]
]
