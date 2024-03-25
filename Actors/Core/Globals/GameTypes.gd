class_name GameTypes
extends RefCounted

enum CellType 
{
	CT_FREE = 0,
 	CT_WALL = 1,
 	CT_START = 2,
 	CT_FINISH = 3
}
enum CellInteractionType 
{
	CIT_FREE = 0,
	CIT_CONSIDERING = 1,
	CIT_CONSIDERED = 2, 
	CIT_CONSIDERING_CURRENT
}
enum HeuristicFunctionType 
{
	HCT_Euclidean, 
	HCT_Manhattan
}

enum SearchAlgorithmType
{
	SAT_A_STAR,
	SAT_BREADTH_FIRST_SEARCH,
	SAT_DEEP_FIRST_SEARCH
}
