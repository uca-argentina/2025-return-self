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
		'cardManager'
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

	self mustHaveAtLeastOneDieToPlay: aSetOfDie asOrderedCollection.
	^ self new
		initializePlayedBy: aGroupOfPlayers asOrderedCollection
		withBoard: aBoard
		withSetOfDie: aSetOfDie
		withLaps: laps
]

{ #category : 'testing' }
Game >> activeCards [

	^ cardManager permanentAppliedCards
]

{ #category : 'effects' }
Game >> advance: aShip by: aDistance [

	positionManager move: aShip forwardWithParsecs: aDistance asParsecs
]

{ #category : 'testing' }
Game >> cardsFeatureOf: aShip [

	"Used for testing"
	^ cardManager findShipReference: aShip
]

{ #category : 'checking' }
Game >> engageInBattle: activePlayer [

	| playersToEngage playersWhoLost |
	playersToEngage := positionManager playerInSamePositionThan:
						   activePlayer.
	playersWhoLost := battleManager
						  engage: playersToEngage
						  inBattleUsing: setOfDie
						  and: cardManager.
	playersWhoLost do: [ :player |
		player needsRecovery ifTrue: [
			turnManager addTwoSkipsTo: player.
			battleManager forceAShieldResetTo: player ].
		positionManager resetLapTo: player ]
]

{ #category : 'effects' }
Game >> give: aCard to: aShip [

	cardManager add: aCard to: aShip
]

{ #category : 'initialization' }
Game >> initializePlayedBy: aGroupOfPlayers withBoard: aBoard withSetOfDie: aSetOfDie withLaps: anAmountOfLaps [

	players := PlayerManager createWith: aGroupOfPlayers.
	turnManager := TurnManager createWith: aGroupOfPlayers.
	battleManager := BattleManager createWith: aGroupOfPlayers.
	positionManager := PositionManager
						   createWith: aGroupOfPlayers
						   and: aBoard totalTiles
						   and: anAmountOfLaps
						   and: aBoard parsecsPerTile.
	cardManager := CardManager createWith: aGroupOfPlayers.
	setOfDie := aSetOfDie.
	board := aBoard
]

{ #category : 'testing' }
Game >> isGame [

	^ true
]

{ #category : 'testing' }
Game >> isWinner: aPlayerName [

	"Used for testing"
	^ players is: positionManager winner named: aPlayerName
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
Game >> moveEveryoneExcept: aShip backward: aNumberOfTiles [

	positionManager
		moveEveryoneExcept: aShip
		backwardsWith: aNumberOfTiles
]

{ #category : 'effects' }
Game >> moveEveryoneToTheFirstTile [

	positionManager resetPlayersPosition
]

{ #category : 'interaction loop' }
Game >> nextPlayerSkipsTurn [

	| activePlayer |
	positionManager stillPlaying ifFalse: [ ^ self winner ].
	turnManager nextPlayerTurnBegins.
	activePlayer := turnManager playerInTurn.
	battleManager forceAShieldResetTo: activePlayer
]

{ #category : 'interaction loop' }
Game >> nextPlayerThrowsDice [

	| activePlayer anEffect aTotalThrow |
	positionManager stillPlaying ifFalse: [ ^ self winner ].
	turnManager playNextTurn.
	activePlayer := turnManager playerInTurn.
	aTotalThrow := cardManager
					   checkIfBonusToApplyTo: activePlayer
					   using: setOfDie.
	positionManager move: activePlayer forwardWith: aTotalThrow.
	anEffect := board effectAt: (positionManager tileOf: activePlayer).
	anEffect applyEffectOn: activePlayer and: self.
	(positionManager checkIfBattle: activePlayer) ifTrue: [
		self engageInBattle: activePlayer ]
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

{ #category : 'interaction loop' }
Game >> player: aPlayer preparesIfAny: aCard setupWith: context [

	cardManager player: aPlayer preparesIfAny: aCard setupWith: context
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

{ #category : 'testing' }
Game >> shieldsFeatureOf: aShip [

	"Used for testing"
	^ battleManager findShipReference: aShip
]

{ #category : 'effects' }
Game >> takeAShieldFromEveryone [

	battleManager allDecreaseAShield.
	self penalizeShipsOutOfShields
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
