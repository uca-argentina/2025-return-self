Class {
	#name : 'Card',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Card class >> create [
^self new
]

{ #category : 'as yet unclassified' }
Card >> applyBonus [

self subclassResponsibility.
]

{ #category : 'testing' }
Card >> isAcceleration [

^false
]

{ #category : 'testing' }
Card >> isCancellation [

^false
]

{ #category : 'testing' }
Card >> isMercenary [

^false
]

{ #category : 'testing' }
Card >> isNoCard [

^false
]

{ #category : 'testing' }
Card >> isRedo [

^false
]

{ #category : 'testing' }
Card >> isRepeat [

^false
]

{ #category : 'testing' }
Card >> isSpeed [

^false
]

{ #category : 'as yet unclassified' }
Card >> sameTypeOfCard: aCard [

	self subclassResponsibility
]
