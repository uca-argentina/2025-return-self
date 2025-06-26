Class {
	#name : 'Acceleration',
	#superclass : 'PermanentCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Acceleration class >> createWithAnId: anId and: anotherId [
	^ self new initializeWith: 0
]

{ #category : 'as yet unclassified' }
Acceleration >> applyBonusUsing: arg1 [

	^ arg1 + 1
]

{ #category : 'initialization' }
Acceleration >> initializeWith: anId [


	shipId := anId.

]

{ #category : 'testing' }
Acceleration >> isAcceleration [

	^ true
]

{ #category : 'as yet unclassified' }
Acceleration >> sameTypeOfCard: aCard [

	^ aCard isAcceleration
]

{ #category : 'accessing' }
Acceleration >> shipId [

	^ '<an unprintable nonliteral value>'
		  runtimeUndeclaredReadInContext: thisContext
]
