Class {
	#name : 'Repeat',
	#superclass : 'InstantCard',
	#instVars : [
		'chosenShip'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Repeat >> isRepeat [

	^ true
]

{ #category : 'as yet unclassified' }
Repeat >> replicateEffect: arg1 targeting: arg2 using: arg3 [

	arg1 applyEffectOn: arg2 and: arg3
]

{ #category : 'as yet unclassified' }
Repeat >> sameTypeOfCard: aCard [

	^ aCard isRepeat
]

{ #category : 'as yet unclassified' }
Repeat >> setupWith: context [

	context asOrderedCollection size = 1 ifFalse: [
		Error signal: 'Wrong amount of parameters for this card' ].
	context isShip ifFalse: [
		Error signal: 'Wrong type or order of parameters' ].
	chosenShip := context
]
