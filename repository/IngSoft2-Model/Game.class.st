"
Game handler class
"
Class {
	#name : 'Game',
	#superclass : 'GameFeatureManager',
	#instVars : [
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

	aSetOfDie isEmpty ifTrue: [ Error signal: 'You must have at least one die to play.' ]
]

{ #category : 'creation' }
Game class >> playedBy: aGroupOfPlayers withBoard: aBoard withSetOfDie: aSetOfDie withLaps: laps [

	| aGroupOfXPlayers |
	aGroupOfXPlayers := aGroupOfPlayers asOrderedCollection.
	self mustHaveAtLeastTwoPlayers: aGroupOfXPlayers.
	self twoPlayersCantHaveTheSameId: aGroupOfXPlayers.
	self mustHaveAtLeastOneDieToPlay: aSetOfDie asOrderedCollection.
	^ self new
		  initializePlayedBy: aGroupOfXPlayers
		  withBoard: aBoard
		  withSetOfDie: aSetOfDie
		  withLaps: laps
]

{ #category : 'as yet unclassified' }
Game >> activeCards [

	^cardManager permanentAppliedCards.
]

{ #category : 'testing' }
Game >> cardsFeatureOf: aShip [
	"Used for testing"

	^ cardManager findShipReference: aShip
]

{ #category : 'checking' }
Game >> engageInBattle: activePlayer [

	| playersToEngage playerWhoLost |
	playersToEngage := positionManager playerInSamePositionThan:
		                   activePlayer.
	playerWhoLost := battleManager
		                 engage: playersToEngage
		                 inBattleUsing: setOfDie.
	playerWhoLost needsRecovery ifTrue: [
		turnManager addTwoSkipsTo: playerWhoLost.
		battleManager forceAShieldResetTo: playerWhoLost ].
	positionManager resetLapTo: playerWhoLost
]

{ #category : 'initialization' }
Game >> initializePlayedBy: aGroupOfPlayers withBoard: aBoard withSetOfDie: aSetOfDie withLaps: anAmountOfLaps [

	turnManager := TurnManager createWith: aGroupOfPlayers.
	battleManager := BattleManager createWith: aGroupOfPlayers.
	positionManager := PositionManager
		                   createWith: aGroupOfPlayers
		                   and: aBoard totalTiles
		                   and: anAmountOfLaps
		                   and: aBoard parsecsPerTile.
	setOfDie := aSetOfDie.
	board := aBoard.
	cardManager := CardManager createWith: aGroupOfPlayers.
	playersFeature := aGroupOfPlayers
]

{ #category : 'testing' }
Game >> isWinner: aPlayerName [
	"Used for testing"

	| aPlayer |
	aPlayer := self findShipReference: positionManager winner.
	^ aPlayer equalsName: aPlayerName
]

{ #category : 'interaction loop' }
Game >> nextPlayerSkipsTurn [

	| activePlayer |
	positionManager stillPlaying ifFalse: [ ^ self findShipReference: positionManager winner ].
	turnManager nextPlayerTurnBegins.
	activePlayer := turnManager playerInTurn.
	battleManager forceAShieldResetTo: activePlayer.
]

{ #category : 'interaction loop' }
Game >> nextPlayerThrowsDice [

	| activePlayer anEffect |
	positionManager stillPlaying ifFalse: [
		^ self findShipReference: positionManager winner ].

	"---Turno---"
	turnManager playNextTurn.
	activePlayer := turnManager playerInTurn.

	"---Avanza con la tirada---"
	positionManager move: activePlayer forwardWith: setOfDie throw.

	"---Aplicacion de efecto---"
	"VERIFICAR EN LA BRANCH QUE FALTA, quizas meta que el check anterior"
	"me devuelva la lista de los shipshields para poder pasarsela al board, aunque"
	"capaz me convenga simplemente pasar el Game"
	activePlayer := positionManager findShipReference: activePlayer.
	anEffect := board applyEffectTriggeredBy: activePlayer.
	anEffect applyEffectOn: activePlayer and: self.
	"PARA LA EXCESIVA CANTIDAD DE ELEMENTOS HACEMOS MULTIPLE DISPATCH"
	"---Batalla---"
	(positionManager checkIfBattle: activePlayer) ifTrue: [
		self engageInBattle: activePlayer ]
]

{ #category : 'interaction loop' }
Game >> nextPlayerUses: aCard whichImpacts: caca [

	| activePlayer anEffect |
	positionManager stillPlaying ifFalse: [
		^ self findShipReference: positionManager winner ].

	"---Turno---"
	turnManager playNextTurn.
	activePlayer := turnManager playerInTurn.

	"---Avanza con la tirada---"
	positionManager move: activePlayer forwardWith: setOfDie throw.

	"---Aplicacion de efecto---"
	"VERIFICAR EN LA BRANCH QUE FALTA, quizas meta que el check anterior"
	"me devuelva la lista de los shipshields para poder pasarsela al board, aunque"
	"capaz me convenga simplemente pasar el Game"
	activePlayer := positionManager findShipReference: activePlayer.
	anEffect := board applyEffectTriggeredBy: activePlayer.
	anEffect applyEffectOn: activePlayer and: self.
	"PARA LA EXCESIVA CANTIDAD DE ELEMENTOS HACEMOS MULTIPLE DISPATCH"
	"---Batalla---"
	(positionManager checkIfBattle: activePlayer) ifTrue: [
		self engageInBattle: activePlayer ]
]

{ #category : 'interaction loop' }
Game >> playFullGame [

	[ positionManager stillPlaying ] whileTrue: [ self nextPlayerThrowsDice ]
]

{ #category : 'as yet unclassified' }
Game >> player: aPlayer preparesIfAny: aCard setupWith: context [

	cardManager player: aPlayer preparesIfAny: aCard setupWith: context
]

{ #category : 'tests - printing' }
Game >> playerPositions [
	"Used for testing"

	| positionsWithoutName |
	positionsWithoutName := positionManager playerPositions.
	^ (positionsWithoutName
		   inject: OrderedCollection new
		   into: [ :col :each |
			   col add: (String streamContents: [ :s |
					    s nextPutAll: 'Name: '.
					    s nextPutAll: (self findShipReference: (each at: 1)) name.
					    s nextPutAll: ', '.
					    s nextPutAll: (each at: 2) ]).
			   col ]) asArray
]

{ #category : 'tests - printing' }
Game >> playerRanking [
	"Used for testing"

	| positionsWithoutName |
	positionsWithoutName := positionManager playerRanking.
	^ (playersFeature collect: [ :each |
		   each searchReferenceAndConcatName: positionsWithoutName ])
		  asArray
]

{ #category : 'testing' }
Game >> positionFeatureOf: aShip [
	"Used for testing"

	^ positionManager findShipReference: aShip
]

{ #category : 'as yet unclassified' }
Game >> requestBattleManager: anEffect [

anEffect isEffect ifFalse: [ Error signal: 'only Effects can ask for managers' ].

^ battleManager.
]

{ #category : 'as yet unclassified' }
Game >> requestCardManager: anEffect [

anEffect isEffect ifFalse: [ Error signal: 'only Effects can ask for managers' ].

^ cardManager.
]

{ #category : 'as yet unclassified' }
Game >> requestPositionManager: anEffect [

anEffect isEffect ifFalse: [ Error signal: 'only Effects can ask for managers' ].

^ positionManager.
]

{ #category : 'as yet unclassified' }
Game >> requestTurnManager: anEffect [

anEffect isEffect ifFalse: [ Error signal: 'only Effects can ask for managers' ].

^ turnManager.
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
