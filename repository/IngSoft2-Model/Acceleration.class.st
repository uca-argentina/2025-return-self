Class {
	#name : 'Acceleration',
	#superclass : 'PermanentCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

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
