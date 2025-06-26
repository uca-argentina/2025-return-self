Class {
	#name : 'BattleManager',
	#superclass : 'GameFeatureManager',
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
BattleManager >> allDecreaseAShield [

playersFeature do: [ :player | self updateShipReference: (player loseShields: 1) ].

^ playersFeature select: [ :player | player needsRecovery ].
]

{ #category : 'play interface' }
BattleManager >> engage: aPairOfPlayers inBattleUsing: someDice and: cardManager [

	| firstTeamThrow playersWhoLost playersToEngage firstTeam secondTeam secondTeamThrow |
	playersToEngage := aPairOfPlayers collect: [ :each |
		                   self findShipReference: each ].

	firstTeam := cardManager
		             checkIfMercenariesFor: (playersToEngage at: 1)
		             using: self.
	secondTeam := cardManager
		              checkIfMercenariesFor: (playersToEngage at: 2)
		              using: self.

	firstTeamThrow := (firstTeam collect: [ :card | someDice throw ]) max.
	secondTeamThrow := (firstTeam collect: [ :card | someDice throw ])
		                   max.

	[ firstTeamThrow = secondTeamThrow ] whileTrue: [
		firstTeamThrow := (firstTeam collect: [ :card | someDice throw ])
			                  max.
		secondTeamThrow := (firstTeam collect: [ :card | someDice throw ])
			                   max ].

	playersWhoLost := firstTeamThrow > secondTeamThrow
		                  ifTrue: [ "gana el primero"
			                  (secondTeam collect: [ :ship |
				                   ship loseShields: 1 ]) asOrderedCollection ]
		                  ifFalse: [ "gana el segundo"
			                  (firstTeam collect: [ :ship |
				                   ship loseShields: 1 ]) asOrderedCollection ].
	playersWhoLost do: [ :ship | self updateShipReference: ship ].

	^ playersWhoLost
]

{ #category : 'updating' }
BattleManager >> forceAShieldResetTo: aPlayer [

	| activePlayer |
	activePlayer := self findShipReference: aPlayer.
	activePlayer := activePlayer forceAShieldReset.
	self updateShipReference: activePlayer
]

{ #category : 'initialization' }
BattleManager >> initializeBattleManagerWith: aGroupOfPlayers [

playersFeature := aGroupOfPlayers 
]

{ #category : 'as yet unclassified' }
BattleManager >> playerLoseShield: aPlayer [

| aShipShield |
aShipShield := self findShipReference: aPlayer.

self updateShipReference: (aShipShield loseShields: 1).
]
