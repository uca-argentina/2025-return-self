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

{ #category : 'play interface' }
BattleManager >> engage: aPairOfPlayers inBattleUsing: someDice [

	| firstPlayerThrow secondPlayerThrow playerWhoLost playersToEngage |
	playersToEngage := aPairOfPlayers collect: [ :each |
		                   self findShipReference: each ].

	firstPlayerThrow := someDice throw.
	secondPlayerThrow := someDice throw.

	[ firstPlayerThrow = secondPlayerThrow ] whileTrue: [
		firstPlayerThrow := someDice throw.
		secondPlayerThrow := someDice throw ].

	playerWhoLost := firstPlayerThrow > secondPlayerThrow
		                 ifTrue: [ "gana el primero"
		                 (playersToEngage at: 2) loseShield ]
		                 ifFalse: [ "gana el segundo"
		                 (playersToEngage at: 1) loseShield ].

	self updateShipReference: playerWhoLost.
	^ playerWhoLost
]

{ #category : 'updating' }
BattleManager >> forceAShieldReset: aPlayer [

	| activePlayer |
	activePlayer := self findShipReference: aPlayer.
	activePlayer := activePlayer forceAShieldReset.
	self updateShipReference: activePlayer
]

{ #category : 'initialization' }
BattleManager >> initializeBattleManagerWith: aGroupOfPlayers [

playersFeature := aGroupOfPlayers 
]

{ #category : 'updating' }
BattleManager >> resetShieldsIfNeeded: aPlayer [

	| activePlayer |
	activePlayer := self findShipReference: aPlayer.
	activePlayer needsRecovery ifTrue: [ 
		activePlayer := activePlayer forceAShieldReset
	].
	self updateShipReference: activePlayer
]
