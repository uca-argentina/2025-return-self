Class {
	#name : 'Redo',
	#superclass : 'InstantCard',
	#instVars : [
		'chosenShip'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'play interface' }
Redo >> applyBonusUsing: aUselessArgument and: cardManager [

]

{ #category : 'testing' }
Redo >> isRedo [

	^ true
]

{ #category : 'as yet unclassified' }
Redo >> sameTypeOfCard: aCard [

	^ aCard isRedo
]

{ #category : 'as yet unclassified' }
Redo >> setupWith: context [

	context asOrderedCollection size = 1 ifFalse: [
		Error signal: 'Wrong amount of parameters for this card' ].
	context isShip ifFalse: [
		Error signal: 'Wrong type or order of parameters' ].
	chosenShip := context
]
