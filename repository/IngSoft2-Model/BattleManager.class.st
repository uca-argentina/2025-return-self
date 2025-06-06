Class {
	#name : 'BattleManager',
	#superclass : 'Object',
	#instVars : [
		'playersShieldData'
	],
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

{ #category : 'accessing' }
BattleManager >> activePlayerIndex: aPlayer [

^ playersShieldData findFirst: [ :each | each equals: aPlayer ]
]

{ #category : 'updating' }
BattleManager >> forceAShieldReset: aPlayer [

	| activePlayer activePlayerIndex |
	activePlayerIndex := self activePlayerIndex: aPlayer.
	activePlayer := playersShieldData at: activePlayerIndex.
	activePlayer := activePlayer forceAShieldReset.
	playersShieldData at: activePlayerIndex put: activePlayer
]

{ #category : 'play interface' }
BattleManager >> ifBattleThenEngage: aPlayer using: someDice [
   |playersToEngage |
	(aPlayer position = 1)  ifTrue:[^playersShieldData ].
	playersToEngage := self selectPlayersInSamePositionAs: aPlayer.
	
	playersToEngage size >= 2 ifTrue: ["si encuentra 2 o mas en la misma posicion"
		  (someDice throw > someDice throw) ifTrue: ["gana el primero"
			  playersToEngage at:2 put: (playersToEngage at:2 ) loseBattle.
			] ifFalse: ["gana el segundo"
			  playersToEngage at:1 put: (playersToEngage at:1 ) loseBattle.
			].
		] .
	self updateFightingPlayersWith: playersToEngage.
	^playersShieldData 
]

{ #category : 'play interface' }
BattleManager >> ifBattleThenEngagePlayerIn: aGame using: someDice [

"
   |playersToEngage |
	(aPlayer position = 1)  ifTrue:[^playersShieldData ].
	playersToEngage := self selectPlayersInSamePositionAs: aPlayer.
	
	playersToEngage size >= 2 ifTrue: [""si encuentra 2 o mas en la misma posicion""
		  (someDice throw > someDice throw) ifTrue: [""gana el primero""
			  playersToEngage at:2 put: (playersToEngage at:2 ) loseBattle.
			] ifFalse: [""gana el segundo""
			  playersToEngage at:1 put: (playersToEngage at:1 ) loseBattle.
			].
		] .
	self updateFightingPlayersWith: playersToEngage.
	^playersShieldData "
]

{ #category : 'initialization' }
BattleManager >> initializeBattleManagerWith: aGroupOfPlayers [

playersShieldData := aGroupOfPlayers 
]

{ #category : 'updating' }
BattleManager >> resetShieldsAfter2Turns: aPlayer [

	| activePlayer activePlayerIndex |
	activePlayerIndex := self activePlayerIndex: aPlayer.
	activePlayer := playersShieldData at: activePlayerIndex.
	activePlayer needsRecovery ifTrue: [ 
		activePlayer := activePlayer forceAShieldReset
	].
	playersShieldData at: activePlayerIndex put: activePlayer
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

{ #category : 'play interface' }
BattleManager >> selectPlayersInSamePositionAs: player [
	^playersShieldData select:[:each| each position = player position].
]

{ #category : 'updating' }
BattleManager >> updateFightingPlayersWith: playersToEngage [

"	playersToEngage do:[:justBattled |
		playersShieldData at:(playersShieldData findFirst:[:each | each name = justBattled  name]) put: justBattled .
		].
	"
	
]
