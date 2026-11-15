Class {
	#name : 'RedoCardTest',
	#superclass : 'GameWithCardsTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
RedoCardTest >> test01WhenARedoCardIsPlayedAfterAPermanentCardThenItHasTheSameEffectOnTheNewChosenShip [

	| aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 5, Lap: 0'.
							 'Name: Tomi, Position: 7, Lap: 0' }.
	aGame := self
				 gameDealing: {
						 Speed.
						 Redo }
				 rolling: { 3. 5 }.
	aGame player: aPlayer plays: (Speed createWith: aPlayer).
	aGame player: aPlayer plays: (Redo createWith: anotherPlayer).
	self play: 2 in: aGame.
	self assert: aGame playerPositions equals: assertingVariableData
]

{ #category : 'tests' }
RedoCardTest >> test02WhenARedoCardDoesAPermanentCardAgainThenItCanOnlyBePlayedDuringTheTurnOfTheShip [

	| aGame |
	aGame := self
				 gameDealing: {
						 Speed.
						 Redo }
				 rolling: { 3. 5 }.
	aGame player: aPlayer plays: (Speed createWith: aPlayer).
	self
		should: [
		aGame player: anotherPlayer plays: (Redo createWith: anotherPlayer) ]
		raiseErrorWithMessageText:
		'Permanent cards can only be played during the turn of the ship.'.
	self assert: (aGame cardsFeatureOf: anotherPlayer) deck size equals: 2
]

{ #category : 'tests' }
RedoCardTest >> test03WhenTheLastCardPlayedWasARedoThenANewRedoDoesAgainTheCardThatTookEffect [

	| aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 6, Lap: 0'.
							 'Name: Tomi, Position: 7, Lap: 0' }.
	aGame := self
				 gameDealing: {
						 Speed.
						 Redo }
				 rolling: { 3. 5 }.
	aGame player: aPlayer plays: (Speed createWith: aPlayer).
	aGame player: aPlayer plays: (Redo createWith: aPlayer).
	self play: 1 in: aGame.
	aGame player: anotherPlayer plays: (Redo createWith: anotherPlayer).
	self play: 1 in: aGame.
	self assert: aGame playerPositions equals: assertingVariableData
]

{ #category : 'tests' }
RedoCardTest >> test04WhenNoCardWasPlayedThenTryingToPlayARedoCardRaisesError [

	| aGame |
	aGame := self gameDealing: { Redo } rolling: { 3 }.
	self
		should: [ aGame player: aPlayer plays: (Redo createWith: aPlayer) ]
		raiseErrorWithMessageText: 'There is no card played to do it again.'
]

{ #category : 'tests' }
RedoCardTest >> test05WhenARedoCardDoesAnInstantCardAgainThenItCanBePlayedOutOfTheTurnOfTheShip [

	| aGame |
	aTileListCreator at: 12 put: BlackHole create.
	aGame := self
				 gameDealing: {
						 Repeat.
						 Redo }
				 rolling: { 11 }.
	self play: 1 in: aGame.
	aGame player: aPlayer plays: (Repeat createWith: aPlayer).
	aGame player: aPlayer plays: (Redo createWith: aPlayer).
	self assert: (aGame positionFeatureOf: aPlayer) position equals: 1
]

{ #category : 'tests' }
RedoCardTest >> test06WhenARedoCardDoesACancellationAgainThenItCancelsTheNewChosenCard [

	| aGame assertingVariableData |
	assertingVariableData := { 'Name: Juan, Position: 8, Lap: 0'.
							 'Name: Tomi, Position: 6, Lap: 0' }.
	aGame := self
				 gameDealing: {
						 Speed.
						 Cancellation.
						 Redo.
						 Acceleration }
				 rolling: { 3. 5 }.
	aGame player: aPlayer plays: (Speed createWith: aPlayer).
	self play: 1 in: aGame.
	aGame player: anotherPlayer plays: Acceleration create.
	aGame player: aPlayer plays: (Cancellation createWith: Acceleration create).
	aGame
		player: anotherPlayer
		plays: (Redo createWith: (Speed createWith: aPlayer)).
	self play: 2 in: aGame.
	self assert: aGame playerPositions equals: assertingVariableData
]
