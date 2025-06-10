Class {
	#name : 'InstanceCreationTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
InstanceCreationTest >> should: anErrorBlock raiseErrorWithMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: Error
		withExceptionDo: [ :error |
			self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
InstanceCreationTest >> testCreationOfDice [

	self
		should: [ Dice faces: -10 ]
		raiseErrorWithMessageText:
		'The number of faces must be greater than two.'
]

{ #category : 'tests' }
InstanceCreationTest >> testTryingToRollLowerThanOneRaisesAnError [

	self
		should: [ LoadedDie rolling: 0 ]
		raiseErrorWithMessageText: 'The roll cant be lower than one.'.
	self
		should: [ LoadedDie rolling: -2 ]
		raiseErrorWithMessageText: 'The roll cant be lower than one.'
]

{ #category : 'tests' }
InstanceCreationTest >> testWhenTryingToCreateAGameWithABoardLengthLowerThanThreeThenItRaisesError [

	|  aWormhole aTestBoard |
	

	aWormhole := Wormhole oneEnd: 2 otherEnd: 3.

	self
		should: [
			aTestBoard := BoardForTesting
				              createWithTiles: 2
				              andEffects: { aWormhole } ]
		raiseErrorWithMessageText:
		'The board length must be greater than three.'
]

{ #category : 'tests' }
InstanceCreationTest >> testWhenTryingToCreateAGameWithTwoPlayersSharingIDThenItRaisesError [

	| anotherGroupOfPlayers aLoadedDie aTestBoard |
	aTestBoard := BoardForTesting createWithTiles: 20 andEffects: {  }.
	aLoadedDie := LoadedDie rolling: 4.
	anotherGroupOfPlayers := {
		                         (ShipPosition createWith: 12 and: 'Pedro').
		                         (ShipPosition createWith: 12 and: 'Juan') }.
	self
		should: [
			Game
				playedBy: anotherGroupOfPlayers
				withBoard: aTestBoard
				withSetOfDie: aLoadedDie
				withLaps: 1 ]
		raiseErrorWithMessageText:
		'You cant have different players with the same ID.'
]

{ #category : 'tests' }
InstanceCreationTest >> testWhenTryingToCreateAPlayerWithFloatPositionThenItThrowsError [

	self
		should: [ ShipPosition createWith: 1 and: 'Juan' and: 1.3 and: 0 ]
		raiseErrorWithMessageText:
		'Player position cannot be lower than 1 or a float number.'
]

{ #category : 'tests' }
InstanceCreationTest >> testWhenTryingToCreateAPlayerWithNegativePositionThenItThrowsError [

	self
		should: [ ShipPosition createWith: 1 and: 'Juan' and: -10 and: 0 ]
		raiseErrorWithMessageText:
		'Player position cannot be lower than 1 or a float number.'
]

{ #category : 'tests' }
InstanceCreationTest >> testWhenTryingToCreateAPlayerWithoutNameThenItThrowsError [

	self
		should: [ ShipPosition createWith: 1 and: '' ]
		raiseErrorWithMessageText: 'The name cannot be empty.'
]

{ #category : 'tests' }
InstanceCreationTest >> testWhenWeCreateAWormholeWithAtLeastOneEndLessThanOneThenItRaisesAnError [

	self
		should: [ Wormhole oneEnd: -10 otherEnd: 2 ]
		raiseErrorWithMessageText:
		'Both ends of the Wormhole must be greater than 1.'.
	self
		should: [ Wormhole oneEnd: 2 otherEnd: -10 ]
		raiseErrorWithMessageText:
		'Both ends of the Wormhole must be greater than 1.'.
	self
		should: [ Wormhole oneEnd: -10 otherEnd: -10 ]
		raiseErrorWithMessageText:
		'Both ends of the Wormhole must be greater than 1.'
]

{ #category : 'tests' }
InstanceCreationTest >> testWhenWeCreateAWormholeWithEqualEndsThenItRaisesAnError [

	self
		should: [ Wormhole oneEnd: 2 otherEnd: 2 ]
		raiseErrorWithMessageText: 'Wormhole ends must be different tiles.'
]
