"
A dice Object
"
Class {
	#name : 'Dice',
	#superclass : 'Object',
	#instVars : [
		'numberOfFaces'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Dice class >> faces: numberOfFaces [
	|dice|
	dice:= self new.
	dice numberOfFaces: numberOfFaces.
	^dice.
]

{ #category : 'accessing' }
Dice >> numberOfFaces: number [
	numberOfFaces:=number.

]

{ #category : 'accessing' }
Dice >> throw [
^Random new nextIntegerBetween: 1 and: numberOfFaces .  
]
