"
A board class
"
Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'aLength'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'Creation' }
Board class >> withLenght: maxLength [

	^ self new initializeWithLength: maxLength
]

{ #category : 'initialization' }
Board >> initializeWithLength: maxLength [

	aLength := maxLength
]

{ #category : 'getters' }
Board >> lenght [

	^ aLength
]
