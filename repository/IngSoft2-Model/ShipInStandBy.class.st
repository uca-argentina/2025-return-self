Class {
	#name : 'ShipInStandBy',
	#superclass : 'SpaceShipComponent',
	#instVars : [
		'id',
		'turnsToSkip'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
ShipInStandBy class >> createWith: anId and: aNumberOfTurns [

	self idShouldBeGreaterThanZero: anId.
	self turnsToSkipShouldBePositive: aNumberOfTurns.
	^ self new initializeWith: anId and: aNumberOfTurns
]

{ #category : 'error testing' }
ShipInStandBy class >> turnsToSkipShouldBePositive: aNumberOfTurns [

	aNumberOfTurns < 0 ifTrue: [
		Error signal: 'The turns to skip cant be negative.' ]
]

{ #category : 'initialization' }
ShipInStandBy >> initializeWith: anId and: aNumberOfTurns [

	id := anId.
	turnsToSkip := aNumberOfTurns
]
