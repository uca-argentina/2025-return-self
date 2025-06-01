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

{ #category : 'initialization' }
HyperJump class >> createOnTile: aTile [
"ver en la generacion automatica"
^ self new initializeOnTile: aTile with: 5.
]

{ #category : 'initialization' }
HyperJump class >> effectProbability [

^0.08
]

{ #category : 'positioning' }
HyperJump >> applyEffectOn: aGroupOfPlayers triggeredByPlayerAt: anIndex [ 
			| aPlayer |
	aPlayer := aGroupOfPlayers at: anIndex.
"	aPlayer position = tile ifTrue: ["
		aPlayer := aPlayer advanceTiles: actualBuff .
		self lowerBuff.
		(aGroupOfPlayers at: anIndex put: aPlayer).
"		]."
	^aGroupOfPlayers
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
