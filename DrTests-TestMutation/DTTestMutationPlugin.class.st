Class {
	#name : #DTTestMutationPlugin,
	#superclass : #DrTestsPlugin,
	#category : #'DrTests-TestMutation-Base'
}

{ #category : #'api - accessing' }
DTTestMutationPlugin class >> pluginName [

	^ 'Test Mutation'
]

{ #category : #'api - accessing' }
DTTestMutationPlugin class >> pluginResultClass [

	^ DTTestMutationResult
]

{ #category : #'api - accessing' }
DTTestMutationPlugin class >> weight [

	^ 3
]

{ #category : #accessing }
DTTestMutationPlugin >> pragmaForResultTrees [
	^ #'dtTestMutationResultTreeNamed:order:'
]

{ #category : #api }
DTTestMutationPlugin >> resultButtonHelp [
	^ 'Browse the mutation selected in the results list.' translated
]

{ #category : #api }
DTTestMutationPlugin >> runForConfiguration: aDTpluginConfiguration [

	| analysis alive testCases classesToMutate result|
	 testCases :=  { UUIDPrimitivesTest }.
	 classesToMutate := {UUIDGenerator }.

	 analysis := MutationTestingAnalysis
    	testCasesFrom: testCases
    	mutating: classesToMutate
    	using: MutantOperator contents
    	with: AllTestsMethodsRunningMutantEvaluationStrategy new.

	 analysis run.

"To retrieve the alive mutations"
alive := analysis generalResult aliveMutants.



	result := self pluginResultClass new.
	"self defineData: aDTpluginConfiguration."
	
	result
		aliveMutants: alive .

	^ result
]

{ #category : #api }
DTTestMutationPlugin >> startButtonHelp [
	^ 'Run mutation in selected items' translated
]

{ #category : #api }
DTTestMutationPlugin >> startButtonLabel [
	^ 'Run Mutation' translated
]
