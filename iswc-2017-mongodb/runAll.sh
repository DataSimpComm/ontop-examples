#! /bin/sh

# Single file to run all systems over all datasets, with all arguments hard-coded.
# Alternatively, use run.sh for a specific system/dataset/set of arguments.

numberOfRuns=10

#virtuosoEndPoint="http://obdalin.inf.unibz.it:8890/sparql"
virtuosoEndPoint="http://localhost:8890/sparql"

virtuosoExec="virtuoso/virtuoso-1.0-SNAPSHOT-jar-with-dependencies.jar"
ontopMongoExec="ontop-mongo/ontop-mongo-benchmark-1.0-SNAPSHOT.jar"
drillExec="drill/drill-sql-runner-all-1.0-SNAPSHOT.jar"
morphExec="morph/morph-xr2rml-dist-1.0-SNAPSHOT-jar-with-dependencies.jar"

wd=`dirname $0`

#sparqlQueriesDir:$1
#drillQueriesDir:$2
#virtuosoOutputDir:$3
#morphOutputDir:$4
#drillOutputDir:$5
#ontopMongoOutputDir:$6
#virtuosoGraph:$7
#ontopMongoMappingFile:$8
#morphMappingFile:$9
#ontopMongoPropertyFile:$10
#morphPropertyFile:$11
#ontopMongoConstraintsFile:$12
#ontopMongoOntologyFile:$13
#queryTimeOut:$14
#runVirtuoso:$15
#runOntopMongo:$16
#runDrill:$17
#runMorph:$18
runDataset (){

	#Run Virtuoso 
	if [ "$15" = true ]; then
		$wd/run.sh -v -g $7 -u $virtuosoEndPoint $virtuosoExec $1 $3 $numberOfRuns
	fi
		
	#Run Ontop-mongo
	if [ "$16" = true ]; then
		options="-n -a $8 -p $10 -i $14" 
		if [ "$12" != noFile ]; then
			options="$options -c $12"  		
		fi
		if [ "$13" != noFile ]; then
			options="$options -t $13"  		
		fi
		command="$wd/run.sh $options $ontopMongoExec $1 $6 $numberOfRuns"
		eval "$command"
	fi

	#Run Drill
	if [ "$17" = true ]; then
		$wd/run.sh -d $drillExec $2 $5 $numberOfRuns
	fi	
		
	#Run Morph	
	if [ "$18" = true ]; then
		$wd/run.sh -m -p $11 -a $9 $morphExec $1 $4 $numberOfRuns
	fi	

}


runAwards (){
command="runDataset"  
#sparqlQueriesDir
command="$command $wd/data/awards/queries/sparql"
#drillQueriesDir
command="$command $wd/data/awards/queries/drill"
#virtuosoOutputDir
command="$command $wd/data/awards/eval/virtuoso"
#morphOutputDir
command="$command $wd/data/awards/eval/morph"
#drillOutputDir
command="$command $wd/data/awards/eval/drill"
#ontopMongoOutputDir
command="$command $wd/data/awards/eval/ontop-mongo"
#virtuosoGraph
command="$command http://awards.org"
#ontopMongoMappingFile
command="$command $wd/data/awards/mapping/ontop-mongo/mapping.json"
#morphMappingFile
command="$command $wd/data/awards/mapping/morph/awards-mapping.ttl"
#ontopMongoPropertyFile
command="$command $wd/data/awards/prop/ontop-mongo/properties"
#MorphPropertyFile
command="$command $wd/data/awards/prop/morph/morph.properties"
#ontopMongoConstraintFile
command="$command noFile"
#ontopMongoOntologyFile
command="$command $wd/data/awards/awards.ttl"
#queryTimeOut
command="$command 500"
#runVirtuoso
command="$command false" 
#runOntopMongo
command="$command false"
#runDrill
command="$command false"
#runMorph
command="$command true"

eval "$command"
}

runDBLP (){
config="$1"

command="runDataset"  
#sparqlQueriesDir
command="$command $wd/data/dblp/queries/sparql"
#drillQueriesDir
command="$command $wd/data/dblp/queries/drill/$config"
#virtuosoOutputDir
command="$command $wd/data/dblp/$config/eval/virtuoso"
#morphOutputDir
command="$command $wd/data/dblp/$config/eval/morph"
#drillOutputDir
command="$command $wd/data/dblp/$config/eval/drill"
#ontopMongoOutputDir
command="$command $wd/data/dblp/$config/eval/ontop-mongo"
#virtuosoGraph
command="$command http://dblp.org"
#ontopMongoMappingFile
command="$command $wd/data/dblp/$config/mapping/ontop-mongo/dblp-mapping-$config.json"
#morphMappingFile
command="$command $wd/data/dblp/$config/mapping/morph/dblp-mapping-$config.ttl"
#ontopMongoPropertyFile
command="$command $wd/data/dblp/$config/prop/ontop-mongo/properties"
#morphPropertyFile
command="$command $wd/data/dblp/$config/prop/morph/morph.properties"
#ontopMongoConstraintFile
command="$command $wd/data/dblp/$config/constraints.json"
#ontopMongoOntologyFile
command="$command noFile"
#queryTimeOut
command="$command 500"
#runVirtuoso
command="$command false" 
#runOntopMongo
command="$command false"
#runDrill
command="$command false"
#runMorph
command="$command true"

eval "$command"
}

runBSBM (){

size=$1

command="runDataset"  
#sparqlQueriesDir
command="$command $wd/data/bsbm/queries/sparql"
#drillQueriesDir
command="$command $wd/data/bsbm/queries/drill"
#virtuosoOutputDir
command="$command $wd/data/bsbm/$size/eval/virtuoso"
#morphOutputDir
command="$command $wd/data/bsbm/$size/eval/morph"
#drillOutputDir
command="$command $wd/data/bsbm/$size/eval/drill"
#ontopMongoOutputDir
command="$command $wd/data/bsbm/$size/eval/ontop-mongo/"
#virtuosoGraph
command="$command http://bsbm$size.org"
#ontopMongoMappingFile
command="$command $wd/data/bsbm/mapping/ontop-mongo/mapping.json"
#morphMappingFile
command="$command $wd/data/bsbm/mapping/morph/awards-mapping.ttl"
#ontopMongoPropertyFile
command="$command $wd/data/bsbm/$size/prop/ontop-mongo/properties"
#morphPropertyFile
command="$command $wd/data/bsbm/$size/prop/morph/morph.properties"
#ontopMongoConstraintFile
command="$command $wd/data/bsbm/constraints.json"
#ontopMongoOntologyFile
command="$command noFile"
#queryTimeOut
command="$command 500"
#runVirtuoso
command="$command false" 
#runOntopMongo
command="$command true"
#runDrill
command="$command false"
#runMorph
command="$command false"

eval "$command"
}

runAllDBLP (){
runDBLP "authors" 
#runDBLP "publications" 
#runDBLP "authors-publications" 
}

runAllBSBM () {
	runBSBM 10000 
#	runBSBM 100000 
#	runBSBM 1000000 
}	

#runAwards
runAllDBLP
#runAllBSBM

# EOF