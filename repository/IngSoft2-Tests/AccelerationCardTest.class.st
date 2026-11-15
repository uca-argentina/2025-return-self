Class {
	#name : 'AccelerationCardTest',
	#superclass : 'GameWithCardsTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
AccelerationCardTest >> test01WhenAnAccelerationCardIsPlayedThenEveryShipAdvancesOneMoreTileOnEveryThrow [

	| aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 5, Lap: 0'.
							 'Name: Tomi, Position: 7, Lap: 0' }.
	aGame := self gameDealing: { Acceleration } rolling: { 3. 5 }.
	aGame player: aPlayer plays: Acceleration create.
	self play: 2 in: aGame.
	self assert: aGame playerPositions equals: assertingVariableData
]

{ #category : 'tests' }
AccelerationCardTest >> test02WhenSeveralCardsIncreaseTheThrowOfAShipThenTheirEffectsAddUp [

	| aGame |
	aGame := self
				 gameDealing: {
						 Speed.
						 Acceleration }
				 rolling: { 3 }.
	aGame player: aPlayer plays: (Speed createWith: aPlayer).
	aGame player: aPlayer plays: Acceleration create.
	self play: 1 in: aGame.
	self assert: (aGame positionFeatureOf: aPlayer) position equals: 6
]

{ #category : 'tests' }
AccelerationCardTest >> test03WhenTryingToPlayAPermanentCardOutOfTheTurnOfTheShipThenItRaisesErrorAndTheCardStaysInItsHand [

	| aGame |
	aGame := self gameDealing: { Acceleration } rolling: { 3 }.
	self
		should: [ aGame player: anotherPlayer plays: Acceleration create ]
		raiseErrorWithMessageText:
		'Permanent cards can only be played during the turn of the ship.'.
	self assert: (aGame cardsFeatureOf: anotherPlayer) deck size equals: 2
]
