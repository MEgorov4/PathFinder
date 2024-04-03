class_name GameTypes
extends RefCounted

enum CellType 
{
	CT_FREE = 0,
 	CT_WALL = 1,
	CT_WEIGHT = 2,
 	CT_START = 3,
 	CT_FINISH = 4
}

enum CellInteractionType 
{
	CIT_FREE = 0,
	CIT_CONSIDERING = 1,
	CIT_CONSIDERED = 2, 
	CIT_CONSIDERING_CURRENT = 3
}

enum HeuristicFunctionType 
{
	HCT_Euclidean = 0, 
	HCT_Manhattan = 1,
	HCT_Chebyshev = 2
}

enum SearchAlgorithmType
{
	SAT_A_STAR = 0,
	SAT_BREADTH_FIRST_SEARCH = 1,
	SAT_DEEP_FIRST_SEARCH = 2,
	SAT_DIJKSTRA = 3,
	SAT_BEST_FIRST_SEARCH = 4
}

enum MapMouseInteractionType 
{
	IT_CLEARING = 0, 
	IT_PLACING_WALL = 1,
	IT_PLACING_WEIGHT = 2 
}
