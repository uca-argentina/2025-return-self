Class {
	#name : 'DistanceTest',
	#superclass : 'ReturnSelfTestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DistanceTest >> test01WhenADistanceInParsecsIsAskedForItsParsecsThenItAnswersItsAmount [

	self assert: (Parsecs of: 7) asParsecs equals: 7
]

{ #category : 'tests' }
DistanceTest >> test02WhenADistanceInLightYearsIsAskedForItsParsecsThenThreeLightYearsMakeOneParsec [

	self assert: (LightYears of: 9) asParsecs equals: 3
]

{ #category : 'tests' }
DistanceTest >> test03WhenTryingToCreateANegativeDistanceThenItRaisesError [

	self
		should: [ Parsecs of: -1 ]
		raiseErrorWithMessageText: 'A distance cannot be negative.'.
	self
		should: [ LightYears of: -1 ]
		raiseErrorWithMessageText: 'A distance cannot be negative.'
]
