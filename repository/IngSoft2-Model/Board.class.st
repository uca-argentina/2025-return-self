"
A board class
"
Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'length',
		'wormhole'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Board class >> lengthHasToBeGreaterThanThree: aLength [
	"To make sense, you cannot have only one lucky throw and win"

	aLength > 3 ifFalse: [
		Error signal: 'The length of the board must be greater than 3.' ]
]

{ #category : 'Creation' }
Board class >> withLenght: maxLength [ 
	| noEffectObject |
	
	self lengthHasToBeGreaterThanThree: maxLength.
	
	noEffectObject := NoEffect new.
	^ self new initializeWithLength: maxLength with: noEffectObject
]

{ #category : 'Creation' }
Board class >> withLenght: maxLength and: wormhole [
	
	self lengthHasToBeGreaterThanThree: maxLength.

	^ self new initializeWithLength: maxLength with:wormhole
]

{ #category : 'checking' }
Board >> checkEffects: aPosition [
 (wormhole isAffectedTiles: aPosition) ifTrue: [ ^wormhole ].
^NoEffect new.
]

{ #category : 'initialization' }
Board >> initializeWithLength: aMaxLength with: aWormhole [

	length := aMaxLength.
	wormhole := aWormhole. 
]

{ #category : 'accessing' }
Board >> lenght [

	^ length
]
