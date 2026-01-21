Class {
	#name : 'DieTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DieTest >> test001WhenThrowingADieItReturnsARandomNumberBetween1AndTheGreaterFace [

	| aDie |
	aDie := Die createWith: 6.
	1 to: 20 do: [ :x | self assert: (aDie throw between: 1 and: 6) ]
]

{ #category : 'tests' }
DieTest >> test002WhenTryingToCreateADieWithFacesLowerThan4ItRaisesAnError [

	TestUtils
		should: [ Die createWith: -2 ]
		raiseWith: 'Minimum amount of faces should be 4.'
]

{ #category : 'tests' }
DieTest >> test003WhenThrowingALoeadedDieItReturnsTheIndicatedNumber [

	| aDie |
	aDie := LoadedDie createWith: 4.
	1 to: 20 do: [ :x | self assert: aDie throw equals: 4 ]
]

{ #category : 'tests' }
DieTest >> test004WhenTryingToCreateALoadedDieWithAThrowLowerThan1ItRaisesAnError [

	TestUtils
		should: [ LoadedDie createWith: 0 ]
		raiseWith: 'The die cannot throw a number lower than 1.'
]
