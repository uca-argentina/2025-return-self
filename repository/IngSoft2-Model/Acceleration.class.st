Class {
	#name : 'Acceleration',
	#superclass : 'PermanentCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'bonus' }
Acceleration >> boost: aThrow of: aShip [

	^ aThrow + 1
]

{ #category : 'setup' }
Acceleration >> setupWith: aTarget [

	^ self class create
]
