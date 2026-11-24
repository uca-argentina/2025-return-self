Class {
	#name : 'CardManager',
	#superclass : 'GameFeatureManager',
	#instVars : [
		'cardDealer',
		'activeCards',
		'lastPlayedCard'
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

	aPermanentCard assertCanBeActivatedWith: activeCards.
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

{ #category : 'active cards' }
CardManager >> deactivate: aCard [

	| cardToCancel |
	cardToCancel := activeCards
						detect: [ :card | card equalsACard: aCard ]
						ifNone: [
						Error signal:
							'There is no matching active card to cancel.' ].
	activeCards remove: cardToCancel
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

{ #category : 'active cards' }
CardManager >> effect: anEffect atTile: aTileNumber [

	^ activeCards
		inject: anEffect
		into: [ :effectInTheTile :card | card effect: effectInTheTile atTile: aTileNumber ]
]

{ #category : 'initialization' }
CardManager >> initializeCardManagerWith: aGroupOfPlayers and: aCardDealer [

	cardDealer := aCardDealer.
	activeCards := OrderedCollection new.
	lastPlayedCard := NoCard create.
	playersFeature := aGroupOfPlayers collect: [ :ship |
		ShipCards createWith: ship id and: self dealInitialHand ]
]

{ #category : 'mercenaries' }
CardManager >> is: aPlayer alliedWith: anotherPlayer [

	^ ((self mercenariesOf: aPlayer) anySatisfy: [ :mercenary |
		   mercenary equalsID: anotherPlayer ]) or: [
		  (self mercenariesOf: anotherPlayer) anySatisfy: [ :mercenary |
			  mercenary equalsID: aPlayer ] ]
]

{ #category : 'history' }
CardManager >> lastPlayedCard [

	^ lastPlayedCard
]

{ #category : 'mercenaries' }
CardManager >> mercenariesOf: aPlayer [

	| mercenaries |
	mercenaries := OrderedCollection new.
	activeCards do: [ :card | card addMercenariesOf: aPlayer to: mercenaries ].
	^ mercenaries
]

{ #category : 'history' }
CardManager >> storeLastCardPlayed: aCard [

	lastPlayedCard := aCard
]

{ #category : 'mercenaries' }
CardManager >> teamOf: aPlayer [

	^ (OrderedCollection with: aPlayer)
		addAll: (self mercenariesOf: aPlayer);
		yourself
]
