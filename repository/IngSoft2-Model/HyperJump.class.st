Class {
	#name : 'HyperJump',
	#superclass : 'Effect',
	#instVars : [
		'buffList',
		'actualBuffIndex'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
HyperJump class >> create [

	^ self createWith: {
			(Parsecs of: 13).
			(Parsecs of: 9).
			(Parsecs of: 5) }
]

{ #category : 'creation' }
HyperJump class >> createWith: aListOfDistances [

	self mustHaveAtLeastOneDistance: aListOfDistances.
	self distancesMustGoFromHighestToLowest: aListOfDistances.
	^ self new initializeEffectWith: aListOfDistances
]

{ #category : 'testing' }
HyperJump class >> distancesMustGoFromHighestToLowest: aListOfDistances [

	| parsecs |
	parsecs := aListOfDistances collect: [ :distance | distance asParsecs ].
	(2 to: parsecs size) do: [ :index |
		(parsecs at: index) > (parsecs at: index - 1) ifTrue: [
			Error signal: 'HyperJump distances must go from highest to lowest.' ] ]
]

{ #category : 'creation' }
HyperJump class >> effectProbability [

	^ 0.06
]

{ #category : 'testing' }
HyperJump class >> mustHaveAtLeastOneDistance: aListOfDistances [

	aListOfDistances isEmpty ifTrue: [
		Error signal: 'HyperJump needs at least one distance.' ]
]

{ #category : 'positioning' }
HyperJump >> applyEffectOn: aPlayer and: aGame [

	aGame advance: aPlayer by: (buffList at: actualBuffIndex)
]

{ #category : 'positioning' }
HyperJump >> applyEffectOnEvery: aGroupOfPlayers and: aGame [

	super applyEffectOnEvery: aGroupOfPlayers and: aGame.
	self nextBuff
]

{ #category : 'initialization' }
HyperJump >> initializeEffectWith: aListOfDistances [

	buffList := aListOfDistances.
	actualBuffIndex := 1
]

{ #category : 'interaction loop' }
HyperJump >> nextBuff [

	actualBuffIndex := actualBuffIndex \\ buffList size + 1
]
