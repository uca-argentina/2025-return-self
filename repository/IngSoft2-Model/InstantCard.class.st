Class {
	#name : 'InstantCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model-Objects',
	#package : 'IngSoft2-Model',
	#tag : 'Objects'
}

{ #category : 'testing' }
InstantCard class >> isInstantCard [
^ true
]

{ #category : 'play interface' }
InstantCard >> applyBonusUsing: aCard and: anotherArgument [

	self subclassResponsibility
]

{ #category : 'testing' }
InstantCard >> isInstantCard [
	^ self class isInstantCard
]

{ #category : 'comparing' }
InstantCard >> sameTypeOfCard: aCard [

	self subclassResponsibility
]
