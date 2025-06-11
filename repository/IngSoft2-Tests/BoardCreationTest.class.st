Class {
	#name : 'BoardCreationTest',
	#superclass : 'InstanceCreationTest',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BoardCreationTest >> testWhenTryingToCreateABoardWithLengthLowerThanThreeThenItRaisesError [

	self
		should: [ Board createWithTiles: 2 ]
		raiseErrorWithMessageText:
		'The board length must be greater than three.'
]

{ #category : 'tests' }
BoardCreationTest >> testWhenTryingToCreateATestBoardWithLengthLowerThanThreeThenItRaisesError [

	self
		should: [ BoardForTesting createWithTiles: 2 andEffects: {}]
		raiseErrorWithMessageText:
		'The board length must be greater than three.'
]
