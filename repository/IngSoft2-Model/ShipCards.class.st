Class {
	#name : 'ShipCards',
	#superclass : 'SpaceShipComponent',
	#instVars : [
		'deck',
		'activeCards'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'error handling' }
ShipCards class >> cardsShouldBeAtLeastTwo: aCollectionOfCards [

	aCollectionOfCards size < 2 ifTrue: [ Error signal:'Card collection must be initialized with at least 2.' ]
]

{ #category : 'creation' }
ShipCards class >> createWith: anId and: activeCards [

	| aCardDeck cardClasses |
	self idShouldBeGreaterThanZero: anId.
	cardClasses := {
		               Acceleration.
		               Cancellation.
		               Mercenary.
		               Redo.
		               Repeat.
		               Speed }.
	aCardDeck := CardCollection create.
	1 to: 2 do: [ :x |
		| aRandomIndex |
		aRandomIndex := (1 to: cardClasses size) atRandom.
		aCardDeck add: (cardClasses at: aRandomIndex) new ].

	^ self new initializeWith: anId and: aCardDeck and: activeCards
]

{ #category : 'creation' }
ShipCards class >> createWith: anId and: aCardDeck and: activeCards [

	self idShouldBeGreaterThanZero: anId.
	^ self new
		  initializeWith: anId
		  and: aCardDeck
		  and: activeCards
]

{ #category : 'accessing' }
ShipCards >> deck [

	^ deck
]

{ #category : 'initialization' }
ShipCards >> initializeWith: anId and: aCardDeck and: activeCardCollection [

	id := anId.
	deck := aCardDeck.
	activeCards := activeCardCollection "HASTA ACA, EL RESTO ES MAS ADELANTE"
]
