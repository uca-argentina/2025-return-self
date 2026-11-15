Class {
	#name : 'CancellationCardTest',
	#superclass : 'GameWithCardsTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CancellationCardTest >> test01WhenACancellationCardIsPlayedThenTheChosenPermanentCardNoLongerHasEffect [

	| aGame |
	aGame := self
				 gameDealing: {
						 Speed.
						 Cancellation }
				 rolling: { 3 }.
	aGame player: aPlayer plays: (Speed createWith: aPlayer).
	aGame
		player: anotherPlayer
		plays: (Cancellation createWith: (Speed createWith: aPlayer)).
	self play: 1 in: aGame.
	self assert: (aGame positionFeatureOf: aPlayer) position equals: 4
]

{ #category : 'tests' }
CancellationCardTest >> test02WhenTryingToCancelACardThatIsNotInEffectThenItRaisesErrorAndTheCardStaysInTheHand [

	| aGame |
	aGame := self
				 gameDealing: {
						 Speed.
						 Cancellation }
				 rolling: { 3 }.
	self
		should: [
			aGame
				player: aPlayer
				plays: (Cancellation createWith: (Speed createWith: aPlayer)) ]
		raiseErrorWithMessageText:
		'There is no matching active card to cancel.'.
	self assert: (aGame cardsFeatureOf: aPlayer) deck size equals: 2
]

{ #category : 'tests' }
CancellationCardTest >> test03WhenACancellationCardCancelsAMercenaryThenTheShipAndItsFormerMercenaryBattleAgain [

	| aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 1, Lap: 0'.
							 'Name: Tomi, Position: 3, Lap: 0' }.
	aGame := self
				 gameDealing: {
						 Mercenary.
						 Cancellation }
				 rolling: { 2. 2. 1. 5 }.
	aGame player: aPlayer plays: (Mercenary createWith: anotherPlayer).
	aGame
		player: aPlayer
		plays: (Cancellation createWith: (Mercenary createWith: anotherPlayer)).
	self play: 2 in: aGame.
	self assert: aGame playerPositions equals: assertingVariableData
]
