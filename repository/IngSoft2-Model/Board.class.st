Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'tiles'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Board class >> boardLengthMustBeGreaterThanThree: aLength [

	aLength > 3 ifFalse: [
		Error signal: 'The board length must be greater than three.' ]
]

{ #category : 'creation' }
Board class >> createWithTiles: aNumberOfTiles [
	| rng cumulativeProbs effectClasses aSetOfTiles|
	self boardLengthMustBeGreaterThanThree: aNumberOfTiles.
	rng := Random new.
	effectClasses := {
		                 AtomikBomb.
		                 BlackHole.
		                 HyperJump.
		                 HyperSpaceJump.
		                 MoonWalk.
		                 NoEffect }.

	cumulativeProbs := Array new: effectClasses size.
	effectClasses withIndexDo: [ :cls :i |
		| acum |
		acum := (i = 1
			         ifTrue: [ 0 ]
			         ifFalse: [ cumulativeProbs at: i - 1 ])
		        + cls effectProbability.
		cumulativeProbs at: i put: acum ].

	"2. Para cada casilla, sortear un efecto con peso:"
	aSetOfTiles := (1 to: aNumberOfTiles) collect: [ :idx |
		         | r chosenClass |
		         r := rng next. "Número real [0,1)"
		         chosenClass := effectClasses
			                        detect: [ :cls |
			                        r
			                        <=
			                        (cumulativeProbs at:
				                         (effectClasses indexOf: cls)) ]
			                        ifNone: [ effectClasses last ]. "por redondeo"
		         chosenClass createOnTile: idx "instancia de efecto" ].
	^ self new initializeWithTiles: aSetOfTiles
]

{ #category : 'positioning' }
Board >> applyEffectTriggeredByPlayerAt: anIndex to: players [

	| detectedEffect aPlayerPosition |
	aPlayerPosition := (players at: anIndex) position.
	detectedEffect := tiles detect: [ :effect |
		                  effect tiles includes: aPlayerPosition ].
	^ detectedEffect applyEffectOn: players triggeredByPlayerAt: anIndex
]

{ #category : 'initialization' }
Board >> initializeWithTiles: aSetOfTiles [

    tiles := aSetOfTiles.


]

{ #category : 'accessing' }
Board >> tiles [ 
^tiles
]

{ #category : 'accessing' }
Board >> totalTiles [
	^ tiles size.
]
