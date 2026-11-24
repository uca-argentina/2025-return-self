"
Game handler class
"
Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'players',
		'setOfDie',
		'board',
		'turnManager',
		'battleManager',
		'positionManager',
		'cardManager',
		'battleReferee',
		'lastEffectApplied'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Game class >> playedBy: aGroupOfPlayers withBoard: aBoard withSetOfDie: aSetOfDie withLaps: laps [

	^ self
		playedBy: aGroupOfPlayers
		withBoard: aBoard
		withSetOfDie: aSetOfDie
		withLaps: laps
		withCardDealer: CardDealer withEveryCard
]

{ #category : 'creation' }
Game class >> playedBy: aGroupOfPlayers withBoard: aBoard withSetOfDie: aSetOfDie withLaps: laps withCardDealer: aCardDealer [

	^ self new
		initializePlayedBy: aGroupOfPlayers asOrderedCollection
		withBoard: aBoard
		withSetOfDie: aSetOfDie
		withLaps: laps
		withCardDealer: aCardDealer
]

{ #category : 'effects' }
Game >> advance: aShip by: aDistance [

	positionManager move: aShip forwardWithParsecs: aDistance asParsecs
]

{ #category : 'private' }
Game >> apply: anEffect on: aShip [

	| tileBeforeTheEffect |
	tileBeforeTheEffect := positionManager tileOf: aShip.
	anEffect applyEffectOn: aShip among: players everyShip and: self.
	^ (positionManager tileOf: aShip) ~= tileBeforeTheEffect
]

{ #category : 'private' }
Game >> assertGameIsNotFinished [

	positionManager stillPlaying ifFalse: [
		Error signal: 'Cards cannot be played once the game has finished.' ]
]

{ #category : 'cards' }
Game >> assertIsOnTheBoard: aTileNumber [

	board assertHasTile: aTileNumber
]

{ #category : 'cards' }
Game >> assertIsPlaying: aShip [

	players findShipReference: aShip
]

{ #category : 'cards' }
Game >> cancelActiveCard: aCard [

	cardManager deactivate: aCard
]

{ #category : 'testing' }
Game >> cardsFeatureOf: aShip [

	"Used for testing"
	^ cardManager findShipReference: aShip
]

{ #category : 'effects' }
Game >> dealCardTo: aShip [

	cardManager dealCardTo: aShip
]

{ #category : 'private' }
Game >> effectAtTileOf: aShip [

	| tile |
	tile := positionManager tileOf: aShip.
	^ cardManager effect: (board effectAt: tile) atTile: tile
]

{ #category : 'initialization' }
Game >> initializePlayedBy: aGroupOfPlayers withBoard: aBoard withSetOfDie: aSetOfDie withLaps: anAmountOfLaps withCardDealer: aCardDealer [

	players := PlayerManager createWith: aGroupOfPlayers.
	turnManager := TurnManager createWith: aGroupOfPlayers.
	battleManager := BattleManager createWith: aGroupOfPlayers.
	positionManager := PositionManager
						   createWith: aGroupOfPlayers
						   and: aBoard totalTiles
						   and: anAmountOfLaps
						   and: aBoard parsecsPerTile.
	cardManager := CardManager createWith: aGroupOfPlayers and: aCardDealer.
	setOfDie := aSetOfDie.
	board := aBoard.
	battleReferee := BattleReferee
						 createWithPositions: positionManager
						 cards: cardManager
						 shields: battleManager
						 dice: setOfDie.
	lastEffectApplied := NoEffect create
]

{ #category : 'testing' }
Game >> isWinner: aPlayerName [

	"Used for testing"
	^ players is: positionManager winner named: aPlayerName
]

{ #category : 'private' }
Game >> landOnItsTile: aShip [

	| landedEffect movedByTheEffect |
	landedEffect := self effectAtTileOf: aShip.
	movedByTheEffect := self apply: landedEffect on: aShip.
	lastEffectApplied := landedEffect.
	(movedByTheEffect or: [ landedEffect allowsBattleOnItsTile ]) ifTrue: [
		battleReferee engage: aShip in: self ]
]

{ #category : 'cards' }
Game >> lastPlayedCard [

	^ cardManager lastPlayedCard
]

{ #category : 'effects' }
Game >> move: aShip backward: aNumberOfTiles [

	positionManager move: aShip backwardWith: aNumberOfTiles
]

{ #category : 'effects' }
Game >> move: aShip forward: aNumberOfTiles [

	positionManager move: aShip forwardWith: aNumberOfTiles
]

{ #category : 'effects' }
Game >> move: aShip toTile: aTile [

	positionManager move: aShip toTile: aTile
]

{ #category : 'effects' }
Game >> moveToTheFirstTile: aShip [

	positionManager resetLapTo: aShip
]

{ #category : 'interaction loop' }
Game >> nextPlayerSkipsTurn [

	positionManager stillPlaying ifFalse: [ ^ self winner ].
	turnManager beginTurn.
	battleManager forceAShieldResetTo: turnManager playerInTurn.
	turnManager endTurn
]

{ #category : 'interaction loop' }
Game >> nextPlayerThrowsDice [

	| activeShip |
	positionManager stillPlaying ifFalse: [ ^ self winner ].
	turnManager beginTurn.
	activeShip := turnManager playerInTurn.
	positionManager
		move: activeShip
		forwardWith: (cardManager boost: setOfDie throw of: activeShip).
	self landOnItsTile: activeShip.
	turnManager endTurn
]

{ #category : 'private' }
Game >> penalizeShipsOutOfShields [

	battleManager shipsOutOfShields do: [ :ship |
		turnManager addTwoSkipsTo: ship.
		battleManager forceAShieldResetTo: ship ]
]

{ #category : 'interaction loop' }
Game >> playFullGame [

	[ positionManager stillPlaying ] whileTrue: [
		self nextPlayerThrowsDice ]
]

{ #category : 'cards' }
Game >> player: aShip activates: aPermanentCard [

	(turnManager isTurnOf: aShip) ifFalse: [
		Error signal:
			'Permanent cards can only be played during the turn of the ship.' ].
	cardManager activate: aPermanentCard
]

{ #category : 'interaction loop' }
Game >> player: aShip plays: aCard [

	| cardInEffect |
	self assertGameIsNotFinished.
	cardManager assert: aShip holds: aCard.
	cardInEffect := aCard playedBy: aShip in: self.
	cardManager storeLastCardPlayed: cardInEffect.
	cardManager discard: aCard from: aShip
]

{ #category : 'tests - printing' }
Game >> playerPositions [

	"Used for testing"
	^ (positionManager playerPositions collect: [ :each |
		String streamContents: [ :s |
			s nextPutAll: 'Name: '.
			s nextPutAll: (players nameOf: (each at: 1)).
			s nextPutAll: ', '.
			s nextPutAll: (each at: 2) ] ]) asArray
]

{ #category : 'tests - printing' }
Game >> playerRanking [

	"Used for testing"
	^ (players describeEveryPlayerWith: positionManager playerRanking) asArray
]

{ #category : 'testing' }
Game >> positionFeatureOf: aShip [

	"Used for testing"
	^ positionManager findShipReference: aShip
]

{ #category : 'cards' }
Game >> repeatLastEffectOn: aShip [

	self assertIsPlaying: aShip.
	(self apply: lastEffectApplied on: aShip) ifTrue: [
		battleReferee engage: aShip in: self ]
]

{ #category : 'cards' }
Game >> reverseTurnOrder [

	turnManager reverseOrder
]

{ #category : 'testing' }
Game >> shieldsFeatureOf: aShip [

	"Used for testing"
	^ battleManager findShipReference: aShip
]

{ #category : 'cards' }
Game >> shipInTurnLosesItsTurn [

	turnManager skipTurn
]

{ #category : 'cards' }
Game >> shipInTurnPlaysTwice [

	turnManager grantExtraTurn
]

{ #category : 'effects' }
Game >> takeShields: anAmount from: aShip [

	anAmount timesRepeat: [ battleManager playerLoseShield: aShip ].
	self penalizeShipsOutOfShields
]

{ #category : 'testing' }
Game >> turnsFeatureOf: aShip [

	"Used for testing"
	^ turnManager findShipReference: aShip
]

{ #category : 'accessing' }
Game >> winner [

	^ players findShipReference: positionManager winner
]
