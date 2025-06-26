Class {
	#name : 'NoCard',
	#superclass : 'InstantCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'play interface' }
NoCard >> applyBonusUsing: aManager [
]

{ #category : 'as yet unclassified' }
NoCard >> equalsACard: aCard [

	^ self sameTypeOfCard: aCard
]

{ #category : 'testing' }
NoCard >> isNoCard [

	^ true
]

{ #category : 'testing' }
NoCard >> sameTypeOfCard: aCard [

	^ aCard isNoCard
]

{ #category : 'as yet unclassified' }
NoCard >> setupWith: context [

	Error signal: 'This is not a card to be setted up.'
]
