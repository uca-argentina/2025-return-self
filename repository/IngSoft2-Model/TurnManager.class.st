Class {
	#name : 'TurnManager',
	#superclass : 'GameFeatureManager',
	#instVars : [
		'turnIndex',
		'direction',
		'extraTurns'
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

	extraTurns > 0
		ifTrue: [ extraTurns := extraTurns - 1 ]
		ifFalse: [ turnIndex := turnIndex - 1 + direction \\ playersFeature size + 1 ]
]

{ #category : 'play interface' }
TurnManager >> grantExtraTurn [

	self beginTurn.
	extraTurns := extraTurns + 1
]

{ #category : 'initialization' }
TurnManager >> initializePlayersTurnWith: aGroup [

	playersFeature := aGroup.
	turnIndex := 1.
	direction := 1.
	extraTurns := 0
]

{ #category : 'testing' }
TurnManager >> isTurnOf: aPlayer [

	^ self playerInTurn equalsID: aPlayer
]

{ #category : 'accessing' }
TurnManager >> playerInTurn [

	^ self copy beginTurn
]

{ #category : 'play interface' }
TurnManager >> reverseOrder [

	direction := direction negated
]

{ #category : 'private' }
TurnManager >> shipAtTurn [

	^ playersFeature at: turnIndex
]

{ #category : 'play interface' }
TurnManager >> skipTurn [

	self beginTurn.
	self endTurn
]
