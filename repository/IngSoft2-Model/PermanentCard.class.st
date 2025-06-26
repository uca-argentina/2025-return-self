Class {
	#name : 'PermanentCard',
	#superclass : 'Card',
	#instVars : [
		'cardId'
	],
	#category : 'IngSoft2-Model-Objects',
	#package : 'IngSoft2-Model',
	#tag : 'Objects'
}

{ #category : 'as yet unclassified' }
PermanentCard >> applyBonusUsing: anArgument [

	self subclassResponsibility
]

{ #category : 'as yet unclassified' }
PermanentCard >> equalsACard: aCard [

	self subclassResponsibility
]

{ #category : 'testing' }
PermanentCard >> isPermanentCard [

	^ true
]

{ #category : 'comparing' }
PermanentCard >> sameTypeOfCard: aCard [

	self subclassResponsibility
]

{ #category : 'as yet unclassified' }
PermanentCard >> setupWith: context [

	self subclassResponsibility
]

{ #category : 'as yet unclassified' }
PermanentCard >> tagPermanentCard: anId [

	self subclassResponsibility
]
