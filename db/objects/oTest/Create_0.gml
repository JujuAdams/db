dbA = DbCreate();
DbWrite(dbA, 10,    "test", 0, "test 2");
DbSave(dbA, "a.json", true, true);

dbB = DbLoad("a.json");
show_debug_message(DbRead(dbB, 0,    "test", 0, "test 2"));

show_debug_message(DbDebugString(dbB));
show_debug_message(__DbJSONVisualize([0, {aaa: {g: {}, b: {c: {}}}}, [[2], 3, [[[[],[],[],[]]]]], 4]));