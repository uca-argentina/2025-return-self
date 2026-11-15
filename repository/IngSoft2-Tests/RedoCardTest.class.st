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
