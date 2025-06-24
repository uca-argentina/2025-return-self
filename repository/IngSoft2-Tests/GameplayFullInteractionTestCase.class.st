Class {
	#name : 'GameplayFullInteractionTestCase',
	#superclass : 'ReturnSelfTestCase',
	#instVars : [
		'aPlayer',
		'aGroupOfPlayers',
		'aTileListCreator'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'testing' }
GameplayFullInteractionTestCase class >> isAbstract [

	^ self == GameplayFullInteractionTestCase
]

{ #category : 'running' }
GameplayFullInteractionTestCase >> setUp [

	super setUp.
	aPlayer := ShipPlayerAssociation createWith: 1 and: 'Juan'.
	aGroupOfPlayers := {
		                   (ShipPlayerAssociation createWith: 1 and: 'Juan').
		                   (ShipPlayerAssociation createWith: 2 and: 'Tomi') }.
	aTileListCreator := TileListCreationForTesting createTileListWith: 20
]
