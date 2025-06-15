Class {
	#name : 'BoardCreationTest',
	#superclass : 'ReturnSelfTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BoardCreationTest >> test01WhenTryingToCreateATestBoardWithLengthLowerThanThreeThenItRaisesError [

	self
		should: [ BoardForTesting createWithTiles: 2 andEffects: {}]
		raiseErrorWithMessageText:
		'The board length must be greater than three.'
]

{ #category : 'tests' }
BoardCreationTest >> test02WhenTryingToCreateABoardWithLengthLowerThanThreeThenItRaisesError [

	self
		should: [ Board createWithTiles: 2 ]
		raiseErrorWithMessageText:
		'The board length must be greater than three.'
]
