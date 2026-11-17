Class {
	#name : 'ReversePolarityCardTest',
	#superclass : 'GameWithCardsTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ReversePolarityCardTest >> test01WhenTheTileOfAnEffectThatAffectsTheLandingShipIsReversedThenItAffectsEveryOtherShip [

	| aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 2, Lap: 0'.
							 'Name: Tomi, Position: 12, Lap: 0' }.
	aTileListCreator at: 12 put: BlackHole create.
	aGame := self gameDealing: { ReversePolarity } rolling: { 5. 11 }.
	aGame player: aPlayer plays: (ReversePolarity createWith: 12).
	self play: 2 in: aGame.
	self assert: aGame playerPositions equals: assertingVariableData
]

{ #category : 'tests' }
ReversePolarityCardTest >> test02WhenTheTileOfAnEffectThatAffectsEveryOtherShipIsReversedThenItAffectsOnlyTheLandingShip [

	| aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 4, Lap: 0'.
							 'Name: Tomi, Position: 3, Lap: 0' }.
	aTileListCreator at: 7 put: (MoonWalk createEspeciallyWith: 3).
	aGame := self gameDealing: { ReversePolarity } rolling: { 6. 2 }.
	aGame player: aPlayer plays: (ReversePolarity createWith: 7).
	self play: 2 in: aGame.
	self assert: aGame playerPositions equals: assertingVariableData
]

{ #category : 'tests' }
ReversePolarityCardTest >> test03WhenTheTileOfAnEffectThatAffectsEveryShipIsReversedThenItAffectsNoShip [

	| aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 3, Lap: 0'.
							 'Name: Tomi, Position: 5, Lap: 0' }.
	aTileListCreator at: 5 put: AtomikBomb create.
	aGame := self gameDealing: { ReversePolarity } rolling: { 2. 4 }.
	aGame player: aPlayer plays: (ReversePolarity createWith: 5).
	self play: 2 in: aGame.
	self assert: aGame playerPositions equals: assertingVariableData.
	self assert: (aGame shieldsFeatureOf: aPlayer) shields equals: 3.
	self assert: (aGame shieldsFeatureOf: anotherPlayer) shields equals: 3
]

{ #category : 'tests' }
ReversePolarityCardTest >> test04WhenTheTileOfAWormholeIsReversedThenEveryOtherShipTravelsToItsOtherEnd [

	| aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 3, Lap: 0'.
							 'Name: Tomi, Position: 19, Lap: 0' }.
	aTileListCreator at: 3 put: (Wormhole createWith: 19).
	aGame := self gameDealing: { ReversePolarity } rolling: { 2 }.
	aGame player: aPlayer plays: (ReversePolarity createWith: 3).
	self play: 1 in: aGame.
	self assert: aGame playerPositions equals: assertingVariableData
]

{ #category : 'tests' }
ReversePolarityCardTest >> test05WhenATileIsReversedThenTheOtherTilesWithTheSameEffectStayUntouched [

	| aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 2, Lap: 0'.
							 'Name: Tomi, Position: 1, Lap: 0' }.
	aTileListCreator at: 6 put: BlackHole create.
	aTileListCreator at: 12 put: BlackHole create.
	aGame := self gameDealing: { ReversePolarity } rolling: { 5 }.
	aGame player: aPlayer plays: (ReversePolarity createWith: 12).
	self play: 1 in: aGame.
	self assert: aGame playerPositions equals: assertingVariableData
]

{ #category : 'tests' }
ReversePolarityCardTest >> test06WhenATileIsReversedTwiceThenItsEffectIsTheOriginalOneAgain [

	| aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 6, Lap: 0'.
							 'Name: Tomi, Position: 8, Lap: 0' }.
	aTileListCreator at: 12 put: BlackHole create.
	aGame := self gameDealing: { ReversePolarity } rolling: { 5. 11 }.
	aGame player: aPlayer plays: (ReversePolarity createWith: 12).
	aGame player: aPlayer plays: (ReversePolarity createWith: 12).
	self play: 2 in: aGame.
	self assert: aGame playerPositions equals: assertingVariableData
]

