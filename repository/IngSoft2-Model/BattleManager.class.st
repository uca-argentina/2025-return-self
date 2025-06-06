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

{ #category : 'as yet unclassified' }
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

{ #category : 'initialization' }
BattleManager >> initializeBattleManagerWith: aGroupOfPlayers [

playersShieldData := aGroupOfPlayers 
]

{ #category : 'as yet unclassified' }
BattleManager >> selectPlayersInSamePositionAs: player [
	^playersShieldData select:[:each| each position = player position].
]

{ #category : 'as yet unclassified' }
BattleManager >> updateFightingPlayersWith: playersToEngage [

"	playersToEngage do:[:justBattled |
		playersShieldData at:(playersShieldData findFirst:[:each | each name = justBattled  name]) put: justBattled .
		].
	"
	
]

{ #category : 'updating' }
BattleManager >> updateWith: aGroupOfPlayers [

^self class createWith: aGroupOfPlayers
]
