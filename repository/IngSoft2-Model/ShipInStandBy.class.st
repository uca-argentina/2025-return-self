Class {
	#name : 'ShipInStandBy',
	#superclass : 'SpaceShipComponent',
	#instVars : [
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
		Error signal: 'The SpaceShip cant skip negative turns.' ]
]

{ #category : 'adding' }
ShipInStandBy >> addTwoSkips [

	^ self class createWith: id and: turnsToSkip + 2
]

{ #category : 'accessing' }
ShipInStandBy >> hasTurnsToSkip [

	^ turnsToSkip > 0
]

{ #category : 'initialization' }
ShipInStandBy >> initializeWith: anId and: aNumberOfTurns [

	id := anId.
	turnsToSkip := aNumberOfTurns
]

{ #category : 'creation' }
ShipInStandBy >> skipATurn [

	^ self class createWith: id and: turnsToSkip - 1
]

{ #category : 'accessing' }
ShipInStandBy >> turnsToSkip [
	"Used for testing"

	^ turnsToSkip
]
