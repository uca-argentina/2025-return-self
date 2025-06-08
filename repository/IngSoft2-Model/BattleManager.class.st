Class {
	#name : 'BattleManager',
	#superclass : 'SpaceShipFeatureManager',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
BattleManager class >> createWith: aGroupOfPlayers [

	| playerShieldAssociationGroup |
	playerShieldAssociationGroup := aGroupOfPlayers collect: [ :each |
		                                ShipShield
			                                createWith: each id
			                                and: 3 ].
	^ self new initializeBattleManagerWith: playerShieldAssociationGroup
]

{ #category : 'creation' }
BattleManager class >> createWith: aGroupOfPlayers and: initialShields [

	| playerShieldAssociationGroup |
	playerShieldAssociationGroup := aGroupOfPlayers collect: [ :each |
		                                ShipShield
			                                createWith: each id
			                                and: initialShields ].
	^ self new initializeBattleManagerWith: playerShieldAssociationGroup
]

{ #category : 'updating' }
BattleManager >> forceAShieldReset: aPlayer [

	| activePlayer activePlayerIndex |
	activePlayerIndex := self findPlayerIndex: aPlayer.
	activePlayer := playersFeature at: activePlayerIndex.
	activePlayer := activePlayer forceAShieldReset.
	playersFeature at: activePlayerIndex put: activePlayer
]

{ #category : 'play interface' }
BattleManager >> ifBattleThenEngage: playersToEngage using: someDice [
	"   |playersToEngage |
	(aPlayer position = 1)  ifTrue:[^playersShieldData ].
	playersToEngage := self selectPlayersInSamePositionAs: aPlayer.
	"

	"playersToEngage size >= 2 ifTrue: [""si encuentra 2 o mas en la misma posicion""
		ACA IRIA TODO PERO SIN EL WHILE
		] ."
	| firstPlayerThrow secondPlayerThrow playerWhoLost |
	firstPlayerThrow := someDice throw.
	secondPlayerThrow := someDice throw.

	firstPlayerThrow = secondPlayerThrow whileTrue: [
		firstPlayerThrow := someDice throw.
		secondPlayerThrow := someDice throw ].

	playerWhoLost := firstPlayerThrow > secondPlayerThrow
		                 ifTrue: [ "gana el primero"
			                 playersToEngage
				                 at: 2
				                 put: (playersToEngage at: 2) loseShield ]
		                 ifFalse: [ "gana el segundo"
			                 playersToEngage
				                 at: 1
				                 put: (playersToEngage at: 1) loseShield ].
	
	self updateFightingPlayersWith: playersToEngage.
	^ playerWhoLost
]

{ #category : 'initialization' }
BattleManager >> initializeBattleManagerWith: aGroupOfPlayers [

playersFeature := aGroupOfPlayers 
]

{ #category : 'updating' }
BattleManager >> resetShieldsAfter2Turns: aPlayer [

	| activePlayer activePlayerIndex |
	activePlayerIndex := self findPlayerIndex: aPlayer.
	activePlayer := playersFeature at: activePlayerIndex.
	activePlayer needsRecovery ifTrue: [ 
		activePlayer := activePlayer forceAShieldReset
	].
	playersFeature at: activePlayerIndex put: activePlayer
	"
	|newShield|
	newShield := shields.
	(shields <= 0) ifTrue:[ skipATurn <= 0 ifTrue:[newShield:=3]].
	
	^ self class
		  named: name
		  withPosition: position
		  withLaps: lap
		  withShield: newShield "
]

{ #category : 'updating' }
BattleManager >> updateFightingPlayersWith: playersToEngage [

	playersToEngage do: [ :justBattled |
		playersFeature
			at:
			(playersFeature findFirst: [ :each | each equals: justBattled ])
			put: justBattled ]
]
