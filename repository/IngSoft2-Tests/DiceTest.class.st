Class {
	#name : 'DiceTest',
	#superclass : 'ReturnSelfTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DiceTest >> test01ThrowDice [

	| aDice |
	aDice := Dice faces: 6.
	self assert: (aDice throw between: 1 and: 6)
]

{ #category : 'tests' }
DiceTest >> test02ThrowMultipleDie [

	| firstDice secondDice aSetOfDie |
	firstDice := Dice faces: 6.
	secondDice := Dice faces: 9.
	aSetOfDie := DieSet having: {
			             firstDice.
			             secondDice }.
	self assert: (aSetOfDie throw between: 2 and: 15)
]
