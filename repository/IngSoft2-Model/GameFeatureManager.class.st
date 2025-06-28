Class {
	#name : 'GameFeatureManager',
	#superclass : 'Object',
	#instVars : [
		'playersFeature'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
GameFeatureManager class >> mustHaveAtLeastTwoPlayers: aGroupOfPlayers [

	aGroupOfPlayers size < 2 ifTrue: [
		Error signal: 'You cant play with less than two players.' ]
]

{ #category : 'testing' }
GameFeatureManager class >> twoPlayersCantHaveTheSameId: aGroupOfPlayers [
	"when passed to Set, repeated values are cleaned"

	(aGroupOfPlayers collect: [ :each | each id ]) size
	= (aGroupOfPlayers collect: [ :each | each id ]) asSet size ifFalse: [
		Error signal: 'You cant have different players with the same ID.' ]
]

{ #category : 'accessing' }
GameFeatureManager >> findShipReference: aSpaceShipComponent [

	| shipFeature |
	shipFeature := playersFeature detect: [ :each |
		             each equalsID: aSpaceShipComponent ] ifNone: [Error signal: 'Player not in list'].
	^ shipFeature copyShip
]

{ #category : 'private - updating' }
GameFeatureManager >> updateShipReference: selfSpaceShipComponent [

	| shipIndex |
	shipIndex := playersFeature findFirst: [ :each |
		             each equalsID: selfSpaceShipComponent ].
	playersFeature at: shipIndex put: selfSpaceShipComponent
]
