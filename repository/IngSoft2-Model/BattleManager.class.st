Class {
	#name : 'BattleManager',
	#superclass : 'GameFeatureManager',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
BattleManager class >> createWith: aGroupOfPlayers [

	^ self new initializeBattleManagerWith:
		(aGroupOfPlayers collect: [ :each | ShipShield createFullWith: each id ])
]

{ #category : 'battling' }
BattleManager >> bestThrowOf: aTeam using: someDice [

	^ (aTeam collect: [ :ship | someDice throw ]) max
]

{ #category : 'updating' }
BattleManager >> forceAShieldResetTo: aPlayer [

	self updateShipReference: (self findShipReference: aPlayer) forceAShieldReset
]

{ #category : 'initialization' }
BattleManager >> initializeBattleManagerWith: aGroupOfPlayers [

	playersFeature := aGroupOfPlayers
]

{ #category : 'updating' }
BattleManager >> playerLoseShield: aPlayer [

	self updateShipReference: ((self findShipReference: aPlayer) loseShields: 1)
]

{ #category : 'accessing' }
BattleManager >> shipsOutOfShields [

	^ playersFeature select: [ :player | player needsRecovery ]
]

{ #category : 'battling' }
BattleManager >> team: aTeam defeats: anotherTeam using: someDice [

	| aTeamThrow anotherTeamThrow |
	[
	aTeamThrow := self bestThrowOf: aTeam using: someDice.
	anotherTeamThrow := self bestThrowOf: anotherTeam using: someDice.
	aTeamThrow = anotherTeamThrow ] whileTrue.
	^ aTeamThrow > anotherTeamThrow
]
