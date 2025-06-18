Class {
	#name : 'DiceCreationTest',
	#superclass : 'ReturnSelfTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DiceCreationTest >> test01CreationOfDice [

	self
		should: [ Dice faces: -10 ]
		raiseErrorWithMessageText:
		'The number of faces must be greater than two.'
]
