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
	activePlayer := positionManager findShipReference: activePlayer.
	anEffect := board applyEffectTriggeredBy: activePlayer.
	anEffect applyEffectOn: activePlayer and: self.
	(positionManager checkIfBattle: activePlayer) ifTrue: [
		self engageInBattle: activePlayer ]
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

{ #category : 'effects' }
Game >> requestBattleManager: anEffect [

	anEffect isEffect ifFalse: [
		Error signal: 'only Effects can ask for managers' ].
	^ battleManager
]

{ #category : 'effects' }
Game >> requestCardManager: anEffect [

	anEffect isEffect ifFalse: [
		Error signal: 'only Effects can ask for managers' ].
	^ cardManager
]

{ #category : 'effects' }
Game >> requestPositionManager: anEffect [

	anEffect isEffect ifFalse: [
		Error signal: 'only Effects can ask for managers' ].
	^ positionManager
]

{ #category : 'effects' }
Game >> requestTurnManager: anEffect [

	anEffect isEffect ifFalse: [
		Error signal: 'only Effects can ask for managers' ].
	^ turnManager
]

{ #category : 'testing' }
Game >> shieldsFeatureOf: aShip [

	"Used for testing"
	^ battleManager findShipReference: aShip
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
