Class {
	#name : 'PositionManager',
	#superclass : 'SpaceShipFeatureManager',
	#instVars : [
		'laps',
		'boardLength'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
PositionManager class >> createWith: aGroupOfPlayers and: anNumberOfTiles and: aNumberOfLaps [

	| playerPositionAssociationGroup |
	playerPositionAssociationGroup := aGroupOfPlayers collect: [ :each |
		                              ShipPosition
			                              createWith: each id	
			                              and: 0 ].

	^ self new initializePlayersPosition: playerPositionAssociationGroup and: anNumberOfTiles and: aNumberOfLaps
]

{ #category : 'positioning' }
PositionManager >> circleAroundTheTrackWithLength: boardLength [
	|amountOfBackTrack  newLap|
	newLap := 0.
	amountOfBackTrack := 0.
	position > boardLength ifTrue:
		[
			amountOfBackTrack := boardLength .
			newLap := 1.
		].
	^ self class
		  createWith: id
		  and: position - amountOfBackTrack
		  and: lap + newLap
]

{ #category : 'initialization' }
PositionManager >> initializePlayersPosition: aGroupOfPlayers and: aNumberOfTiles and: aNumberOfLaps [

	playersFeature := aGroupOfPlayers.
	laps := aNumberOfLaps.
	boardLength := aNumberOfTiles
]