{ #category : 'tests' }
ReversePolarityCardTest >> test07WhenTryingToPlayAReversePolarityCardOutOfTheTurnOfTheShipThenItRaisesError [

	| aGame |
	aGame := self gameDealing: { ReversePolarity } rolling: { 5 }.
	self
		should: [ aGame player: anotherPlayer plays: (ReversePolarity createWith: 12) ]
		raiseErrorWithMessageText:
		'Permanent cards can only be played during the turn of the ship.'
]

{ #category : 'tests' }
ReversePolarityCardTest >> test08WhenTryingToReverseATileThatIsNotOnTheBoardThenItRaisesErrorAndTheCardStaysInTheHand [

	| aGame |
	aGame := self gameDealing: { ReversePolarity } rolling: { 5 }.
	self
		should: [ aGame player: aPlayer plays: (ReversePolarity createWith: 21) ]
		raiseErrorWithMessageText: 'The tile is not on the board.'.
	self assert: (aGame cardsFeatureOf: aPlayer) deck size equals: 2
]

{ #category : 'tests' }
ReversePolarityCardTest >> test09WhenAReversePolarityCardIsCancelledThenTheEffectOfItsTileIsTheOriginalOneAgain [

	| aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 6, Lap: 0'.
							 'Name: Tomi, Position: 8, Lap: 0' }.
	aTileListCreator at: 12 put: BlackHole create.
	aGame := self
				 gameDealing: {
						 ReversePolarity.
						 Cancellation }
				 rolling: { 5. 11 }.
	aGame player: aPlayer plays: (ReversePolarity createWith: 12).
	aGame
		player: anotherPlayer
		plays: (Cancellation createWith: (ReversePolarity createWith: 12)).
	self play: 2 in: aGame.
	self assert: aGame playerPositions equals: assertingVariableData
]

{ #category : 'tests' }
ReversePolarityCardTest >> test10WhenTheLastEffectAppliedWasReversedThenARepeatCardAppliesItReversedToo [

	| aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 2, Lap: 0'.
							 'Name: Tomi, Position: 8, Lap: 0' }.
	aTileListCreator at: 12 put: BlackHole create.
	aGame := self
				 gameDealing: {
						 ReversePolarity.
						 Repeat }
				 rolling: { 5. 11 }.
	aGame player: aPlayer plays: (ReversePolarity createWith: 12).
	self play: 2 in: aGame.
	aGame player: aPlayer plays: (Repeat createWith: aPlayer).
	self assert: aGame playerPositions equals: assertingVariableData
]

{ #category : 'tests' }
ReversePolarityCardTest >> test11WhenTheTileOfAHyperJumpIsReversedThenEveryOtherShipAdvancesTheSameDistance [

	| aGame aThirdPlayer |
	aThirdPlayer := ShipPlayerAssociation createWith: 3 and: 'Pedro'.
	aGroupOfPlayers := aGroupOfPlayers , { aThirdPlayer }.
	aTileListCreator at: 3 put: HyperJump create.
	aGame := self gameDealing: { ReversePolarity } rolling: { 2 }.
	aGame player: aPlayer plays: (ReversePolarity createWith: 3).
	self play: 1 in: aGame.
	self assert: (aGame positionFeatureOf: aPlayer) position equals: 3.
	self assert: (aGame positionFeatureOf: anotherPlayer) position equals: 3.
	self assert: (aGame positionFeatureOf: aThirdPlayer) position equals: 3
]

{ #category : 'tests' }
ReversePolarityCardTest >> test12WhenTheTileThatGivesCardsIsReversedThenEveryOtherShipGetsACard [

	| aGame |
	aTileListCreator at: 4 put: CardGiver create.
	aGame := self gameDealing: { ReversePolarity } rolling: { 3 }.
	aGame player: aPlayer plays: (ReversePolarity createWith: 4).
	self play: 1 in: aGame.
	self assert: (aGame cardsFeatureOf: aPlayer) deck size equals: 1.
	self assert: (aGame cardsFeatureOf: anotherPlayer) deck size equals: 3
]
