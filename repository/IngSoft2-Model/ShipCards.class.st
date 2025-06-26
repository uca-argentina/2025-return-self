Class {
	#name : 'ShipCards',
	#superclass : 'SpaceShipComponent',
	#instVars : [
		'deck'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'error handling' }
ShipCards class >> cardsShouldBeAtLeastTwo: aCollectionOfCards [

	"aCollectionOfCards size < 2 ifTrue: [ Error signal:'Card collection must be initialized with at least 2.' ]" "DE MOMENTO NO TIENE UTILIDAD, PORQUE ESTA CLASE TIENE QUE SER INMUTABLE"
]

{ #category : 'creation' }
ShipCards class >> createWith: anId [

	| cardClasses aCardDeck |
	self idShouldBeGreaterThanZero: anId.
	cardClasses := {
		               Acceleration.
		               Cancellation.
		               Mercenary.
		               Redo.
		               Repeat.
		               Speed }.
	aCardDeck := OrderedCollection new.
	1 to: 2 do: [ :x |
		| aRandomIndex |
		aRandomIndex := (1 to: cardClasses size) atRandom.
		aCardDeck add: (cardClasses at: aRandomIndex) new ].

	^ self new initializeWith: anId and: aCardDeck
]

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

{ #category : 'as yet unclassified' }
ShipCards >> cardThrow: aCard changing: aCollectionOfCards [

	| aNewDeck cardToRemove |
	aNewDeck := OrderedCollection withAll: deck.
	cardToRemove := aNewDeck detect: [ :card | card sameTypeOfCard: aCard ].
	aCollectionOfCards add: cardToRemove.
	aNewDeck remove: cardToRemove.
	^ self class createWith: id and: aNewDeck
]

{ #category : 'accessing' }
ShipCards >> deck [

	^ deck
]

{ #category : 'adding' }
ShipCards >> findInDeck: card [

	^ deck anySatisfy: [ :x | x sameTypeOfCard: card ]
]

{ #category : 'initialization' }
ShipCards >> initializeWith: anId and: aCardDeck [

	id := anId.
	deck := aCardDeck
]

{ #category : 'adding' }
ShipCards >> popFromDeck: aCard [

	| cardToRemove |
	cardToRemove := deck detect: [ :card | card sameTypeOfCard: aCard ].
	deck remove: cardToRemove.
	^ cardToRemove
]
