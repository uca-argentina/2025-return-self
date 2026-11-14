Class {
	#name : 'Card',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Card class >> create [

	^ self new
]

{ #category : 'testing' }
Card >> assertHasTarget: aTarget [

	aTarget ifNil: [
		Error signal: 'This card needs a target to be played.' ]
]

{ #category : 'playing' }
Card >> playedBy: aShip in: aGame [

	self subclassResponsibility
]

{ #category : 'comparing' }
Card >> sameTypeOfCard: aCard [

	^ self class = aCard class
]

{ #category : 'setup' }
Card >> setupWith: aTarget [

	self subclassResponsibility
]
