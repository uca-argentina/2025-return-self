Class {
	#name : 'CardManager',
	#superclass : 'GameFeatureManager',
	#instVars : [
		'cardDealer',
		'activeCards'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
CardManager class >> createWith: aGroupOfPlayers [

	^ self createWith: aGroupOfPlayers and: CardDealer withEveryCard
]

{ #category : 'creation' }
CardManager class >> createWith: aGroupOfPlayers and: aCardDealer [

	^ self new initializeCardManagerWith: aGroupOfPlayers and: aCardDealer
]

{ #category : 'accessing' }
CardManager class >> initialHandSize [

	^ 2
]

{ #category : 'active cards' }
CardManager >> activate: aPermanentCard [

	activeCards add: aPermanentCard
]

{ #category : 'hands' }
CardManager >> add: aCard to: aPlayer [

	self updateShipReference: ((self findShipReference: aPlayer) addToDeck: aCard)
]

{ #category : 'hands' }
CardManager >> assert: aPlayer holds: aCard [

	((self findShipReference: aPlayer) findInDeck: aCard) ifFalse: [
		Error signal: 'Player does not have this card on deck.' ]
]

{ #category : 'active cards' }
CardManager >> boost: aThrow of: aPlayer [

	^ activeCards
		inject: aThrow
		into: [ :boostedThrow :card | card boost: boostedThrow of: aPlayer ]
]

{ #category : 'hands' }
CardManager >> dealCardTo: aPlayer [

	self add: cardDealer dealCard to: aPlayer
]

{ #category : 'hands' }
CardManager >> dealInitialHand [

	^ (1 to: self class initialHandSize) collect: [ :each | cardDealer dealCard ]
]

{ #category : 'hands' }
CardManager >> discard: aCard from: aPlayer [

	self updateShipReference: ((self findShipReference: aPlayer) removeFromDeck: aCard)
]

{ #category : 'initialization' }
CardManager >> initializeCardManagerWith: aGroupOfPlayers and: aCardDealer [

	cardDealer := aCardDealer.
	activeCards := OrderedCollection new.
	playersFeature := aGroupOfPlayers collect: [ :ship |
		ShipCards createWith: ship id and: self dealInitialHand ]
]
