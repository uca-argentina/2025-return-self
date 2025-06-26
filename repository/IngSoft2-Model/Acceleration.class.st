Class {
	#name : 'Acceleration',
	#superclass : 'PermanentCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Acceleration class >> createWith: anId [

	^ self new initializeWith: anId
]

{ #category : 'as yet unclassified' }
Acceleration >> applyBonusUsing: data [
"
	^ aTotalThrow + 1"
	self shouldBeImplemented 
]

{ #category : 'as yet unclassified' }
Acceleration >> equalsACard: aCard [

	^ self sameTypeOfCard: aCard
]

{ #category : 'initialization' }
Acceleration >> initializeWith: anId [

	cardId := anId
]

{ #category : 'testing' }
Acceleration >> isAcceleration [

	^ true
]

{ #category : 'as yet unclassified' }
Acceleration >> sameTypeOfCard: aCard [

	^ aCard isAcceleration
]

{ #category : 'as yet unclassified' }
Acceleration >> setupWith: context [

	^ self class new
]

{ #category : 'as yet unclassified' }
Acceleration >> tagPermanentCard: anId [

	^ self class createWith: 0 "Reserved tag for global impact"
]
