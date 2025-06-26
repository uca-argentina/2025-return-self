Class {
	#name : 'NoCard',
	#superclass : 'InstantCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
NoCard >> isNoCard [

	^ true
]

{ #category : 'testing' }
NoCard >> sameTypeOfCard: arg1 [

	^ arg1 isNoCard
]
