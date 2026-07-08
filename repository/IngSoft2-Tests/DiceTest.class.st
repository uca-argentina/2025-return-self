Class {
	#name : 'DiceTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DiceTest >> test015WhenTryingToCreateAnEmptySetOfDiceItRaisesError [
TestUtils
		should: [ Dice createWith: {} ]
		raiseWith: 'There is should be at least one die in the set.'
]

{ #category : 'tests' }
DiceTest >> test016WhenThrowingDiceTheResultShouldBeTheSumOfAllIndividualDieFaces [

	| dice |
	dice := Dice createWith: {
			        (LoadedDie createWith: 4).
			        (LoadedDie createWith: 6) }.
	self assert: dice throw equals: 10
]

{ #category : 'tests' }
DiceTest >> test017WhenThrowingDiceTheResultShouldBeBetweenTheSumOfTheMinimumFaceAndTheSumOfTheGreatest [

	| dice |
	dice := Dice createWith: {
			        (Die createWith: 8).
			        (Die createWith: 4) }.
	self assert: (dice throw between: 2 and: 12)
]
