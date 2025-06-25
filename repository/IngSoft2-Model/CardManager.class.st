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
		                              ShipCards
			                              createWith: each id
			                              and: CardCollection create ].
	^ self new initializeCardManagerWith: playerCardAssociationGroup
]

{ #category : 'initialization' }
CardManager >> initializeCardManagerWith: aGroupOfPlayers [

	playersFeature := aGroupOfPlayers
]
