Class {
	#name : #DTTestMutationResult,
	#superclass : #DTPluginResult,
	#instVars : [
		'aliveMutants'
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
            name: ' Mutants';
            subResults: {};
            yourself).
        (DTTreeNode new
            name: 'alive mutants';
            subResults: (self aliveMutants collect: [:each | DTTestMutationLeafNode content: each]);
            yourself) }
]
