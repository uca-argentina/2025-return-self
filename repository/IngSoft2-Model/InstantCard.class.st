Class {
	#name : 'InstantCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model-Objects',
	#package : 'IngSoft2-Model',
	#tag : 'Objects'
}

{ #category : 'play interface' }
InstantCard >> applyBonusUsing: aManager [

	self subclassResponsibility
]

{ #category : 'as yet unclassified' }
InstantCard >> equalsACard: aCard [

	self subclassResponsibility
]

{ #category : 'testing' }
InstantCard >> isInstantCard [

	^ true
]

{ #category : 'comparing' }
InstantCard >> sameTypeOfCard: aCard [

	self subclassResponsibility
]

{ #category : 'as yet unclassified' }
InstantCard >> setupWith: context [

	self subclassResponsibility
]
