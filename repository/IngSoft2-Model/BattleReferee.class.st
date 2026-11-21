Class {
	#name : 'BattleReferee',
	#superclass : 'Object',
	#instVars : [
		'positionManager',
		'cardManager',
		'battleManager',
		'dice'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
BattleReferee class >> createWithPositions: aPositionManager cards: aCardManager shields: aBattleManager dice: someDice [

	^ self new
		initializeWithPositions: aPositionManager
		cards: aCardManager
		shields: aBattleManager
		dice: someDice
]

{ #category : 'private' }
BattleReferee >> battleBetween: aShip and: aRival in: aGame [

	| shipTeam rivalTeam |
	shipTeam := cardManager teamOf: aShip.
	rivalTeam := cardManager teamOf: aRival.
	(battleManager team: rivalTeam defeats: shipTeam using: dice)
		ifTrue: [ self defeat: aShip fightingWith: shipTeam in: aGame ]
		ifFalse: [ self defeat: aRival fightingWith: rivalTeam in: aGame ]
]

{ #category : 'private' }
BattleReferee >> defeat: aShip fightingWith: itsTeam in: aGame [

	itsTeam do: [ :ship | aGame takeShields: 1 from: ship ].
	aGame moveToTheFirstTile: aShip
]

{ #category : 'battling' }
BattleReferee >> engage: aShip in: aGame [

	(self rivalsOf: aShip) do: [ :rival |
		(positionManager is: aShip inTheSameTileAs: rival) ifTrue: [
			self battleBetween: aShip and: rival in: aGame ] ]
]

{ #category : 'initialization' }
BattleReferee >> initializeWithPositions: aPositionManager cards: aCardManager shields: aBattleManager dice: someDice [

	positionManager := aPositionManager.
	cardManager := aCardManager.
	battleManager := aBattleManager.
	dice := someDice
]

{ #category : 'private' }
BattleReferee >> rivalsOf: aShip [

	^ (positionManager shipsSharingTileWith: aShip) reject: [ :another |
		cardManager is: aShip alliedWith: another ]
]
