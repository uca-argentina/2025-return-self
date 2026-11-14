Class {
	#name : 'CardManager',
	#superclass : 'GameFeatureManager',
	#instVars : [
		'cardDealer'
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

{ #category : 'hands' }
CardManager >> add: aCard to: aPlayer [

	self updateShipReference: ((self findShipReference: aPlayer) addToDeck: aCard)
]

{ #category : 'hands' }
CardManager >> dealCardTo: aPlayer [

	self add: cardDealer dealCard to: aPlayer
]

{ #category : 'hands' }
CardManager >> dealInitialHand [

	^ (1 to: self class initialHandSize) collect: [ :each | cardDealer dealCard ]
]

{ #category : 'initialization' }
CardManager >> initializeCardManagerWith: aGroupOfPlayers and: aCardDealer [

	cardDealer := aCardDealer.
	playersFeature := aGroupOfPlayers collect: [ :ship |
		ShipCards createWith: ship id and: self dealInitialHand ]
]
