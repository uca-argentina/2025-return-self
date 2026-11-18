Class {
	#name : 'TurnManager',
	#superclass : 'GameFeatureManager',
	#instVars : [
		'turnIndex'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
TurnManager class >> createWith: aGroupOfPlayers [

	| playerTurnAssociationGroup |
	playerTurnAssociationGroup := aGroupOfPlayers collect: [ :each |
		ShipInStandBy
			createWith: each id
			and: 0 ].
	^ self new initializePlayersTurnWith: playerTurnAssociationGroup
]

{ #category : 'adding' }
TurnManager >> addTwoSkipsTo: aPlayer [

	| playerToApply |
	playerToApply := self findShipReference: aPlayer.
	playerToApply := playerToApply addSkips: 2.
	self updateShipReference: playerToApply
]

{ #category : 'play interface' }
TurnManager >> beginTurn [

	[ self shipAtTurn hasTurnsToSkip ] whileTrue: [
		self updateShipReference: self shipAtTurn skipATurn.
		self endTurn ].
	^ self shipAtTurn
]

{ #category : 'play interface' }
TurnManager >> endTurn [

	turnIndex := turnIndex \\ playersFeature size + 1
]

{ #category : 'initialization' }
TurnManager >> initializePlayersTurnWith: aGroup [

	playersFeature := aGroup.
	turnIndex := 1
]

{ #category : 'testing' }
TurnManager >> isTurnOf: aPlayer [

	^ self playerInTurn equalsID: aPlayer
]

{ #category : 'accessing' }
TurnManager >> playerInTurn [

	^ self copy beginTurn
]

{ #category : 'private' }
TurnManager >> shipAtTurn [

	^ playersFeature at: turnIndex
]
