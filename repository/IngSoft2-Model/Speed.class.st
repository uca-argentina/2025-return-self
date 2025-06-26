Class {
	#name : 'Speed',
	#superclass : 'PermanentCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Speed class >> createWithAnId: anId and: randomData [

	^ self new initializeWith: anId
]

{ #category : 'error testing' }
Speed class >> idShouldBeGreaterThanZero: anId [

	anId > 0 ifFalse: [
		Error signal: 'The SpaceShip ID should be greater than zero.' ]
]

{ #category : 'as yet unclassified' }
Speed >> applyBonusUsing: arg1 [

	^ arg1 + 1
]

{ #category : 'as yet unclassified' }
Speed >> equalsCard: arg1 [

	^ arg1 isSpeed and: arg1 shipId
		  =
			  ('<an unprintable nonliteral value>'
				   runtimeUndeclaredReadInContext: thisContext)
]

{ #category : 'initialization' }
Speed >> initializeWith: anId [


	shipId := anId.

]

{ #category : 'testing' }
Speed >> isSpeed [

	^ true
]

{ #category : 'as yet unclassified' }
Speed >> sameTypeOfCard: arg1 [

	^ arg1 isSpeed
]
