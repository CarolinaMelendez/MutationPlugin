Class {
	#name : #DTTestMutationResult,
	#superclass : #DTPluginResult,
	#instVars : [
		'aliveMutants',
		'killedMutants',
		'percentageResult',
		'mutationScore'
	],
	#category : #'DrTests-TestMutation-Base'
}

{ #category : #accessing }
DTTestMutationResult >> aliveMutants [

	^  aliveMutants 
]

{ #category : #accessing }
DTTestMutationResult >> aliveMutants: mutantsList [

	aliveMutants := mutantsList
]

{ #category : #accessing }
DTTestMutationResult >> buildTreeForUI [
	<dtTestCoverageResultTreeNamed: 'List of uncovered methods' order: 1>
	^ DTTreeNode new
		subResults: 
        {(DTTreeNode new
            name: 'Mutation score: ' , self mutationScore ;
            subResults: {};
            yourself).
		  (DTTreeNode new
            name: 'killed mutants';
            subResults: (self killedMutants collect: [:each | DTTestMutationLeafNode content: each]);
            yourself).
		(DTTreeNode new
            name: 'alive mutants';
            subResults: (self aliveMutants collect: [:each | DTTestMutationLeafNode content: each]);
            yourself) }
]

{ #category : #accessing }
DTTestMutationResult >> killedMutants [

	^  killedMutants 
]

{ #category : #accessing }
DTTestMutationResult >> killedMutants: mutantsList [

	killedMutants := mutantsList
]

{ #category : #accessing }
DTTestMutationResult >> mutationScore [ 

	^  mutationScore 
]

{ #category : #accessing }
DTTestMutationResult >> mutationScore: aString [

	mutationScore := aString
]

{ #category : #accessing }
DTTestMutationResult >> percentageResult [

	^  percentageResult 
]

{ #category : #accessing }
DTTestMutationResult >> percentageResult: mutantsList [

	percentageResult := mutantsList
]
