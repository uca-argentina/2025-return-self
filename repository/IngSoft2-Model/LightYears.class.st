Class {
	#name : 'LightYears',
	#superclass : 'Distance',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
LightYears class >> lightYearsPerParsec [

	^ 3
]

{ #category : 'converting' }
LightYears >> asParsecs [

	^ amount / self class lightYearsPerParsec
]
