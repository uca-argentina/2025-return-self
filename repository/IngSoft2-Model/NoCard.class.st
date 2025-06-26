Class {
	#name : 'NoCard',
	#superclass : 'InstantCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'play interface' }
NoCard >> applyBonusUsing: anArgument and: anotherArgument [

]

{ #category : 'testing' }
NoCard >> isNoCard [

	^ true
]

{ #category : 'testing' }
NoCard >> sameTypeOfCard: aCard [

	^ aCard isNoCard
]
