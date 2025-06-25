Class {
	#name : 'Effect',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Effect class >> create [

	^ self new
]

{ #category : 'creation' }
Effect class >> effectProbability [

self subclassResponsibility.
]

{ #category : 'positioning' }
Effect >> applyEffectOn: aPlayer using: positionManager and: battleManager and: turnManager and: cardManager [

self subclassResponsibility.
]

{ #category : 'testing' }
Effect >> isAtomikBomb [

	^ false
]

{ #category : 'testing' }
Effect >> isBlackHole [

	^ false
]

{ #category : 'testing' }
Effect >> isCardGiver [

	^ false
]

{ #category : 'testing' }
Effect >> isHyperJump [

	^ false
]

{ #category : 'testing' }
Effect >> isHyperSpaceJump [

	^ false
]

{ #category : 'testing' }
Effect >> isMoonWalk [

	^ false
]

{ #category : 'testing' }
Effect >> isNoEffect [

	^ false
]

{ #category : 'testing' }
Effect >> isWormhole [

	^ false
]
