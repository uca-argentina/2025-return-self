Class {
	#name : 'CardManager',
	#superclass : 'GameFeatureManager',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
CardManager class >> createWith: aGroupOfPlayers [

	| playerCardAssociationGroup |
	playerCardAssociationGroup := aGroupOfPlayers collect: [ :each |
		                              ShipCards createWith: each id ].
	^ self new initializeCardManagerWith: playerCardAssociationGroup
]

{ #category : 'creation' }
CardManager class >> createWith: aGroupOfPlayers and: specificDeck [

	| playerCardAssociationGroup |
	playerCardAssociationGroup := aGroupOfPlayers collect: [ :each |
		                              ShipCards
			                              createWith: each id
			                              and: specificDeck ].
	^ self new initializeCardManagerWith: playerCardAssociationGroup
]

{ #category : 'adding' }
CardManager >> add: aCard to: aPlayer [

	| ship |
	ship := self findShipReference: aPlayer.
	ship := ship addToDeck: aCard.
	self updateShipReference: ship.
]

{ #category : 'initialization' }
CardManager >> initializeCardManagerWith: aGroupOfPlayers [

	playersFeature := aGroupOfPlayers
]
