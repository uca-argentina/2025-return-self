Class {
	#name : 'ShipCards',
	#superclass : 'SpaceShipComponent',
	#instVars : [
		'cards'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'error handling' }
ShipCards class >> cardsShouldBeAtLeastTwo: aCollectionOfCards [

	aCollectionOfCards size < 2 ifTrue: [ Error signal:'Card collection must be initialized with at least 2.' ]
]

{ #category : 'creation' }
ShipCards class >> createWith: anId and: aCollectionOfCards [

	self idShouldBeGreaterThanZero: anId.
	self cardsShouldBeAtLeastTwo: aCollectionOfCards.
	^ self new initializeWith: anId and: aCollectionOfCards
]

{ #category : 'initialization' }
ShipCards >> initializeWith: anId and: aCollectionOfCards [

	id := anId.
	cards := aCollectionOfCards
]
