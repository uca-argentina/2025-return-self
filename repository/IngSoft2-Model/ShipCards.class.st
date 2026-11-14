Class {
	#name : 'ShipCards',
	#superclass : 'SpaceShipComponent',
	#instVars : [
		'deck'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
ShipCards class >> createWith: anId and: aCardDeck [

	self idShouldBeGreaterThanZero: anId.
	^ self new initializeWith: anId and: aCardDeck
]

{ #category : 'adding' }
ShipCards >> addToDeck: aCard [

	| aNewDeck |
	aNewDeck := OrderedCollection withAll: deck.
	aNewDeck add: aCard.
	^ self class createWith: id and: aNewDeck
]

{ #category : 'accessing' }
ShipCards >> deck [

	^ deck
]

{ #category : 'testing' }
ShipCards >> findInDeck: aCard [

	^ deck anySatisfy: [ :card | card sameTypeOfCard: aCard ]
]

{ #category : 'initialization' }
ShipCards >> initializeWith: anId and: aCardDeck [

	id := anId.
	deck := aCardDeck
]

{ #category : 'removing' }
ShipCards >> removeFromDeck: aCard [

	| aNewDeck cardToRemove |
	cardToRemove := deck
						detect: [ :card | card sameTypeOfCard: aCard ]
						ifNone: [
						Error signal: 'Player does not have this card on deck.' ].
	aNewDeck := OrderedCollection withAll: deck.
	aNewDeck remove: cardToRemove.
	^ self class createWith: id and: aNewDeck
]
