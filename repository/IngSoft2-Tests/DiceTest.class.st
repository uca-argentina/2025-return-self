Class {
	#name : 'DiceTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DiceTest >> testThrowDice [

	| aDice |
	aDice := Dice faces: 6.
	self assert: (aDice throw between: 1 and: 6)
]

{ #category : 'tests' }
DiceTest >> testThrowMultipleDie [

	| firstDice secondDice aSetOfDie |
	firstDice := Dice faces: 6.
	secondDice := Dice faces: 9.
	aSetOfDie := DieSet having: {
			             firstDice.
			             secondDice }.
	self assert: (aSetOfDie throw between: 2 and: 15)
]

{ #category : 'tests' }
DiceTest >> testThrowMultipleLoadedDie [

	| firstDice secondDice aSetOfDie |
	firstDice := LoadedDie rolling: 6.
	secondDice := LoadedDie rolling: 9.
	aSetOfDie := DieSet having: {
			             firstDice.
			             secondDice }.
	self assert: aSetOfDie throw equals: 15
]
