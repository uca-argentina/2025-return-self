"
A mock object for simulation of a ""random"" throw of a Die
"
Class {
	#name : 'LoadedDie',
	#superclass : 'Object',
	#instVars : [
		'throwResult'
	],
	#category : 'IngSoft2-Model-Base',
	#package : 'IngSoft2-Model',
	#tag : 'Base'
}

{ #category : 'creation' }
LoadedDie class >> createWith: aNumberToThrow [

	self validate: aNumberToThrow.
	^ self new initializeWith: aNumberToThrow
]

{ #category : 'validation' }
LoadedDie class >> validate: aNumberToThrow [

	aNumberToThrow < 1 ifTrue: [
		Error signal: 'The die cannot throw a number lower than 1.' ]
]

{ #category : 'initialization' }
LoadedDie >> initializeWith: aNumberToThrow [

	throwResult := aNumberToThrow
]

{ #category : 'calculating' }
LoadedDie >> throw [

	^ throwResult
]
