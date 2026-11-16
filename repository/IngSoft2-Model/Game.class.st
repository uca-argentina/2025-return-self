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
		'lastEffectApplied'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Game class >> mustHaveAtLeastOneDieToPlay: aSetOfDie [

	aSetOfDie isEmpty ifTrue: [
		Error signal: 'You must have at least one die to play.' ]
]

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

	self mustHaveAtLeastOneDieToPlay: aSetOfDie asOrderedCollection.
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

{ #category : 'battles' }
Game >> battleBetween: aShip and: aRival [

	| shipTeam rivalTeam |
	shipTeam := self teamOf: aShip.
	rivalTeam := self teamOf: aRival.
	(battleManager team: rivalTeam defeats: shipTeam using: setOfDie)
		ifTrue: [ self defeat: aShip fightingWith: shipTeam ]
		ifFalse: [ self defeat: aRival fightingWith: rivalTeam ]
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

{ #category : 'battles' }
Game >> defeat: aShip fightingWith: itsTeam [

	itsTeam do: [ :ship | self takeShields: 1 from: ship ].
	self moveToTheFirstTile: aShip
]

{ #category : 'private' }
Game >> effectAtTileOf: aShip [

	| tile |
	tile := positionManager tileOf: aShip.
	^ cardManager effect: (board effectAt: tile) atTile: tile
]

{ #category : 'battles' }
Game >> engageInBattle: aShip [

	(self rivalsOf: aShip) do: [ :rival |
		(positionManager is: aShip inTheSameTileAs: rival) ifTrue: [
			self battleBetween: aShip and: rival ] ]
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
	lastEffectApplied := NoEffect create
]

{ #category : 'testing' }
Game >> isWinner: aPlayerName [

	"Used for testing"
	^ players is: positionManager winner named: aPlayerName
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
	turnManager playNextTurn.
	battleManager forceAShieldResetTo: turnManager playerInTurn
]

{ #category : 'interaction loop' }
Game >> nextPlayerThrowsDice [

	| activeShip landedEffect movedByTheEffect |
	positionManager stillPlaying ifFalse: [ ^ self winner ].
	turnManager playNextTurn.
	activeShip := turnManager playerInTurn.
	positionManager
		move: activeShip
		forwardWith: (cardManager boost: setOfDie throw of: activeShip).
	landedEffect := self effectAtTileOf: activeShip.
	movedByTheEffect := self apply: landedEffect on: activeShip.
	lastEffectApplied := landedEffect.
	(movedByTheEffect or: [ landedEffect allowsBattleOnItsTile ]) ifTrue: [
		self engageInBattle: activeShip ]
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
		self engageInBattle: aShip ]
]

{ #category : 'battles' }
Game >> rivalsOf: aShip [

	^ (positionManager shipsSharingTileWith: aShip) reject: [ :another |
		cardManager is: aShip alliedWith: another ]
]

{ #category : 'testing' }
Game >> shieldsFeatureOf: aShip [

	"Used for testing"
	^ battleManager findShipReference: aShip
]

{ #category : 'effects' }
Game >> takeShields: anAmount from: aShip [

	anAmount timesRepeat: [ battleManager playerLoseShield: aShip ].
	self penalizeShipsOutOfShields
]

{ #category : 'battles' }
Game >> teamOf: aShip [

	^ cardManager teamOf: aShip
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
